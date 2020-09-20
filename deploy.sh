docker build -t andyandya/multi-client:latest -t andyandya/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andyandya/multi-server:latest -t andyandya/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andyandya/multi-worker:latest -t andyandya/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push andyandya/multi-client:latest
docker push andyandya/multi-server:latest
docker push andyandya/multi-worker:latest

docker push andyandya/multi-client:$SHA
docker push andyandya/multi-server:$SHA
docker push andyandya/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andyandya/multi-server:$SHA
kubectl set image deployments/client-deployment client=andyandya/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=andyandya/multi-worker:$SHA