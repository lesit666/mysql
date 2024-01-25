#!/usr/bin/env bash

# create mysql server instances (each mysqlsrv<N>)
sudo cp /labs/mod-00/scripts/my-innodb-cluster.cnf /etc/
sudo mkdir -p /u01/app/mysql
sudo chown -R mysql:mysql /u01/app/mysql

sudo mysqld --defaults-file=/etc/my-innodb-cluster.cnf --user=mysql --initialize
sudo cat /u01/app/mysql/mysqld.log <---- temporary password
sudo cp /labs/mod-00/scripts/mysqld-innodb-cluster.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable --now mysqld-innodb-cluster
mysql -uroot -p -S /u01/app/mysql/mysql.sock <---- temporary password
alter user USER() identified by 'MySQL.Labs_4ALL';
mysql -uroot -pMySQL.Labs_4ALL -S /u01/app/mysql/mysql.sock -e "SELECT VERSION();"
mysql -uroot -pMySQL.Labs_4ALL -S /u01/app/mysql/mysql.sock -e "rename user 'root'@'localhost' to 'root'@'%';"

# create mysql innodb cluster (cntlrsrv)
mysqlsh --js

results = dba.checkInstanceConfiguration('root@10.0.0.201:3307',
        { mycnfPath: '', 
          password: 'MySQL.Labs_4ALL', 
          interactive: false });
print(results);

results = dba.configureInstance('root@10.0.0.201:3307',
        { mycnfPath: '',
          outputMycnfPath: '',
          password: 'MySQL.Labs_4ALL',
          clusterAdmin:'', 
          clearReadOnly: true,
          restart: true,
          interactive: false,
          applierWorkerThreads: 4 });
print(results);

results = dba.configureInstance('root@10.0.0.202:3307',
        { mycnfPath: '',
          outputMycnfPath: '',
          password: 'MySQL.Labs_4ALL',
          clusterAdmin:'', 
          clearReadOnly: true,
          restart: true,
          interactive: false,
          applierWorkerThreads: 4 });
print(results);

results = dba.configureInstance('root@10.0.0.203:3307',
        { mycnfPath: '',
          outputMycnfPath: '',
          password: 'MySQL.Labs_4ALL',
          clusterAdmin:'', 
          clearReadOnly: true,
          restart: true,
          interactive: false,
          applierWorkerThreads: 4 });
print(results);

\q

mysqlsh -uroot -pMySQL.Labs_4ALL -P3307 -h10.0.0.201 --js
cluster = dba.createCluster('labs-cluster',
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
cluster.status();

results = cluster.addInstance('root@10.0.0.202:3307',
        { recoveryMethod: 'incremental',
          waitRecovery: 1,
          password: 'MySQL.Labs_4ALL',
          localAddress: '10.0.0.202:3307', 
          exitStateAction: 'READ_ONLY',
          memberWeight: 50,
          interactive: false,
          autoRejoinTries: 3 });
print(results);

results = cluster.addInstance('root@10.0.0.203:3307',
        { recoveryMethod: 'incremental',
          waitRecovery: 1,
          password: 'MySQL.Labs_4ALL',
          localAddress: '10.0.0.203:3307', 
          exitStateAction: 'READ_ONLY',
          memberWeight: 50,
          interactive: false,
          autoRejoinTries: 3 });
print(results);

# mysql router (router)
sudo dnf install /stage/mysql/router/mysql-router-commercial-8.0.35-1.1.el9.x86_64.rpm -y
sudo dnf install /stage/mysql/shell/mysql-shell-commercial-8.0.35-1.1.el9.x86_64.rpm -y

sudo mkdir -p /opt/mysql-router
sudo chown -R labs:labs /opt/mysql-router

mysqlrouter --bootstrap root@10.0.0.201:3307 --directory /opt/mysql-router \
  --conf-use-sockets --account router-user --account-create always \
  --name labs-router
# provide the password for root and for the new created user router-user
# (the user is replicated to all other nodes in the cluster)

cat /opt/mysql-router/mysqlrouter.conf

mysqlrouter -c /opt/mysql-router/mysqlrouter.conf &

## MySQL Classic protocol

# - Read/Write Connections: localhost:6446, /opt/mysql-router/mysql.sock
# - Read/Only Connections:  localhost:6447, /opt/mysql-router/mysqlro.sock

## MySQL X protocol

# - Read/Write Connections: localhost:6448, /opt/mysql-router/mysqlx.sock
# - Read/Only Connections:  localhost:6449, /opt/mysql-router/mysqlxro.sock


echo "select @@hostname;" | mysqlsh --uri root@localhost:6446 --password --sql 
mysql -uroot -pMySQL.Labs_4ALL -hlocalhost -P6447 --protocol=tcp -e "select @@hostname;"
mysql -uroot -pMySQL.Labs_4ALL -hlocalhost -P6447 --protocol=tcp -e "select @@hostname;"
mysql -uroot -pMySQL.Labs_4ALL -hlocalhost -P6447 --protocol=tcp -e "select @@hostname;"
