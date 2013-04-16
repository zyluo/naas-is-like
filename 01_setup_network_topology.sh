source globals
source functions

# Create public image
IMAGE_UUID=$(create_image $PUB_IMAGE_NAME)

if [ -z $IMAGE_UUID ]
then
    echo "Image $PUB_IMAGE_NAME does not exist!"
    exit 1
fi

# Get Tenant1 uuid
TENANT_NAME=$TEN_1_NAME
TENANT_UUID=$(get_tenant_uuid $TENANT_NAME)

# Create Network1
NET_NAME=$NET_1_NAME
NET_UUID=$(create_network $TENANT_UUID $NET_NAME)

# Create Subnet1
SUB_NAME=$SUB_1_NAME
SUB_GATEWAY=$SUB_1_PREFIX$GATEWAY_POSTFIX
SUB_CIDR=$SUB_1_PREFIX$CIDR_POSTFIX
SUB_UUID=$(create_subnet $TENANT_UUID $NET_UUID $SUB_NAME \
           $SUB_GATEWAY $SUB_CIDR)

# Create Subnet2
SUB_NAME=$SUB_2_NAME
SUB_GATEWAY=$SUB_2_PREFIX$GATEWAY_POSTFIX
SUB_CIDR=$SUB_2_PREFIX$CIDR_POSTFIX
SUB_UUID=$(create_subnet $TENANT_UUID $NET_UUID $SUB_NAME \
           $SUB_GATEWAY $SUB_CIDR)

# Create Network2
NET_NAME=$NET_2_NAME
NET_UUID=$(create_network $TENANT_UUID $NET_NAME)

# Create Subnet3
SUB_NAME=$SUB_3_NAME
SUB_GATEWAY=$SUB_3_PREFIX$GATEWAY_POSTFIX
SUB_CIDR=$SUB_3_PREFIX$CIDR_POSTFIX
SUB_UUID=$(create_subnet $TENANT_UUID $NET_UUID $SUB_NAME \
           $SUB_GATEWAY $SUB_CIDR)

# Get Tenant2 uuid
TENANT_NAME=$TEN_2_NAME
TENANT_UUID=$(get_tenant_uuid $TENANT_NAME)

# Create Network3
NET_NAME=$NET_3_NAME
NET_UUID=$(create_network $TENANT_UUID $NET_NAME)

# Create Subnet4
SUB_NAME=$SUB_4_NAME
SUB_GATEWAY=$SUB_1_PREFIX$GATEWAY_POSTFIX
SUB_CIDR=$SUB_1_PREFIX$CIDR_POSTFIX
SUB_UUID=$(create_subnet $TENANT_UUID $NET_UUID $SUB_NAME \
           $SUB_GATEWAY $SUB_CIDR)
