#!/bin/bash -e

# define main network interface
### needs to be updated, should be the main interface of the main host where vagrant is running
### can be eth0 / wlo1 depending on system configuration
export main_interface="enp0s8"
# define network namespace
export netns_1="ns1"
export netns_2="ns2"

# define pod cidr(s)
export host_1_pod_cidr="172.16.1.0/24"
export host_2_pod_cidr="172.16.2.0/24"

# cidr for vagrant public network
### needs to be updated, depends on system configuration
#### should be subnet of main_interface
export vagrant_cidr="192.168.1.0/24"

# ip of the vagrant machine
### needs to be updated, depends on system configuration
#### should be ip of main_interface
export host_1_ip="192.168.1.31"
#### should be ip of main_interface
export host_2_ip="192.168.1.32"

# define bridge ips
export host_1_ip_bridge="172.16.1.1"
export host_2_ip_bridge="172.16.2.1"

# define pod ips
export host_1_ip_pod_1="172.16.1.10"
export host_1_ip_pod_2="172.16.1.20"

# define pod ips
export host_2_ip_pod_1="172.16.2.10"
export host_2_ip_pod_2="172.16.2.20"

