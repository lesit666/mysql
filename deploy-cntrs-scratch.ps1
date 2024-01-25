# pwsh

$Env:COMPOSE_PARALLEL_LIMIT = 1

# Build step
docker compose --file compose-from-scratch.yml --env-file env\labs build # --no-cache

# Run step
docker compose --file compose-from-scratch.yml --env-file env\labs up --detach
