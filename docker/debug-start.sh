#!/bin/sh
/pg-docker-entrypoint.sh &
/tor-docker-entrypoint.sh &
/haproxy-docker-entrypoint.sh &
/ipfs-docker-entrypoint.sh 
