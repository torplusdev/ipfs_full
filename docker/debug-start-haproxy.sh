#!/bin/bash

if [[ "${useNginx}" == "1" ]]; then
        nginx   
fi

function checkPEM {
        domain=$1 
        if [[ $domain != "" ]]; then       
                if [[ "$(openssl x509 -noout -subject -in /etc/ssl/torplus/${domain}.pcm | awk -F = '{print $3}')" != "${domain}" ]]; then 
                        echo "Certificate for ${domain} not valid."
                        exit 1
                fi
        fi
}
if [ -z "$(ls -A /etc/ssl/torplus/)" ]; then
   echo "ssl directory empty"
   exit .
fi
ls -1 /etc/ssl/torplus/ | sed -e 's/\.pem$//' | xargs -I {} checkPEM {}



/pg-docker-entrypoint.sh &
/tor-docker-entrypoint.sh &
/haproxy-docker-entrypoint.sh &
/ipfs-docker-entrypoint.sh 

