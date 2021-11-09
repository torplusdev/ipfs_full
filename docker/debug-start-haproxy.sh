#!/bin/bash

if [[ "${useNginx}" == "1" ]]; then
        nginx   
fi

function checkPEM {
        domain=$1       
        if [[ "$(openssl x509 -noout -subject -in /etc/ssl/torplus/${domain}.pcm | awk -F = '{print $3}')" != "${domain}" ]]; then 
                exit 1
        fi
}

ls -1 /etc/ssl/torplus/ | sed -e 's/\.pem$//' | xargs -I {} checkPEM {}



/pg-docker-entrypoint.sh &
/tor-docker-entrypoint.sh &
/haproxy-docker-entrypoint.sh &
/ipfs-docker-entrypoint.sh 

