#!/bin/bash

# stop containers (to restart later)
docker compose --file compose-from-scratch.yml --env-file env/labs stop
