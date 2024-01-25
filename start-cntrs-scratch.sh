#!/bin/bash

# start containers (from the last state)
docker compose --file compose-from-scratch.yml --env-file env/labs start
