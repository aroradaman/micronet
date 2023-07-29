#!/bin/bash -e

# define network namespaces
export netns_1="ns1"
export netns_2="ns2"

# define pod cidr
export pod_cidr="172.16.1.0/24"

# define bridge ip / gateway ip
export ip_bridge="172.16.1.1"

# define pod ips
export ip_pod_1="172.16.1.10"
export ip_pod_2="172.16.1.20"
