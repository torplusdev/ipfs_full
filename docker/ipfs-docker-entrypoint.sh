if [[ "${no_conf}" != "1" ]]; then
  if [ ! -f /root/.ipfs ]; then 
    source /opt/paidpiper/ipfs.${PP_ENV}.cfg
    echo /onion3/${hsHostname}:4001/p2p/${ipfsSuperPeerID}
    rm -rf /root/.ipfs
    if [[ "${role}" == "hs_client" ]]; then
      selfHsHostname="$(sed 's/[.].*$//' /root/tor/hidden_service/hsv3/hostname)"
      /opt/paidpiper/ipfs init --announce=/onion3/${selfHsHostname}:4001 \
          --bootStrap=/onion3/${hsHostname}:4001/p2p/${ipfsSuperPeerID} \
          --torPath=/usr/local/bin/tor \
          --torConfigPath=/usr/local/etc/tor/torrc
      echo "Run as node"
    else 
      /opt/paidpiper/ipfs init \
          --bootStrap=/onion3/${hsHostname}:4001/p2p/${ipfsSuperPeerID} \
          --torPath=/usr/local/bin/tor \
          --torConfigPath=/usr/local/etc/tor/torrc
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

while [ ! -f /opt/paidpiper/.tor_ready ]; do
  sleep 2 # or less like 0.2
  echo "tor not ready yet..."
done

if [ $# -eq 0 ]
then
    /opt/paidpiper/ipfs daemon --debug | mark "Daemon is ready" "/opt/paidpiper/.ipfs_ready"
else 
    exec "$@" | mark "Daemon is ready" "/opt/paidpiper/.ipfs_ready"
fi
