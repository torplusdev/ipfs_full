FROM golang:latest as build
WORKDIR /opt/paidpiper/ipfs_full
RUN apt-get update && apt-get install -y build-essential manpages-dev git
#---------------
COPY ./go-libp2p-swarm/go.mod ./go-libp2p-swarm/go.mod
COPY ./go-payment-service/payment-gateway-webui/go.mod ./go-payment-service/payment-gateway-webui/go.mod
COPY ./go-payment-service/PaymentGateway/go.mod ./go-payment-service/PaymentGateway/go.mod
COPY ./go-payment-service/ProtocolCustomizations/go.mod ./go-payment-service/ProtocolCustomizations/go.mod
COPY ./go-libp2p/go.mod ./go-libp2p/go.mod
COPY ./go-libp2p-onion-transport/go.mod ./go-libp2p-onion-transport/go.mod
COPY ./go-bitswap/go.mod ./go-bitswap/go.mod
COPY ./go-ipfs-config/go.mod ./go-ipfs-config/go.mod
COPY ./go-eventbus/go.mod ./go-eventbus/go.mod
COPY ./go-libp2p-core/go.mod ./go-libp2p-core/go.mod
COPY ./go-libp2p-core/tools/go.mod ./go-libp2p-core/tools/go.mod
COPY ./go-multiaddr/go.mod ./go-multiaddr/go.mod
COPY ./go-libp2p-kad-dht/go.mod ./go-libp2p-kad-dht/go.mod
COPY ./go-ipfs/go.mod ./go-ipfs/go.mod
COPY ./go-ipfs/test/dependencies/go.mod ./go-ipfs/test/dependencies/go.mod
COPY ./go-ipfs/docs/examples/go-ipfs-as-a-library/go.mod ./go-ipfs/docs/examples/go-ipfs-as-a-library/go.mod
COPY ./go-multiaddr-net/go.mod ./go-multiaddr-net/go.mod
COPY ./go-libp2p-swarm/go.sum ./go-libp2p-swarm/go.sum
COPY ./go-payment-service/payment-gateway-webui/go.sum ./go-payment-service/payment-gateway-webui/go.sum
COPY ./go-payment-service/PaymentGateway/go.sum ./go-payment-service/PaymentGateway/go.sum
COPY ./go-libp2p/go.sum ./go-libp2p/go.sum
COPY ./go-libp2p-onion-transport/go.sum ./go-libp2p-onion-transport/go.sum
COPY ./go-bitswap/go.sum ./go-bitswap/go.sum
COPY ./go-ipfs-config/go.sum ./go-ipfs-config/go.sum
COPY ./go-eventbus/go.sum ./go-eventbus/go.sum
COPY ./go-libp2p-core/tools/go.sum ./go-libp2p-core/tools/go.sum
COPY ./go-libp2p-core/go.sum ./go-libp2p-core/go.sum
COPY ./go-multiaddr/go.sum ./go-multiaddr/go.sum
COPY ./go-libp2p-kad-dht/go.sum ./go-libp2p-kad-dht/go.sum
COPY ./go-ipfs/test/dependencies/go.sum ./go-ipfs/test/dependencies/go.sum
COPY ./go-ipfs/go.sum ./go-ipfs/go.sum
COPY ./go-ipfs/docs/examples/go-ipfs-as-a-library/go.sum ./go-ipfs/docs/examples/go-ipfs-as-a-library/go.sum
COPY ./go-multiaddr-net/go.sum ./go-multiaddr-net/go.sum
WORKDIR /opt/paidpiper/ipfs_full/go-ipfs
RUN go mod download
WORKDIR /opt/paidpiper/ipfs_full
RUN rm -rf *
#--------------
COPY . .
WORKDIR /opt/paidpiper/ipfs_full
RUN make build_linux
