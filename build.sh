#!/bin/sh -e

cd nginx
docker build -t router:latest .
cd ..

cd prometheus
docker build -t prometheus:latest .