source functions

# Get Tenant1 uuid
TENANT_NAME=tenant1
TENANT_UUID=$(get_tenant_uuid $TENANT_NAME)

# Create Network1
NET_NAME=network1
NET_UUID=$(create_network $TENANT_UUID $NET_NAME)

# Create Subnet1
SUB_NAME=subnet1
SUB_GATEWAY=1.1.1.1
SUB_CIDR=1.1.1.0/24
SUB_UUID=$(create_subnet $TENANT_UUID $NET_UUID $SUB_NAME \
           $SUB_GATEWAY $SUB_CIDR)

# Create Subnet2
SUB_NAME=subnet2
SUB_GATEWAY=1.1.2.1
SUB_CIDR=1.1.2.0/24
SUB_UUID=$(create_subnet $TENANT_UUID $NET_UUID $SUB_NAME \
           $SUB_GATEWAY $SUB_CIDR)

# Create Network2
NET_NAME=network2
NET_UUID=$(create_network $TENANT_UUID $NET_NAME)

# Create Subnet3
SUB_NAME=subnet3
SUB_GATEWAY=1.2.3.1
SUB_CIDR=1.2.3.0/24
SUB_UUID=$(create_subnet $TENANT_UUID $NET_UUID $SUB_NAME \
           $SUB_GATEWAY $SUB_CIDR)

# Get Tenant2 uuid
TENANT_NAME=tenant2
TENANT_UUID=`keystone tenant-list | grep " $TENANT_NAME " | awk '{ print $2 }'`

# Create Network3
NET_NAME=network3
NET_UUID=$(create_network $TENANT_UUID $NET_NAME)

# Create Subnet4
SUB_NAME=subnet4
SUB_GATEWAY=2.3.4.1
SUB_CIDR=2.3.4.0/24
SUB_UUID=$(create_subnet $TENANT_UUID $NET_UUID $SUB_NAME \
           $SUB_GATEWAY $SUB_CIDR)
