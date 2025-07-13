#!/usr/bin/env bash
set -e
SRC="assets/animations"
DST="assets/animations"
rm -rf "$DST"/*
cp "$SRC"/* "$DST"/
echo "Assets deployed."
