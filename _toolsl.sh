#!/bin/bash

for folder in go-ipfs go-bitswap go-libp2p-swarm go-multiaddr go-ipfs-config go-eventbus go-multiaddr-net; 
do
    cd ${folder}
    #git checkout pp_master
    #echo -e "${folder}\t$(git rev-parse --abbrev-ref HEAD)"
    echo -e "${folder}\t$(git remote get-url origin)"
    
    #git push -u origin pp_master
    cd ../
done

declare -A repos=(
[go-ipfs]="git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-ipfs"
[go-bitswap]="git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-bitswap"
[go-libp2p-swarm]="git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-libp2p-swarm"
[go-multiaddr]="git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-multiaddr"
[go-ipfs-config]="git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-ipfs-config"
[go-multiaddr-net]="git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-multiaddr-net"
[go-eventbus]="git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-eventbus
) 

for key in "${repos[@]}"; do echo $key; done

for folder in "${repos[@]}"; 
do 
    echo "$folder - ${repos[$folder]}"; 
done
for folder in go-ipfs go-bitswap go-libp2p-swarm go-multiaddr go-ipfs-config go-eventbus go-multiaddr-net; 
do
    cd ${folder}
    echo -e "[${folder}]=\"$(git remote get-url origin)\""
    cd ../
done
for folder in go-ipfs go-bitswap go-libp2p-swarm go-multiaddr go-ipfs-config go-eventbus go-multiaddr-net; 
do
    cd ${folder}
    git remote set-url origin ${repos[$folder]}
    cd ../
done

ARRAY=( "go-ipfs|git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-ipfs"
"go-bitswap|git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-bitswap"
"go-libp2p-swarm|git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-libp2p-swarm"
"go-multiaddr|git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-multiaddr"
"go-ipfs-config|git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-ipfs-config"
"go-multiaddr-net|git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-multiaddr-net" 
"go-eventbus|git@ssh.dev.azure.com:v3/paidpiper2020/PaidPiper/go-eventbus"
)

for row in "${ARRAY[@]}" ; do
    KEY="${row%%|*}"
    VALUE="${row##*|}"
    cd ${KEY}
    echo -e "${folder}\t$(git rev-parse --abbrev-ref HEAD)"
    cd ../
done;
#git push -u origin pp_master
#git remote set-url origin ${VALUE}
for folder in go-ipfs go-bitswap go-libp2p-swarm go-multiaddr go-ipfs-config go-eventbus; 
do
    cd ${folder}
    git checkout pp_master_prev
    git branch -f pp_master pp_master_prev
    cd ../
done
