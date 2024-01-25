#/usr/bin/env bash

sudo dnf install libaio numactl-libs ncurses-compat-libs -y

# install mysql enterprise monitor server (cntlrsrv)
cp /stage/mysql/monitor/server/mysqlmonitor-8.0.36.1526-linux-x86_64-installer.bin \
   /tmp/mysqlmonitor-8.0.36.1526-linux-x86_64-installer.bin
chmod u+x /tmp/mysqlmonitor-8.0.36.1526-linux-x86_64-installer.bin
sudo mkdir -p /opt/mysql/monitor-server

sudo /tmp/mysqlmonitor-8.0.36.1526-linux-x86_64-installer.bin --mode unattended \
    --installer-language en \
    --installdir /opt/mysql/monitor-server \
    --system_size small \
    --tomcatport 18080 \
    --tomcatsslport 18443 \
    --tomcat_user mysqlmem \
    --mysql_installation_type bundled \
    --adminuser service_manager \
    --adminpassword MySQL.Labs_4ALL

sleep 30 

sudo /opt/mysql/monitor-server/./mysqlmonitorctl.sh status

sudo dnf install mysql -y

mysql -uservice_manager -pInnoDB.Cluster_4ALL -hlocalhost -P13306 --protocol=tcp \
    -e "CREATE USER 'labs-conf'@'%' IDENTIFIED BY 'InnoDB.Cluster_4ALL';"

mysql -uservice_manager -pInnoDB.Cluster_4ALL -hlocalhost -P13306 --protocol=tcp \
    -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO 'labs-conf'@'%' WITH GRANT OPTION;"

CWD=$PWD
cd /shared-dir/mysql-schemas/hr

# Create hr account and hrdb schema
mysql --user=labs-conf --password=MySQL.Labs_4ALL --host=localhost --port=13306 --protocol=tcp \
    -t --local-infile=1 < ./main.sql > ./main.log 2>&1


# install mysql enterprise monitor agent (each mysqlsrv<N> host)
sudo rm -Rf /opt/mysql/monitor-agent
cp /stage/mysql/monitor/agent/mysqlmonitoragent-8.0.36.1526-linux-x86-64bit-installer.bin \
   /tmp/mysqlmonitoragent-8.0.36.1526-linux-x86-64bit-installer.bin
chmod u+x /tmp/mysqlmonitoragent-8.0.36.1526-linux-x86-64bit-installer.bin
sudo mkdir -p /opt/mysql/monitor-agent

sudo /tmp/mysqlmonitoragent-8.0.36.1526-linux-x86-64bit-installer.bin --mode unattended \
    --agentservicename mysqlsrv3-mon-agt \
    --agent_installtype database \
    --agent_autocreate false \
    --agentuser agt --agentpassword MySQL.Labs_4ALL \
    --installer-language en \
    --installdir /opt/mysql/monitor-agent \
    --managerhost 10.0.0.10 --managerport 18443 \
    --mysql-identity-source default \
    --mysqlconnmethod socket --mysqlsocket /var/lib/mysql/mysql.sock --mysqluser root --mysqlpassword MySQL.Labs_4ALL

# --generaluser general --generalpassword MySQL.Labs_4ALL --limiteduser limited --limitedpassword MySQL.Labs_4ALL

sleep 30 

sudo /opt/mysql/monitor-agent/etc/init.d/mysql-monitor-agent status
sudo /opt/mysql/monitor-agent/etc/init.d/mysql-monitor-agent start

cd $CWD

