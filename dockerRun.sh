#!/bin/bash

if [ "$1" = "divided" ]; then
    DATA="data/divided"

    if [ ! -f "$DATA/orders_data.json" ]; then
    echo "orders_data.json not found in the data directory."
    exit 1
fi

else
    DATA="data/simple"
fi

DOCKER_IMAGE="mongo:latest"
DOCKER_CONTAINER="test_mongodb"
PORT=2717

if [ ! -f "$DATA/users_data.json" ]; then
    echo "users_data.json not found in the data directory."
    exit 1
fi

if [ ! -f "$DATA/products_data.json" ]; then
    echo "products_data.json not found in the data directory."
    exit 1
fi

echo
echo "Pulling the needed docker image..."
docker pull $DOCKER_IMAGE

echo
echo "Running the docker image in background -> mongodb via docker..."
echo "URI is mongodb://localhost:$PORT/otx_db"
docker run -d -p $PORT:27017 -v "$(pwd)":/src --name $DOCKER_CONTAINER $DOCKER_IMAGE

echo
echo "Waiting for MongoDB to initialize..."
sleep 5

echo


echo "Seeding example data into database and starting interactive terminal..."
if [ "$1" = "divided" ]; then
    docker exec -it $DOCKER_CONTAINER bash -c "
    mongoimport --db otx_db --collection users --type json --file /src/$DATA/users_data.json --jsonArray &&
    mongoimport --db otx_db --collection products --type json --file /src/$DATA/products_data.json --jsonArray &&
    mongoimport --db otx_db --collection orders --type json --file /src/$DATA/orders_data.json --jsonArray &&
    mongosh"
else
    docker exec -it $DOCKER_CONTAINER bash -c "
    mongoimport --db otx_db --collection users --type json --file /src/$DATA/users_data.json --jsonArray &&
    mongoimport --db otx_db --collection products --type json --file /src/$DATA/products_data.json --jsonArray &&
    mongosh"
fi

echo
echo "Stopping the Docker container..."
docker stop $DOCKER_CONTAINER

echo
echo "Removing the Docker container..."
docker rm $DOCKER_CONTAINER