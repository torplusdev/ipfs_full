if [[ "${no_conf}" != "1" ]]; then
   bash init.sh
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
