#!/bin/sh

function runNginx(){
    sleep 5
    if [[ "${useNginx}" == "1" ]]; then
        nginx   
    fi
}

runNginx &
/pg-docker-entrypoint.sh &
/tor-docker-entrypoint.sh &
/haproxy-docker-entrypoint.sh &
/ipfs-docker-entrypoint.sh 

