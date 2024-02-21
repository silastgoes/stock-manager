#!/bin/bash
set -e

echo "[build.sh:building binary]"
cd $BUILDPATH && go build -o /stock-manager
echo "[build.sh:launching binary]"
/stock-manager
