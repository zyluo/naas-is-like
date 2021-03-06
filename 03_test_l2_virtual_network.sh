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

VM1_1_PVTIP="$SUB_1_PREFIX"10
VM1_2_PVTIP="$SUB_1_PREFIX"20
VM2_3_PVTIP="$SUB_2_PREFIX"30
VM3_4_PVTIP="$SUB_3_PREFIX"40

echo "Checking connectivity and isolation from "$VM1_1_PVTIP
ssh -t ubuntu@"$VM1_1_PUBIP" 'ping '"$VM1_2_PVTIP"' -c 3'; echo
ssh -t ubuntu@"$VM1_1_PUBIP" 'ping '"$VM2_3_PVTIP"' -c 3'; echo
ssh -t ubuntu@"$VM1_1_PUBIP" 'ping '"$VM3_4_PVTIP"' -c 3'; echo
ssh -t ubuntu@"$VM1_1_PUBIP" 'arp'; echo

echo "Checking connectivity and isolation from "$VM2_3_PVTIP
ssh -t ubuntu@"$VM2_3_PUBIP" 'ping '"$VM1_1_PVTIP"' -c 3'; echo
ssh -t ubuntu@"$VM2_3_PUBIP" 'ping '"$VM1_2_PVTIP"' -c 3'; echo
ssh -t ubuntu@"$VM2_3_PUBIP" 'ping '"$VM3_4_PVTIP"' -c 3'; echo
ssh -t ubuntu@"$VM2_3_PUBIP" 'arp'; echo
