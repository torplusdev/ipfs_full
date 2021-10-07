Установить docker 

https://www.docker.com/products/docker-desktop

Login to docker regestry:
    docker login torplusserviceregistry.azurecr.io - use login and password

Run ipfs and tor and haproxy:

1) Получить image:

    docker pull torplusserviceregistry.azurecr.io/private/ipfs_haproxy:latest

2) Запустить docker:
    docker run \
    -e nickname=tum332 \
    -e seed=SCR27IGKMKXSOKUV7AC4T3HBTBVBL2MI45HHFSDNRYJFFVKWQAWBBKKZ \
    -e role=hs_client \
    -e HOST_PORT=80 \
    -e PP_ENV=stage \
    -e WWW_IP=smartapi.ru \
    -p 80:80 \
    -v ${PWD}/tor:/root/tor \
    -v ${PWD}/ipfs:/root/.ipfs \
    -v ${PWD}/ssl:/etc/ssl/torplus/ \
    -v ${PWD}/hidden_service:/root/hidden_service \
    --entrypoint /bin/bash -it \
    --rm \
    torplusserviceregistry.azurecr.io/private/ipfs_haproxy:latest

-e nickname=tunick  - nickname в tor
-e PP_ENV=prod - stage or prod 
-e seed=SCR27IGKMKXSOKUV7AC4T3HBTBVBL2MI45HHFSDNRYJFFVKWQAWBBKKZ -  payment gateway seed
-e HOST_PORT=80  - port haproxy
-e WWW_IP=smartapi.ru -  web site wihch we host 
-p 80:80 - local port for haproxy
-v ${PWD}/tor:/root/tor  - save keys of tor 
-v ${PWD}/ipfs:/root/.ipfs - save repo data
-v ${PWD}/ssl:/etc/ssl/torplus/ - ssl directory for haproxy 
-v ${PWD}/hidden_service:/root/hidden_service - onion address store 
--rm  -- remove docker container when stop 


3) Сохранить сертификат в папку

    ./ssl

4) Взять hostname:

    cat hidden_service/hsv3/hostname
    Добавить TXT запись в DNS:
        torplus={hostname}

1) Получить image:

    docker pull  torplusserviceregistry.azurecr.io/private/ipfs:latest

2) Run ipfs and tor:

    docker run \
    -e nickname=tunick \
    -e PP_ENV=stage \
    -e seed=SCR27IGKMKXSOKUV7AC4T3HBTBVBL2MI45HHFSDNRYJFFVKWQAWBBKKZ \
    -v ${PWD}/tor:/root/tor \
    -v ${PWD}/ipfs:/root/.ipfs \
    torplusserviceregistry.azurecr.io/private/ipfs:latest

