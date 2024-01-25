# pwsh
# connect with ssh to the docker container

# example: 
#   PS> .\ssh-connect-cntr.ps1 labs mysqlsrv1

# when providing the docker container name (such as mysqlsrv1, mysqlsrv2, cntlrsrv)
$user = $Args[0]
$cntr = $Args[1]
if ([string]::IsNullOrEmpty($user) -or [string]::IsNullOrEmpty($cntr)) {
    Write-Host "Error: user or container is empty"
  } else {
    $port = $(docker container inspect $cntr | ConvertFrom-Json).HostConfig.PortBindings."22/tcp".HostPort
    ssh-keygen -f "$HOME\.ssh\known_hosts" -R "[localhost]:$port" 1> $null 2> $null
    ssh -i .\ssh\keys\labs -l $user -p $port -o StrictHostKeyChecking=no localhost
  }
