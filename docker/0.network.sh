#!/bin/bash

# https://www.cockroachlabs.com/docs/stable/start-a-local-cluster-in-docker-mac
docker network create -d bridge roachnet

echo "✅ Docker Network Created."