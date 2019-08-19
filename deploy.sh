#!/usr/bin/env bash
docker build -t barakyaari/multi-client:latest -t  barakyaari/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t barakayari/multi-server:latest -t  barakyaari/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t barakayari/multi-worker:latest -t  barakyaari/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push barakyaari/multi-client:latest
docker push barakyaari/multi-server:latest
docker push barakyaari/multi-worker:latest

docker push barakyaari/multi-client:$SHA
docker push barakyaari/multi-server:$SHA
docker push barakyaari/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=barakyaari/multi-server:$SHA
kubectl set image deployments/client-deployment server=barakyaari/multi-client:$SHA
kubectl set image deployments/worker-deployment server=barakyaari/multi-worker:$SHA
