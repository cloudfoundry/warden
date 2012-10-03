#!/bin/bash

[ -n "$DEBUG" ] && set -o xtrace
set -o nounset
set -o errexit
shopt -s nullglob

cd $(dirname $0)/../

source ./lib/common.sh

# Add new group for every subsystem
for system_path in /sys/fs/cgroup/*
do
  instance_path=$system_path/instance-$id

  mkdir -p $instance_path

  if [ $(basename $system_path) == "cpuset" ]
  then
    cat $system_path/cpuset.cpus > $instance_path/cpuset.cpus
    cat $system_path/cpuset.mems > $instance_path/cpuset.mems
  fi

  echo 1 > $instance_path/cgroup.clone_children
  echo $PID > $instance_path/tasks
done

echo $PID > ./run/wshd.pid

ip link add name $network_host_iface type veth peer name $network_container_iface
ip link set $network_host_iface netns 1
ip link set $network_container_iface netns $PID

ifconfig $network_host_iface $network_host_ip netmask $network_netmask

exit 0