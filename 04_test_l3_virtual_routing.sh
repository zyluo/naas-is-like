source globals
source functions

VM_NAME=vm1_1
PORT_NAME=port_$VM_NAME
PORT_UUID=$(get_port_uuid $PORT_NAME)
VM1_1_PUBIP=$(get_public_ip_on_port $PORT_UUID)

VM_NAME=vm2_3
PORT_NAME=port_$VM_NAME
PORT_UUID=$(get_port_uuid $PORT_NAME)
VM2_3_PUBIP=$(get_public_ip_on_port $PORT_UUID)

VM_NAME=vm3_4
PORT_NAME=port_$VM_NAME
PORT_UUID=$(get_port_uuid $PORT_NAME)
VM3_4_PUBIP=$(get_public_ip_on_port $PORT_UUID)

VM1_1_PVTIP="$SUB_1_PREFIX"10
VM2_3_PVTIP="$SUB_2_PREFIX"30
VM3_4_PVTIP="$SUB_3_PREFIX"40

# TODO(zyluo): Extract automatically from ifconfig eth0
CONTROLLER_NODE_IP=192.168.6.209

echo "Pinging from "$VM1_1_PUBIP" ("$VM1_1_PVTIP") to"\
     $VM2_3_PUBIP" ("$VM2_3_PVTIP")"

ssh -t ubuntu@"$VM1_1_PUBIP" 'ping '"$VM2_3_PUBIP"' -c 3'
echo

echo "Pinging from "$VM2_3_PUBIP" ("$VM2_3_PVTIP") to"\
     $VM1_1_PUBIP" ("$VM1_1_PVTIP")"

ssh -t ubuntu@"$VM2_3_PUBIP" 'ping '"$VM1_1_PUBIP"' -c 3'
echo

echo "Pinging from "$VM1_1_PUBIP" ("$VM1_1_PVTIP") to"\
     $VM3_4_PUBIP" ("$VM3_4_PVTIP")"

ssh -t ubuntu@"$VM1_1_PUBIP" 'ping '"$VM3_4_PUBIP"' -c 3'
echo

echo "Pinging from "$VM3_4_PUBIP" ("$VM3_4_PVTIP") to"\
     $VM1_1_PUBIP" ("$VM1_1_PVTIP")"

ssh -t ubuntu@"$VM3_4_PUBIP" 'ping '"$VM1_1_PUBIP"' -c 3'
echo

echo "Showing controller node IP"

ifconfig eth0

echo "Pinging from "$VM1_1_PUBIP" ("$VM1_1_PVTIP") to "$CONTROLLER_NODE_IP

ssh -t ubuntu@"$VM1_1_PUBIP" 'ping '"$CONTROLLER_NODE_IP"' -c 3'
echo

echo "Pinging from "$CONTROLLER_NODE_IP" to "$VM1_1_PUBIP" ("$VM1_1_PVTIP")"

ping $VM1_1_PUBIP -c 3
echo
