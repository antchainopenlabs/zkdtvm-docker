#!/bin/bash

if [ $# -eq 3 ]; then
    endpoint=https://ethproofs.org/api/v0
    coordinator_url=http://localhost:8000
elif [ $# -eq 4 ]; then
    endpoint=$4
    coordinator_url=http://localhost:8000
elif [ $# -eq 5 ]; then
    endpoint=$4
    coordinator_url=$5
else
    echo "invalid parameters, usage: ./prove_network.sh <http_rpc_url> <ws_rpc_url> <api_token> [<endpoint>] [<coordinator_url>]"
    exit 1
fi

docker run -it -d \
    --restart unless-stopped \
    --network host \
    --name zkdtvm_eth_proofs_network \
    -e MODE=network \
    -e HTTP_RPC_URL=$1 \
    -e WS_RPC_URL=$2 \
    -e API_TOKEN=$3 \
    -e ENDPOINT=$endpoint \
    -e COORDINATOR=$coordinator_url \
    -e BLOCK_INTERVAL=1 \
    -e CLUSTER_ID=1 \
    -e RUST_LOG=info \
    ghcr.io/doubizhizun/zkdtvm_eth_proofs:0.6.1

echo "✅ Network is Running!"