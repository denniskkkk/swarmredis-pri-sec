#!/bin/sh
if [ "$1" = 'redis-cluster' ] && [ ! -f "/redis-data/CLUSTER_UP" ]; then
    echo "setup cluster"
    sleep 5
    #echo "yes" | ruby /redis/src/redis-trib.rb create --replicas 0 10.60.0.10:7000 10.60.0.11:7001 10.60.0.12:7002
    #create cluster with no slave 3 servers need
    echo "yes" | redis-cli --cluster create 10.60.0.10:6379 10.60.0.11:6379 10.60.0.12:6379 --cluster-replicas 0
    #-a password
    #create cluster with 1 slave 6 servers need
    #echo "yes" | redis-cli --cluster create 10.60.0.10:7000 10.60.0.11:7001 10.60.0.12:7002 \
    #10.60.0.13:7000 10.60.0.14:7000 10.60.0.15:7000--cluster-replicas 1
    touch /redis-data/CLUSTER_UP
    echo "DONE"
else
  echo "start redis ${@}"
#  set -- redis-server /redis-conf/redis.conf 
  exec "$@"
fi
