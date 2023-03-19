#!/bin/bash

if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ "$#" -ne 3 ]; then
  echo "Usage: $0 <interface> <ip-address> <delay>"
  echo "Example: $0 eth0 192.168.1.1 10ms"
  echo "--off(-o) - reset delay"
  exit 1
fi

if [ "$1" = "-o" ] || [ "$1" = "--off" ]; then
  tc qdisc del dev eth0 root
  echo "Delay reset"
  exit 0
fi

interface="$1"
ip_address="$2"
delay="$3"

if ! ip link show "$interface" &> /dev/null; then
  echo "Error: Invalid interface name $interface"
  exit 1
fi

if ! ping -c 1 -w 1 "$ip_address" &> /dev/null; then
  echo "Error: Invalid IP address $ip_address"
  exit 1
fi

tc qdisc del dev "$interface" root
tc qdisc add dev "$interface" root handle 1: htb
tc class add dev "$interface" parent 1: classid 1:1 htb rate 100mbit
tc filter add dev "$interface" parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst "$ip_address"
tc qdisc add dev "$interface" parent 1:1 handle 10: netem delay "$delay"

echo "For $interface $ip_address set delay to $delay"
