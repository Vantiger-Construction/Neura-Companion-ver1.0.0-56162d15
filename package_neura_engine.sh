#!/usr/bin/env bash
set -e

echo "Packaging Neura Engine project…"

rm -rf neura_package
mkdir neura_package

# Copy directories
cp -r src neura_package/
cp -r include neura_package/
cp CMakeLists.txt neura_package/
cp -r scripts neura_package/
cp -r configs neura_package/
cp -r plugins neura_package/
cp -r tests neura_package/

# Zip it up
rm -f neura_engine_package.zip
zip -r neura_engine_package.zip neura_package

echo "Package created: neura_engine_package.zip"
