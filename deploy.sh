docker build -t parkyes90/multi-client:latest -t parkyes90/multi-client:"$SHA" -f ./client/Dockerfile ./client
docker build -t parkyes90/multi-server:latest -t parkyes90/multi-server:"$SHA" -f ./server/Dockerfile ./server
docker build -t parkyes90/multi-worker:latest -t parkyes90/multi-worker:"$SHA" -f ./worker/Dockerfile ./worker
docker push parkyes90/multi-client:latest
docker push parkyes90/multi-server:latest
docker push parkyes90/multi-worker:latest

docker push parkyes90/multi-client:"$SHA"
docker push parkyes90/multi-server:"$SHA"
docker push parkyes90/multi-worker:"$SHA"
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=parkyes90/multi-server:"$SHA"
kubectl set image deployments/client-deployment server=parkyes90/multi-client:"$SHA"
kubectl set image deployments/worker-deployment server=parkyes90/multi-worker:"$SHA"