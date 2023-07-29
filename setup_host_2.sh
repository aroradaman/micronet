#!/bin/bash

# load env
source ./env.sh

# echo command and args
set -x

# enable ip forwarding
sysctl -w net.ipv4.ip_forward=1


# create netns for pods
ip netns add ${netns_1}
ip netns add ${netns_2}


# create the veth pairs for pods
## for netns_1: interface "pod1" will be in host netns, interface "eth0" will be in pod netns
ip link add pod1 type veth peer name eth0 netns ${netns_1}
## for netns_2: interface "pod2" will be in host netns, interface "eth0" will be in pod netns
ip link add pod2 type veth peer name eth0 netns ${netns_2}


# configure interface in netns with ip addresses
## add ip to "eth0" interface of pod1
ip netns exec ${netns_1} ip addr add ${host_2_ip_pod_1}/24 dev eth0
## add ip to "eth0" interface of pod2
ip netns exec ${netns_2} ip addr add ${host_2_ip_pod_2}/24 dev eth0


# create bridge
ip link add name br0 type bridge


# add veth interfaces of host netns to bridge
## add host netns end of veth pair of pod1 to bridge
ip link set dev pod1 master br0
## add host netns end of veth pair of pod2 to bridge
ip link set dev pod2 master br0


# assign ip address to bridge
ip addr add ${host_2_ip_bridge}/24 dev br0


# enable all interfaces
## enable all interfaces on host netns
ip link set dev br0 up
ip link set dev pod1 up
ip link set dev pod2 up
## enable all interfaces of pod1
ip netns exec ${netns_1} ip link set dev lo up
ip netns exec ${netns_1} ip link set dev eth0 up
## enable all interfaces of pod2
ip netns exec ${netns_2} ip link set dev lo up
ip netns exec ${netns_2} ip link set dev eth0 up


# set routes
## on host netns
### the following route might be created by system itself after enabling br0 device in host netns
ip route add ${host_2_pod_cidr} dev br0
ip route add ${host_1_pod_cidr} via ${host_1_ip} dev ${main_interface}
ip route add ${vagrant_cidr} dev ${main_interface}
## on pod1
ip netns exec ${netns_1} ip route add default via ${host_2_ip_bridge} dev eth0
### the following route might be created by system itself after enabling eth0 device in pod1 netns
ip netns exec ${netns_1} ip route add ${host_2_pod_cidr} dev eth0
## on pod2
ip netns exec ${netns_2} ip route add default via ${host_2_ip_bridge} dev eth0
### the following route might be created by system itself after enabling eth0 device in pod2 netns
ip netns exec ${netns_2} ip route add ${host_2_pod_cidr} dev eth0
