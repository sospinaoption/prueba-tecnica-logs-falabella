#gcloud auth configure-docker us-central1-docker.pkg.dev

docker build -t cloud-run-microservice
docker tag cloud-run-microservice us-central1-docker.pkg.dev/sospina-test/falabella-logs-test-docker-registry/cloud-run-microservice:latest
docker push us-central1-docker.pkg.dev/sospina-test/falabella-logs-test-docker-registry/cloud-run-microservice:latest