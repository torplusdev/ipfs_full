build:
	(cd go-ipfs/cmd/ipfs && go build . && mv ./go-ipfs/cmd/ipfs/ipfs ipfs )
run-daemon:
	./go-ipfs/cmd/ipfs/ipfs daemon
init:
	./ipfs init --bootStrap=/onion3/aec7fj7zj7dax3lzsv73mhlvplikjlauhtm6bk5dkupnkfq5csqvyjid:4001/p2p/12D3KooWQdJBVG7FZFYY5okznqYvApYCSCLxrkBLNHysTAde83UY --torPath=/Users/tumarsal/Documents/PaidPiper2020/tools/tor/tor --torConfigPath=/Users/tumarsal/Documents/PaidPiper2020/tools/tor/torrc
