#!/bin/bash

# rebuild container images
docker compose --file compose-from-scratch.yml --env-file env/labs build --no-cache
