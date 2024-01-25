# Docker

## Powershell Execution Policy to allow running the different ps1 scripts used in these demos
```
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

## Prerequisites

* To have Docker Desktop already installed in your laptop
* To have an internet connection

## MySQL, Router and Controller Docker Containers Deployment

To create the following containers to perform the demo steps:

* cntlrsrv: controller server where MySQL Enterprise Monitor will be configured and running
* router: router server where MySQL Router will be configured and running
* mysqlsrv<N>: mysql servers (where <N> = 1..3) where MySQL Server instances will be configured and running

```
cd <mysql-admin-course-git-repository-directory>
.\deploy-cntrs-scratch.ps1
```

## Docker Containers Reset (re-create)

In the case the containers above must be recreated:

```
.\reset-cntrs-scratch.ps1
```

## Docker Containers Destroy (remove everything)

To remove completely the containers from your laptop:

```
.\destroy-cntrs-scratch.ps1
```

# Provision MySQL Server, MySQL Router, MySQL Shell, MySQL Backup, MySQL Enterprise Monitor Server and MySQL Enterprise Monitor Agent software

In the .\stage\mysql directories download and unzip the software (8.0.35) for RedHat/OracleLinux 9 x86_64 from https://edelivery.oracle.com in the directories:

* .\stage\mysql\backup: MySQL Backup
* .\stage\mysql\shell: MySQL Shell
* .\stage\mysql\server: MySQL Server
* .\stage\mysql\monitor\server: MySQL Enterprise Monitor Server
* .\stage\mysql\monitor\agent: MySQL Enterprise Monitor Agent

# [MySQL] Catchup Environment using Ansible (MySQL, Router and Controller server configuration)

To install and configure:

* 3 MySQL servers: with MySQL Server, Client and Backup software installed

  * mysqlsrv1: w/ a default instance listening in the 3306 tcp port with the hrdb and crmdb sample databases. later manual installation of MySQL Enterprise Monitor agent.
  * mysqlsrv2 and mysqlsrv3: w/ a default instance listening in the 3306 tcp port. later manual installation of MySQL Enterprise Monitor agent.

* 1 MySQL router: with MySQL Client, Shell and Backup software installed

  * router: later manual installation of MySQL Router.

* 1 Controller: with MySQL Client, Shell and Backup software installed

  * cntlrsrv: later manual installation of MySQL Enterprise Monitor server.

All containers has the labs and root operating system users (pwd=MySQL.Labs_4ALL)

All MySQL Server instances (3306) have the root@localhost, k6@% and monitor@% mysql users (pwd=MySQL.Labs_4ALL)

```
PS> .\ssh-connect-cntr.ps1 labs cntlrsrv
[labs@cntlrsrv ~]$ sh /scripts/catchup-00-setup-servers.sh
```

# [SSL] Catchup Environment using Ansible (MySQL, Router and Controller SSL configuration)

To install and configure SSL CA server and certificates:

Download and provision de Small Step CA server and client software in the .\stage\ssl\smallstep directory:

* Step CLI: https://smallstep.com/docs/step-cli/installation/#redhat
* Step CA: https://smallstep.com/docs/step-ca/installation/#redhat

```
PS> .\ssh-connect-cntr.ps1 labs cntlrsrv
[labs@cntlrsrv ~]$ sh /scripts/catchup-01-configure-ssl.sh
```

# Catchup Manual installation of MySQL Enterprise Monitor (Monitoring software and configuration)

## Install MySQL Enterprise Monitor server in cntlrsrv host

```
PS> .\ssh-connect-cntr.ps1 labs cntlrsrv
[labs@cntlrsrv ~]$ sudo dnf install libaio numactl-libs ncurses-compat-libs -y
[labs@cntlrsrv ~]$ cp /stage/mysql/monitor/server/mysqlmonitor-8.0.36.1526-linux-x86_64-installer.bin \
    /tmp/mysqlmonitor-8.0.36.1526-linux-x86_64-installer.bin
