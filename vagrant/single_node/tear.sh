#!/bin/bash

# load env
source ./env.sh

# echo command and args
set -x

# delete root namespace routes
ip route delete ${pod_cidr} dev br0

# delete pod namespace routes
ip netns exec ${netns_1} ip route delete default via ${ip_bridge} dev eth0
ip netns exec ${netns_1} ip route delete ${pod_cidr} dev eth0
ip netns exec ${netns_2} ip route delete default via ${ip_bridge} dev eth0
ip netns exec ${netns_2} ip route delete ${pod_cidr} dev eth0

# delete links
ip link delete br0

# delete network namespaces
ip netns delete ${netns_1}
ip netns delete ${netns_2}
