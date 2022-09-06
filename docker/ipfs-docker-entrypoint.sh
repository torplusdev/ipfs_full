#!/bin/bash
while [ ! -f /opt/torplus/.tor_ready ]; do
  sleep 2 # or less like 0.2
  echo "tor not ready yet..."
done
echo "Check free space..."
if [[ "${SKIPSPCECHECK}" != "1" ]]; then
  FREE=`df -k --output=avail "$PWD" | tail -n1`
  if [[ $FREE -lt 2485760 ]]; then   
    echo "ERROR: Not enough free space"  # 2G = 2*1024*1024k
    exit 1
  fi
fi 
echo "Configure ipfs ..."
#torDataDir="/Users/tumarsal/tor"
export hs_directory="/root/hidden_service"
if [[ "${no_conf}" != "1" ]]; then
  if [ ! -f /root/.ipfs/config ]; then 
    source /opt/torplus/ipfs.${PP_ENV}.cfg
    echo /onion3/${hsHostname}:4001/p2p/${ipfsSuperPeerID}
    rm -rf /root/.ipfs/*
    if [[ "${role}" == "hs_client" ]]; then
      selfHsHostname="$(sed 's/[.].*$//' ${hs_directory}/hsv3/hostname)"
      /opt/torplus/ipfs init --announce=/onion3/${selfHsHostname}:4001 \
          --bootStrap=/onion3/${hsHostname}:4001/p2p/${ipfsSuperPeerID} \
          --torPath=/usr/local/bin/tor \
          --torConfigPath=/usr/local/etc/tor/torrc \
          --dhtRoutingType=dhtserver
      echo "Run as node"
    else 
      /opt/torplus/ipfs init \
          --bootStrap=/onion3/${hsHostname}:4001/p2p/${ipfsSuperPeerID} \
          --torPath=/usr/local/bin/tor \
          --torConfigPath=/usr/local/etc/tor/torrc \
          --dhtRoutingType=dhtserver
      echo "Run as client "
    fi  
  fi  
fi
function mark {
  match=$1
  file=$2
  mark=1
  while read -r data; do
    echo $data
    if [[ $data == *"$match"* ]]; then 
      if [[ "$mark" == "1" ]]; then 
        echo "done" >> $file
        mark=0
      fi
    fi
  done
}
SEDOPTION="-i "
if [[ "$OSTYPE" == "darwin"* ]]; then
  SEDOPTION="-i ''"
fi

sed $SEDOPTION -e 's|/ip4/127.0.0.1/tcp/5001|/ip4/0.0.0.0/tcp/5001|g' /root/.ipfs/config 
sed $SEDOPTION -e 's|/ip4/127.0.0.1/tcp/8080|/ip4/0.0.0.0/tcp/8080|g' /root/.ipfs/config

function addSomFileToIPFS() {
  sleep 30 
  echo "Create ipfs check files ipfs ..."
  echo "${ipfsSuperPeerID} is online!!" > /root/.ipfs/ipfstestfile.txt
  /opt/torplus/ipfs add -q /root/.ipfs/ipfstestfile.txt > /root/.ipfs/ipfs_test_cid.txt
  echo "Try get file from ipfs ..."
  /opt/torplus/ipfs cat QmVvYTju2wUdnVJGXVyWWqM7mrqVsH1dNLf1MYfeCDnUFe
}
function ipfsFill(){
  while [ "false" != "true" ]; do
    #sleep 60*60*24 
    sleep 606024
    /opt/torplus/ipfs fill
  done
}
ipfsFill &
addSomFileToIPFS &
echo "Start ipfs daemon ..."
if [ $# -eq 0 ]
then
  if [[ "${ipfs_debug}" != "1" ]]; then
    /opt/torplus/ipfs daemon | mark "Daemon is ready" "/opt/torplus/.ipfs_ready" >> /opt/torplus/logs/ipfs.log
  else 
    /opt/torplus/ipfs daemon --debug | mark "Daemon is ready" "/opt/torplus/.ipfs_ready" >> /opt/torplus/logs/ipfs.log
  fi
   
else 
    exec "$@" | mark "Daemon is ready" "/opt/torplus/.ipfs_ready" >> /opt/torplus/logs/ipfs.log
fi