[labs@cntlrsrv ~]$ chmod u+x /tmp/mysqlmonitor-8.0.36.1526-linux-x86_64-installer.bin
[labs@cntlrsrv ~]$ sudo mkdir -p /opt/mysql/monitor-server
[labs@cntlrsrv ~]$ sudo /tmp/mysqlmonitor-8.0.36.1526-linux-x86_64-installer.bin --mode unattended \
    --installer-language en \
    --installdir /opt/mysql/monitor-server \
    --system_size small \
    --tomcatport 18080 \
    --tomcatsslport 18443 \
    --tomcat_user mysqlmem \
    --mysql_installation_type bundled \
    --adminuser service_manager \
    --adminpassword MySQL.Labs_4ALL
[labs@cntlrsrv ~]$ sleep 30 
[labs@cntlrsrv ~]$ sudo /opt/mysql/monitor-server/./mysqlmonitorctl.sh status
[labs@cntlrsrv ~]$ 
```

After the installation, navigate in your laptop to the URL: https://localhost:18443 and then setup the MEM accounts:

 * Manager (mgr): password MySQL.Labs_4ALL
 * Agent (agt): password MySQL.Labs_4ALL

## Install MySQL Enterprise Monitor agent in each mysqlsrv<N> host

Repeat the steps bellow in each mysqlsrv<N> host (where <N> from 1 to 3)

```
PS> .\ssh-connect-cntr.ps1 labs mysqlsrv<N>
[labs@mysqlsrv<N> ~]$ cp /stage/mysql/monitor/agent/mysqlmonitoragent-8.0.36.1526-linux-x86-64bit-installer.bin \
   /tmp/mysqlmonitoragent-8.0.36.1526-linux-x86-64bit-installer.bin
[labs@mysqlsrv<N> ~]$ chmod u+x /tmp/mysqlmonitoragent-8.0.36.1526-linux-x86-64bit-installer.bin
[labs@mysqlsrv<N> ~]$ sudo mkdir -p /opt/mysql/monitor-agent
[labs@mysqlsrv<N> ~]$ sudo /tmp/mysqlmonitoragent-8.0.36.1526-linux-x86-64bit-installer.bin --mode unattended \
    --agentservicename mysqlsrv3-mon-agt \
    --agent_installtype database \
    --agent_autocreate false \
    --agentuser agt --agentpassword MySQL.Labs_4ALL \
    --installer-language en \
    --installdir /opt/mysql/monitor-agent \
    --managerhost 10.0.0.10 --managerport 18443 \
    --mysql-identity-source default \
    --mysqlconnmethod socket --mysqlsocket /var/lib/mysql/mysql.sock --mysqluser root --mysqlpassword MySQL.Labs_4ALL
