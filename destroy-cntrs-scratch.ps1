# pwsh

# remove containers, volumes, networks and images
$Env:COMPOSE_PARALLEL_LIMIT = 1
docker compose --file compose-from-scratch.yml --env-file env\labs down --volumes --rmi all
