source globals
source functions

# Create networks Network1 and Network2
# Network1 will have Subnet1 with VM1_1 and VM1_2
# Network2 will have Subnet2 with VM2_1
# Verify connectivity from VM1_1 to VM1_2
# Verify isolation from VM1_1 to VM2_1

# Set tenant to Tenant1
OS_TENANT_NAME=$TEN_1_NAME
OS_USERNAME=$TEN_1_NAME
OS_PASSWORD=$TEN_1_NAME

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

# Set env to Network1 / Subnet1
NET_NAME=$NET_1_NAME
SUB_NAME=$SUB_1_NAME
SUB_UUID=$(get_subnet_uuid $SUB_NAME)

# Connect Subnet1 to the external network
ROUTER_NAME=$ROUTER_1_NAME
create_router $ROUTER_NAME
add_router_subnet_interface $ROUTER_NAME $SUB_UUID
set_router_gateway $ROUTER_NAME $EXT_NET_UUID

# Create vm1-1
VM_ADDR=1.1.1.10
VM_NAME=vm1_1
PORT_NAME=port_$VM_NAME
PORT_UUID=$(create_port $NET_NAME $SUB_UUID $PORT_NAME $VM_ADDR)
boot_instance $PORT_UUID $VM_NAME $IMAGE_UUID $FLAVOR_TYPE $KEYPAIR_NAME
associate_public_ip_on_port $PORT_UUID $EXT_NET_UUID

# Create vm1-2
VM_ADDR=1.1.1.20
VM_NAME=vm1_2
PORT_NAME=port_$VM_NAME
PORT_UUID=$(create_port $NET_NAME $SUB_UUID $PORT_NAME $VM_ADDR)
boot_instance $PORT_UUID $VM_NAME $IMAGE_UUID $FLAVOR_TYPE $KEYPAIR_NAME

# Change env to Network2 / Subnet2
NET_NAME=$NET_2_NAME
SUB_NAME=$SUB_2_NAME
SUB_UUID=$(get_subnet_uuid $SUB_NAME)

# Connect Subnet1 to the external network
ROUTER_NAME=$ROUTER_2_NAME
create_router $ROUTER_NAME
add_router_subnet_interface $ROUTER_NAME $SUB_UUID
set_router_gateway $ROUTER_NAME $EXT_NET_UUID

# Create vm2-3
VM_ADDR=1.2.2.30
VM_NAME=vm2_3
PORT_NAME=port_$VM_NAME
PORT_UUID=$(create_port $NET_NAME $SUB_UUID $PORT_NAME $VM_ADDR)
boot_instance $PORT_UUID $VM_NAME $IMAGE_UUID $FLAVOR_TYPE $KEYPAIR_NAME
