#!/usr/bin/env bash

set -e

INSTALL=0
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    --install)
    INSTALL=1
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

# Starts the app
#cp local.php ../config/autoload/local.php
docker compose up -d --build
docker exec manga-api ./dev/wait-for-it.sh manga-db:3306 -t 6000

# It can return non-zero code - just ignore
set +e
docker exec manga-api chmod -R -f 777 data
set -e

docker exec manga-api composer install
docker exec manga-worker composer install
#docker exec dev_web_1 composer development-enable
#docker exec dev_web_1 php ./bin/migration-wrapper.php

echo "Application started"
