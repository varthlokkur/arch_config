#!/bin/bash

docker build -t archdev /base/Dockerfile
docker build -t ml /ml/Dockerfile
docker build -t rust /rust/Dockerfile