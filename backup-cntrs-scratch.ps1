# pwsh


# backup containers

# mysql containers
$mysqls = "mysqlsrv1", "mysqlsrv2", "mysqlsrv3"
foreach( $mysql in $mysqls ) {
    docker commit --author="hector.n.sanz@outlook.com" `
                  --message="MariaDB - Hibernate - Spring" `
                  $mysql `
                  $mysql:1.0
}

# tomcat containers
$tomcats = "tomcatsrv1", "tomcatsrv2"
foreach( $tomcat in $tomcats ) {
    docker commit --author="hector.n.sanz@outlook.com" `
                  --message="MariaDB - Hibernate - Spring" `
                  $tomcat `
                  $tomcat:1.0
}

# data-mart container
docker commit --author="hector.n.sanz@outlook.com" `
              --message="MariaDB - Hibernate - Spring" `
              datamart `
              datamart:1.0

# controller container
docker commit --author="hector.n.sanz@outlook.com" `
              --message="MariaDB - Hibernate - Spring" `
              cntlr `
              cntlr:1.0

