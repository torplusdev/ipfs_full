
file="ipfs.${PP_ENV}.cfg"
if [[ "${PP_ENV}" = "stage" ]]; then
    bootstrapServer="13.95.67.71"
   
fi
if [[ "${PP_ENV}" = "prod" ]]; then
    bootstrapServer="40.68.195.206"
   
fi
ssh edikk202@${bootstrapServer} "touch ~/.hushlogin"

echo "${PP_ENV}"

#cat /var/lib/tor/hidden_service_v3/hostname
fullOnionAddress=$(ssh edikk202@${bootstrapServer} "cat /var/lib/tor/hidden_service_paidpiper/hostname")
hsHostname=$(ssh edikk202@${bootstrapServer} "sed 's/[.].*$//' /var/lib/tor/hidden_service_paidpiper/hostname")
ipfsSuperPeerID=$(ssh edikk202@${bootstrapServer} "cat ~/.ipfs/config | jq -r '.Identity.PeerID'")


echo "hsHostname=${hsHostname}" > $file
echo "ipfsSuperPeerID=${ipfsSuperPeerID}" >> $file
echo "fullOnionAddress=$fullOnionAddress" >> $file
