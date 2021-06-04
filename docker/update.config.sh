# pp_env=stage
file="ipfs.${pp_env}.cfg"
if [[ "${pp_env}" = "stage" ]]; then
    bootstrapServer="13.95.67.71"
fi
[[ "${pp_env}" = "prod" ]]; then
    bootstrapServer="40.68.195.206"
fi
ssh edikk202@${bootstrapServer} "touch ~/.hushlogin"

echo "${pp_env}"


fullOnionAddress=$(ssh edikk202@${bootstrapServer} "cat /var/lib/tor/hidden_service_v3/hostname")
hsHostname=$(ssh edikk202@${bootstrapServer} "sed 's/[.].*$//' /var/lib/tor/hidden_service_v3/hostname")
ipfsSuperPeerID=$(ssh edikk202@${bootstrapServer} "cat ~/.ipfs/config | jq -r '.Identity.PeerID'")


echo "hsHostname=${hsHostname}" >> $file
echo "ipfsSuperPeerID=${ipfsSuperPeerID}" >> $file
echo "fullOnionAddress=$fullOnionAddress" >> $file
