# pwsh

# recreate the containers
docker compose --file compose-from-scratch.yml --env-file env\labs down --timeout 0 --volumes
docker compose --file compose-from-scratch.yml --env-file env\labs up --detach
