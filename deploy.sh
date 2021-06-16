docker build -t idjikine/multi-client:latest -t idjikine/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t idjikine/multi-server:latest -t idjikine/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t idjikine/multi-worker:latest -t idjikine/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push idjikine/multi-client:latest
docker push idjikine/multi-server:latest
docker push idjikine/multi-worker:latest

docker push idjikine/multi-client:$SHA
docker push idjikine/multi-server:$SHA
docker push idjikine/multi-worker:$SHA

kubectl apply -f k8s

# imperatively set latest image
kubectl set image deployments/server-deployment server=idjikine/multi-server:$SHA
kubectl set image deployments/client-deployment client=idjikine/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=idjikine/multi-worker:$SHA