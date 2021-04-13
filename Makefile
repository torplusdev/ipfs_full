build:
	(cd go-ipfs/cmd/ipfs && go build .)
run-daemon:
	./go-ipfs/cmd/ipfs/ipfs daemon
