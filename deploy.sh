# get project id, image output and service name from terraform output
PROJECT_ID="sospina-test"
IMAGE_URI="us-central1-docker.pkg.dev/sospina-test/falabella-logs-test-docker-registry/cloud-run-microservice:latest"
SERVICE_NAME="cloud-run-microservice"

# build and push image
(cd src-cloud-run-microservice && 
    ./build.sh && 
    IMAGE_URI=$IMAGE_URI ./push.sh)

# update image
gcloud --project $PROJECT_ID \
    run services update $SERVICE_NAME \
    --image $IMAGE_URI \
    --platform managed \
    --region us-central1

# send traffic to latest
gcloud --project $PROJECT_ID \
    run services update-traffic $SERVICE_NAME \
    --platform managed \
    --region us-central1 \
    --to-latest