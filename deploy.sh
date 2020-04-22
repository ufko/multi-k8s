docker build -t ufuko/multi-client:latest -t ufuko/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ufuko/multi-server:latest -t ufuko/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ufuko/multi-worker:latest -t ufuko/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ufuko/multi-client:latest
docker push ufuko/multi-server:latest
docker push ufuko/multi-worker:latest

docker push ufuko/multi-client:$SHA
docker push ufuko/multi-server:$SHA
docker push ufuko/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ufuko/multi-client:$SHA
kubectl set image deployments/server-deployment server=ufuko/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ufuko/multi-worker:$SHA