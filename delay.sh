#!/bin/bash

if [ "$1" = "-h" ] || [ $1 = "--help" ] || [ "$1" = "" ]; then
  echo "Enter: network interfaces, ip-address whom need to make delay, time delay(ms)"
  echo "Example: ./delayip.sh eth0 192.168.1.1 10ms
  echo "--off(-o) - reset delay"
 exit
 fi
 
 if [  "$1" = "-o" ] || [ "$1" = "--off" ]; then
  tc qdisc del dev eth0 root
  echo "Delay reset"
 exit
 fi
 
 eth=$3
 
 if [ "eth" = ""]; then
  eth="eth0"
 fi
 
 tc qdisc del dev $eth root
 tc qdisc add dev $eth root handle 1: htb
 tc class add dev $eth parent 1: classid 1:1 htb rate 100mbit
 tc filter add dev $eth parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst $1
 tc qdisc add dev $eth parent 1:1 handle 10: netem delay $2
 
 echo "For $eth $1 set delay to $2"
