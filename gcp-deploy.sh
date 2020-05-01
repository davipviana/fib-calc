docker build -t davipviana/fib-calc-client:latest -t davipviana/fib-calc-client:$SHA -f ./client/Dockerfile ./client
docker build -t davipviana/fib-calc-server:latest -t davipviana/fib-calc-server:$SHA -f ./server/Dockerfile ./server
docker build -t davipviana/fib-calc-worker:latest -t davipviana/fib-calc-worker:$SHA -f ./worker/Dockerfile ./worker

docker push davipviana/fib-calc-client:latest
docker push davipviana/fib-calc-server:latest
docker push davipviana/fib-calc-worker:latest

docker push davipviana/fib-calc-client:$SHA
docker push davipviana/fib-calc-server:$SHA
docker push davipviana/fib-calc-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=davipviana/fib-calc-server:$SHA
kubectl set image deployments/client-deployment client=davipviana/fib-calc-client:$SHA
kubectl set image deployments/worker-deployment worker=davipviana/fib-calc-worker:$SHA