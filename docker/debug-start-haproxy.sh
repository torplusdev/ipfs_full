#!/bin/bash

if [[ "${useNginx}" == "1" ]]; then
        nginx   
fi

function checkPEM {
        domain=$1 
        echo "checkPEM ${domain}"
        if [[ "$domain" != "" ]]; then
                domFromFile="$(openssl x509 -noout -subject -in /etc/ssl/torplus/${domain}.pem | awk -F = '{print $3}' | awk '{$1=$1};1')"       
                if [[ "${domFromFile}" != "${domain}" ]]; then 
                        echo "Certificate for ${domain} != ${domFromFile}  not valid."
                        exit 1
                fi
        fi
}
if [ -z "$(ls -A /etc/ssl/torplus/)" ]; then
   echo "ssl directory empty"
   exit 1
fi

for file in /etc/ssl/torplus/*; do
       checkPEM "$(echo -n $file | sed -r "s/.+\/(.+)\..+/\1/" )"
done


set -m
(
        (/pg-docker-entrypoint.sh || kill 0) &
        (/tor-docker-entrypoint.sh || kill 0) &
        (/haproxy-docker-entrypoint.sh || kill 0) &
        (/ipfs-docker-entrypoint.sh || kill 0) &
        wait
)
