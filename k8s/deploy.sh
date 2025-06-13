#!/bin/bash

# Build Docker image
docker build -t springboot-sandbox .

# Load image to minikube (if using minikube)
minikube image load springboot-sandbox:latest

# Apply Kubernetes manifests
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/mongodb-secret.yaml
kubectl apply -f k8s/mongodb.yaml
kubectl apply -f k8s/app-configmap.yaml
kubectl apply -f k8s/app.yaml
kubectl apply -f k8s/ingress.yaml

# Wait for pods to be ready
kubectl wait --for=condition=Ready pod -l app=springboot-app -n springboot-sandbox --timeout=120s

# Get application URL
echo "Application URL:"
minikube service springboot-app -n springboot-sandbox --url || \
kubectl get ingress springboot-ingress -n springboot-sandbox -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