[labs@mysqlsrv<N> ~]$ sleep 30 
[labs@mysqlsrv<N> ~]$ sudo /opt/mysql/monitor-agent/etc/init.d/mysql-monitor-agent status
[labs@mysqlsrv<N> ~]$ sudo /opt/mysql/monitor-agent/etc/init.d/mysql-monitor-agent start
```

After the installation, navigate in your laptop to the URL: https://localhost:18443 and then setup the MySQL Server instances:

* agent mysqlsrv1: instance 3306 at 10.0.0.201 (socket /var/lib/mysql/mysql.sock) w/ root@localhost (pwd=MySQL.Labs_4ALL)
* agent mysqlsrv1: instance 3306 at 10.0.0.202 (socket /var/lib/mysql/mysql.sock) w/ root@localhost (pwd=MySQL.Labs_4ALL)
* agent mysqlsrv1: instance 3306 at 10.0.0.203 (socket /var/lib/mysql/mysql.sock) w/ root@localhost (pwd=MySQL.Labs_4ALL)

# Catchup Manual configuration of MySQL Standard Replication

## Create replication users in each mysqlsrv<N> host MySQL Server instance, install the Clone plugin and set a unique server ID <N> to each instance:

Repeat the steps bellow in each mysqlsrv<N> host (where <N> from 1 to 3):

```
PS> .\ssh-connect-cntr.ps1 labs mysqlsrv<N>
[labs@mysqlsrv<N> ~]$ sudo cp /stage/ssl/certs/mysqlsrv<N>-client.* /var/lib/mysql/
[labs@mysqlsrv<N> ~]$ sudo chown mysql:mysql /var/lib/mysql/mysqlsrv<N>-client.crt
[labs@mysqlsrv<N> ~]$ sudo chown mysql:mysql /var/lib/mysql/mysqlsrv<N>-client.key
[labs@mysqlsrv<N> ~]$ sudo cp /stage/ssl/certs/root_ca.crt /var/lib/mysql/
[labs@mysqlsrv<N> ~]$ sudo chown mysql:mysql /var/lib/mysql/root_ca.crt
mysql -uroot -pMySQL.Labs_4ALL -e "create user 'repl'@'10.0.0.%' identified with caching_sha2_password by 'MySQL.Labs_4ALL' require x509;"
mysql -uroot -pMySQL.Labs_4ALL -e "grant replication slave on *.* to 'repl'@'10.0.0.%';"
mysql -uroot -pMySQL.Labs_4ALL -e "install plugin clone soname 'mysql_clone.so';"
sudo sed -i 's/^#\(server-id\s*=\s*\).*$/\1<N>/' /etc/my.cnf.d/50-server.cnf
sudo systemctl restart mysqld
```

## Create the clone donor user in the mysqlsrv1 (used from mysqlsrv2 and mysqlsrv3 to connect to mysqlsrv1 and clone the hrdb and crmdb databases)

Connect only to mysqlsrv1 and run the following commands:

```
PS> .\ssh-connect-cntr.ps1 labs mysqlsrv1
[labs@mysqlsrv1 ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "create user 'clone-donor'@'10.0.0.%' identified by 'MySQL.Labs_4ALL';"
[labs@mysqlsrv1 ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "grant backup_admin on *.* to 'clone-donor'@'10.0.0.%';"
[labs@mysqlsrv1 ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "select User, Host from mysql.user;"
```

## Create the clone recipient user in the mysqlsrv2 and mysqlsrv3 (used in mysqlsrv2 and mysqlsrv3 to connect to create the hrdb and crmdb databases from the clone)

Repeat the steps bellow in each mysqlsrv<N> hosts (where <N> 2 and 3):

```
PS> .\ssh-connect-cntr.ps1 labs mysqlsrv<N>
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "create user 'clone-recipient'@'10.0.0.%' identified by 'MySQL.Labs_4ALL';"
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "grant clone_admin on *.* to 'clone-recipient'@'10.0.0.%';"
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "select User, Host from mysql.user;"
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "set global clone_valid_donor_list='10.0.0.201:3306';"
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "show global variables like 'clone_valid_donor_list';"
[labs@mysqlsrv<N> ~]$ mysql -uclone-recipient -pMySQL.Labs_4ALL -e "clone instance from 'clone-donor'@'10.0.0.201':3306  identified by 'MySQL.Labs_4ALL';"
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "select * from performance_schema.clone_status\G"
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "select * from performance_schema.clone_progress\G"
```

## Change the enforce_gtid variable to ON in eac mysqlsrv<N> instance

Repeat the steps bellow in each mysqlsrv<N> host (where <N> from 1 to 3):

```
PS> .\ssh-connect-cntr.ps1 labs mysqlsrv<N>
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "set global gtid_mode=OFF_PERMISSIVE;"
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "set global gtid_mode=ON_PERMISSIVE;"
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "set persist enforce_gtid_consistency=ON;"
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "set persist gtid_mode=ON;"
```

## Configure and start the standard replication in mysqlsrv2 and mysqlsrv3

Repeat the steps bellow in each mysqlsrv<N> hosts (where <N> 2 and 3):

```
PS> .\ssh-connect-cntr.ps1 labs mysqlsrv<N>
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "change replication source to source_user='repl', source_host='10.0.0.201', source_password='MySQL.Labs_4ALL', source_auto_position=1, source_ssl=1, source_ssl_ca='root_ca.crt', source_ssl_capath='/var/lib/mysql', source_ssl_cert='/var/lib/mysql/[labs@mysqlsrv<N> ~]$ mysqlsrv1-client.crt', source_ssl_key='/var/lib/mysql/mysqlsrv1-client.key' for channel 'mysql-repl-2';"
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "start replica for channel 'mysql-repl-2';"
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -e "show replica status for channel 'mysql-repl-2'\G"
```

# Catchup Manual configuration of MySQL InnoDB Cluster Replication

## Create a new mysqlsrv<N> host MySQL Server instance (port=3307, socket=/u01/app/mysql/mysql.sock):

Repeat the steps bellow in each mysqlsrv<N> host (where <N> from 1 to 3):

```
PS> .\ssh-connect-cntr.ps1 labs mysqlsrv<N>
[labs@mysqlsrv<N> ~]$ sudo cp /scripts/my-innodb-cluster.cnf /etc/
[labs@mysqlsrv<N> ~]$ sudo mkdir -p /u01/app/mysql
[labs@mysqlsrv<N> ~]$ sudo chown -R mysql:mysql /u01/app/mysql
[labs@mysqlsrv<N> ~]$ sudo mysqld --defaults-file=/etc/my-innodb-cluster.cnf --user=mysql --initialize
[labs@mysqlsrv<N> ~]$ sudo grep temporary /u01/app/mysql/mysqld.log <---- temporary password
[labs@mysqlsrv<N> ~]$ sudo cp /labs/mod-00/scripts/mysqld-innodb-cluster.service /etc/systemd/system
[labs@mysqlsrv<N> ~]$ sudo systemctl daemon-reload
[labs@mysqlsrv<N> ~]$ sudo systemctl enable --now mysqld-innodb-cluster
[labs@mysqlsrv<N> ~]$ mysql -uroot -p -S /u01/app/mysql/mysql.sock <---- temporary password
[labs@mysqlsrv<N> ~]$ alter user USER() identified by 'MySQL.Labs_4ALL';
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -S /u01/app/mysql/mysql.sock -e "SELECT VERSION();"
[labs@mysqlsrv<N> ~]$ mysql -uroot -pMySQL.Labs_4ALL -S /u01/app/mysql/mysql.sock -e "rename user 'root'@'localhost' to 'root'@'%';"
```

## Create the MySQL InnoDB Cluster in the mysqlsrv<N> hosts from the cntlrsrv host (boostrap)

Execute the following steps in the cntlrsrv host to check and configure (prerequisites) each mysqlsrv<N> instance (3307):

```
PS> .\ssh-connect-cntr.ps1 labs cntlrsrv
[labs@cntlrsrv ~]$ mysqlsh --js
MySQL JS> results = dba.checkInstanceConfiguration('root@10.0.0.201:3307',
            { mycnfPath: '', 
              password: 'MySQL.Labs_4ALL', 
              interactive: false });
MySQL JS> print(results);
MySQL JS> 
MySQL JS> results = dba.configureInstance('root@10.0.0.201:3307',
            { mycnfPath: '',
              outputMycnfPath: '',
              password: 'MySQL.Labs_4ALL',
              clusterAdmin:'', 
              clearReadOnly: true,
              restart: true,
              interactive: false,
              applierWorkerThreads: 4 });
MySQL JS> print(results);
MySQL JS> 
MySQL JS> results = dba.configureInstance('root@10.0.0.202:3307',
            { mycnfPath: '',
              outputMycnfPath: '',
              password: 'MySQL.Labs_4ALL',
              clusterAdmin:'', 
              clearReadOnly: true,
              restart: true,
              interactive: false,
              applierWorkerThreads: 4 });
MySQL JS> print(results);
MySQL JS> 
MySQL JS> results = dba.configureInstance('root@10.0.0.203:3307',
            { mycnfPath: '',
              outputMycnfPath: '',
              password: 'MySQL.Labs_4ALL',
              clusterAdmin:'', 
              clearReadOnly: true,
              restart: true,
              interactive: false,
              applierWorkerThreads: 4 });
MySQL JS> print(results);
MySQL JS> \q
[labs@cntlrsrv ~]$ 
```

Execute the following steps in the cntlrsrv host to connect to the mysqlsrv1 instance (3307) and from there create the MySQL InnoDB Cluster and add the other members (mysqlsrv<N> where <N> = 2 to 3):

```
PS> .\ssh-connect-cntr.ps1 labs cntlrsrv
[labs@cntlrsrv ~]$ mysqlsh -uroot -pMySQL.Labs_4ALL -P3307 -h10.0.0.201 --js
MySQL JS> cluster = dba.createCluster('labs-cluster',
            { disableClone: false,
              gtidSetIsComplete: false,
              multiPrimary: false,
              memberSslMode: 'REQUIRED',
              memberAuthType: 'PASSWORD',
              localAddress: '10.0.100.201:3307',
              replicationAllowedHost: '10.0.100.%',
              manualStartOnBoot: false,
              exitStateAction: 'READ_ONLY',
              consistency: 'EVENTUAL',
              memberWeight: 50,
              expelTimeout: 5,
              autoRejoinTries: 3,
              communicationStack: 'MySQL',
              transactionSizeLimit: 0,
              paxosSingleLeader: false });
MySQL JS> cluster.status();
MySQL JS> 
MySQL JS> cluster.addInstance('root@10.0.0.202:3307',
            { recoveryMethod: 'incremental',
              waitRecovery: 1,
              password: 'MySQL.Labs_4ALL',
              localAddress: '10.0.0.202:3307', 
              exitStateAction: 'READ_ONLY',
              memberWeight: 50,
              interactive: false,
              autoRejoinTries: 3 });
MySQL JS> cluster.status();
MySQL JS> 
MySQL JS> cluster.addInstance('root@10.0.0.203:3307',
            { recoveryMethod: 'incremental',
              waitRecovery: 1,
              password: 'MySQL.Labs_4ALL',
              localAddress: '10.0.0.203:3307', 
              exitStateAction: 'READ_ONLY',
              memberWeight: 50,
              interactive: false,
              autoRejoinTries: 3 });
MySQL JS> cluster.status();
MySQL JS> 
```

# Catchup Manual configuration of MySQL Router

## Create a router in the router host to balance the connections to the MySQL InnoDB Cluster members:

For the MySQL Classic protocol the router will listen to balance the connections in the following way:

* Read/Write Connections: localhost:6446, /opt/mysql-router/mysql.sock
* Read/Only Connections:  localhost:6447, /opt/mysql-router/mysqlro.sock

Execute the following commands in the router host to bootstrap the router configuration and the to run the router in background and test the connection to the MySQL InnoDB Cluster members:

```
PS> .\ssh-connect-cntr.ps1 labs router
[labs@router ~]$ sudo dnf install /stage/mysql/router/mysql-router-commercial-8.0.35-1.1.el9.x86_64.rpm -y
[labs@router ~]$ sudo dnf install /stage/mysql/shell/mysql-shell-commercial-8.0.35-1.1.el9.x86_64.rpm -y
[labs@router ~]$ sudo mkdir -p /opt/mysql-router
[labs@router ~]$ sudo chown -R labs:labs /opt/mysql-router
[labs@router ~]$ mysqlrouter --bootstrap root@10.0.0.201:3307 --directory /opt/mysql-router \
  --conf-use-sockets --account router-user --account-create always \
  --name labs-router
[labs@router ~]$ cat /opt/mysql-router/mysqlrouter.conf
[labs@router ~]$ mysqlrouter -c /opt/mysql-router/mysqlrouter.conf &
[labs@router ~]$ echo "select @@hostname;" | mysqlsh --uri root@localhost:6446 --password --sql 
[labs@router ~]$ mysql -uroot -pMySQL.Labs_4ALL -hlocalhost -P6447 --protocol=tcp -e "select @@hostname;"
[labs@router ~]$ mysql -uroot -pMySQL.Labs_4ALL -hlocalhost -P6447 --protocol=tcp -e "select @@hostname;"
[labs@router ~]$ mysql -uroot -pMySQL.Labs_4ALL -hlocalhost -P6447 --protocol=tcp -e "select @@hostname;"
[labs@router ~]$ mysql -uroot -pMySQL.Labs_4ALL -hlocalhost -P6447 --protocol=tcp -e "select @@hostname;"
[labs@router ~]$ mysql -uroot -pMySQL.Labs_4ALL -hlocalhost -P6447 --protocol=tcp -e "select @@hostname;"
[labs@router ~]$ mysql -uroot -pMySQL.Labs_4ALL -hlocalhost -P6447 --protocol=tcp -e "select @@hostname;"
```

