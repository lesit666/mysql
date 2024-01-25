#!/usr/bin/env bash

# pass the backup directory as the first argument (contents will be deleted)
bkpdir=$1

# use the /stage/backup directory
sudo rm -Rf /stage/backup/$bkpdir
# sudo mkdir -p /stage/backup/$bkpdir/{innodb_data,innodb_redo,innodb_undo,logs}

# setup mysql backup utility settings
sudo cp /labs/mod-00/scripts/backup-my.cnf /root/backup-my.cnf

# show the binary log file position
mysql -uk6 -pMySQL.Labs_4ALL -hmysqlsrv1.labs.io -P3306 --protocol=tcp -e "show binary logs;"

# perform full backup of the mysql server 1
sudo -u root bash <<EOF
export MYSQL_OPT_RECONNECT=FALSE
mysqlbackup --defaults-file=/root/backup-my.cnf \
  --backup-dir=/stage/backup/$bkpdir backup
EOF

sudo ls -la /stage/backup/$bkpdir

# update the full backup of the mysql server 1 by applying the redo log files (and archive logs) contents
sudo -u root bash <<EOF
export MYSQL_OPT_RECONNECT=FALSE
mysqlbackup --defaults-file=/root/backup-my.cnf \
  --backup-dir=/stage/backup/$bkpdir apply-log
EOF

# OR both steps above in just one
# sudo -u root bash <<EOF
# export MYSQL_OPT_RECONNECT=FALSE
# mysqlbackup --defaults-file=/root/backup-my.cnf \
#   --backup-dir=/stage/backup/$bkpdir backup-and-apply-log
# EOF
