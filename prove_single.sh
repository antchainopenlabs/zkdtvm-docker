#!/bin/bash

if [ $# -eq 3 ]; then
    endpoint=https://ethproofs.org/api/v0
elif [ $# -eq 4 ]; then
    endpoint=$4
else
    echo "invalid parameters, usage: ./prove_single.sh <http_rpc_url> <ws_rpc_url> <api_token> [<endpoint>]"
    exit 1
fi

docker run -it -d \
    --gpus all \
    --restart unless-stopped \
    --network host \
    --name zkdtvm_eth_proofs_single \
    -e MODE=single \
    -e HTTP_RPC_URL=$1 \
    -e WS_RPC_URL=$2 \
    -e API_TOKEN=$3 \
    -e ENDPOINT=$endpoint \
    -e BLOCK_INTERVAL=100 \
    -e CLUSTER_ID=2 \
    -e RUST_LOG=info \
    ghcr.io/doubizhizun/zkdtvm_eth_proofs:0.6.1

echo "✅ Single Prover is Running!"
