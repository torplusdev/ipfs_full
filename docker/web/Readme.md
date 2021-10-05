
Run ipfs and tor and haproxy:

    docker run \
    -e nickname=tunick \
    -e PP_ENV=prod \
    -e seed=SCR27IGKMKXSOKUV7AC4T3HBTBVBL2MI45HHFSDNRYJFFVKWQAWBBKKZ \
    -e role=hs_client \
    -e HOST_PORT=80 \
    -e WWW_IP=smartapi.ru \
    -p 80:80 \
    -v ${PWD}/tor:/root/tor \
    -v ${PWD}/ipfs:/root/.ipfs \
    --entrypoint /bin/bash -it \
    --rm
    torplusserviceregistry.azurecr.io/private/ipfs_haproxy:latest



Run ipfs and tor:

    docker run \
    -e nickname=tunick \
    -e PP_ENV=prod \
    -e seed=SCR27IGKMKXSOKUV7AC4T3HBTBVBL2MI45HHFSDNRYJFFVKWQAWBBKKZ \
    -v ${PWD}/tor:/root/tor \
    -v ${PWD}/ipfs:/root/.ipfs \
    torplusserviceregistry.azurecr.io/private/ipfs:latest

