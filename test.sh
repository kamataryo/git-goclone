#!/usr/bin/env bash

echo "TEST 0) Exit 1 without effective \$GOPATH"

GOPATH="./__not_effective_path" ./git-goclone.sh >/dev/null 2>&1
if [[ $? == 1 ]]; then
  echo "  => success!"
else
  echo "  => failed!"
  exit 1
fi
