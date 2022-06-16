#!/bin/bash

echo "Starting docker-compose-prod.yml..."
docker-compose --file docker-compose.prod.yml --env-file osmt-prod.env --project-name osmt up --detach
