#!/bin/bash

# load env
source ./env.sh

# echo command and args
set -x

# delete root namespace routes
ip route delete ${host_1_pod_cidr} dev br0
ip route delete ${host_2_pod_cidr} via ${host_2_ip} dev ${main_interface}

# delete pod namespace routes
ip netns exec ${netns_1} ip route delete default via ${host_1_ip_bridge} dev eth0
ip netns exec ${netns_1} ip route delete ${host_1_pod_cidr} dev eth0
ip netns exec ${netns_2} ip route delete default via ${host_1_ip_bridge} dev eth0
ip netns exec ${netns_2} ip route delete ${host_1_pod_cidr} dev eth0

# delete links
ip link delete br0

# delete network namespaces
ip netns delete ${netns_1}
ip netns delete ${netns_2}
