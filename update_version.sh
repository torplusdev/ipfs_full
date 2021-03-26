
#!/bin/bash

#ipfsVersion=v0.7.0
ipfsVersionDefault="v0.7.0"

ipfsVersion=$1
echo ${ipfsVersion:=$ipfsVersionDefault}

echo "\n"
echo "Updating IPFS to => ${ipfsVersion} \n"


libp2pVersion=$(cd go-ipfs && git show refs/tags/${ipfsVersion}:go.mod | grep libp2p/go-libp2p\ v | awk '{print $2}')
bitswapVersion=$(cd go-ipfs && git show refs/tags/${ipfsVersion}:go.mod | grep ipfs/go-bitswap\ v | awk '{print $2}')
libp2pSwarmVersion=$(cd go-ipfs && git show refs/tags/${ipfsVersion}:go.mod | grep libp2p/go-libp2p-swarm\ v | awk '{print $2}')
multiaddrVersion=$(cd go-ipfs && git show refs/tags/${ipfsVersion}:go.mod | grep multiformats/go-multiaddr\ v | awk '{print $2}')
ipfsConfigVersion=$(cd go-ipfs && git show refs/tags/${ipfsVersion}:go.mod | grep ipfs/go-ipfs-config\ v | awk '{print $2}')
eventbusVersion=$(cd go-libp2p && git show refs/tags/${libp2pVersion}:go.mod | grep libp2p/go-eventbus\ v | awk '{print $2}')


echo "go-libp2p => ${libp2pVersion}"
echo "go-bitswap => ${bitswapVersion}"
echo "go-libp2p-swarm => ${libp2pSwarmVersion}" 
echo "go-multiaddr => ${multiaddrVersion}" 
echo "go-ipfs-config => ${ipfsConfigVersion}" 
echo "go-eventbus => ${eventbusVersion}"

# go-multiaddr-net is deprecated
for folder in go-ipfs go-bitswap go-libp2p-swarm go-multiaddr go-ipfs-config go-eventbus; 
do
    cd ${folder}
    git checkout pp_master
    git branch pp_master_prev
    cd ../
done

(cd go-ipfs && git rebase ${ipfsVersion} && cd ../  )
(cd go-libp2p && git rebase ${libp2pVersion} && cd ../  )
(cd go-bitswap && git rebase ${bitswapVersion} && cd ../  )
(cd go-libp2p-swarm && git rebase ${libp2pSwarmVersion} && cd ../  )
(cd go-multiaddr && git rebase ${multiaddrVersion} && cd ../  )
(cd go-ipfs-config && git rebase ${ipfsConfigVersion} && cd ../  )
(cd go-eventbus && git rebase ${eventbusVersion} && cd ../  )

for folder in go-ipfs go-bitswap go-libp2p-swarm go-multiaddr go-ipfs-config go-eventbus; 
do
  cd ${folder}
  (test -d ".git/rebase-merge" || test -d ".git/rebase-apply" && echo "fix conflict in ${folder}") || echo "${folder} has not conflict"  
  cd ../
done
echo "run update complete"
