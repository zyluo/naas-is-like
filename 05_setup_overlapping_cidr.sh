source globals
source functions

# Set tenant to Tenant1
OS_TENANT_NAME=$TEN_2_NAME
OS_USERNAME=$TEN_2_NAME
OS_PASSWORD=$TEN_2_NAME

# Get public image uuid
# NOTE(zyluo): Upload an public Ubuntu image named $IMAGE_NAME
IMAGE_NAME=$PUB_IMAGE_NAME
IMAGE_UUID=$(get_image_uuid $IMAGE_NAME)

if [ -z $IMAGE_UUID ]
then
    echo "Image $IMAGE_NAME does not exist!"
    exit 1
fi

# NOTE(zyluo): ssh-keygen public key at ~/.ssh/id_rsa.pub
# Get keypair for Tenant1
KEYPAIR_NAME=$(get_keypair_name pub_key_$OS_TENANT_NAME)

if [ -z $KEYPAIR_NAME ]
then
    echo "Public SSH key does not exist at $KEYPAIR_PATH"
    exit 1
fi

EXT_NET_UUID=$(get_external_network_uuid $EXT_NET_NAME)

if [ -z $EXT_NET_NAME ]
then
    echo "External network $EXT_NET_NAME does not exist!"
    exit 1
fi

# Add icmp and tcp security group rules to default security group
add_default_sg_rules icmp -1 -1 0.0.0.0/0
add_default_sg_rules tcp 22 22 0.0.0.0/0

# Set env to Network3 / Subnet4
NET_NAME=$NET_3_NAME
NET_UUID=$(get_network_uuid $NET_NAME)
SUB_NAME=$SUB_4_NAME
SUB_UUID=$(get_subnet_uuid $SUB_NAME)

# Connect Subnet4 to the external network
ROUTER_NAME=$ROUTER_3_NAME
create_router $ROUTER_NAME
add_router_subnet_interface $ROUTER_NAME $SUB_UUID
set_router_gateway $ROUTER_NAME $EXT_NET_UUID

# Create vm4-5
VM_NAME=vm4_5
boot_instance_dhcp $NET_UUID $VM_NAME $IMAGE_UUID $FLAVOR_TYPE $KEYPAIR_NAME
FIXED_IP=$(nova list | grep "\s$VM_NAME\s" | awk '{ print $8 }' | \
           awk '{ split ($0, array, "=") } END { print array[2] }')
PORT_UUID=$(quantum port-list | grep "\"$FIXED_IP\"" | awk '{ print $2 }')
associate_public_ip_on_port $PORT_UUID $EXT_NET_UUID
