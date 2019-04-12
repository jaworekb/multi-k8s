docker build -t jaworek/multi-client:latest -t jaworek/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jaworek/multi-server:latest -t jaworek/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jaworek/multi-worker:latest -t jaworek/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jaworek/multi-client:latest
docker push jaworek/multi-client:$SHA
docker push jaworek/multi-server:latest
docker push jaworek/multi-server:$SHA
docker push jaworek/multi-worker:latest
docker push jaworek/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jaworek/multi-server:$SHA
kubectl set image deployments/client-deployment client=jaworek/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jaworek/multi-worker:$SHA