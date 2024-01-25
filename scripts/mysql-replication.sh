#!/usr/bin/env bash

# create replication users
# in each mysqlsrv<N> host
# as labs user
sudo cp /stage/ssl/certs/mysqlsrv<N>-client.* /var/lib/mysql/
sudo chown mysql:mysql /var/lib/mysql/mysqlsrv<N>-client.crt
sudo chown mysql:mysql /var/lib/mysql/mysqlsrv<N>-client.key
sudo cp /stage/ssl/certs/root_ca.crt /var/lib/mysql/
sudo chown mysql:mysql /var/lib/mysql/root_ca.crt
mysql -uroot -pMySQL.Labs_4ALL -e "create user 'repl'@'10.0.0.%' identified with caching_sha2_password by 'MySQL.Labs_4ALL' require x509;"
mysql -uroot -pMySQL.Labs_4ALL -e "grant replication slave on *.* to 'repl'@'10.0.0.%';"
mysql -uroot -pMySQL.Labs_4ALL -e "install plugin clone soname 'mysql_clone.so';"
sudo sed -i 's/^#\(server-id\s*=\s*\).*$/\1<N>/' /etc/my.cnf.d/50-server.cnf
sudo systemctl restart mysqld

# in the mysqlsrv1 host
mysql -uroot -pMySQL.Labs_4ALL -e "create user 'clone-donor'@'10.0.0.%' identified by 'MySQL.Labs_4ALL';"
mysql -uroot -pMySQL.Labs_4ALL -e "grant backup_admin on *.* to 'clone-donor'@'10.0.0.%';"
mysql -uroot -pMySQL.Labs_4ALL -e "select User, Host from mysql.user;"

# in the mysqlsrv2 host
# as labs user
mysql -uroot -pMySQL.Labs_4ALL -e "create user 'clone-recipient'@'10.0.0.%' identified by 'MySQL.Labs_4ALL';"
mysql -uroot -pMySQL.Labs_4ALL -e "grant clone_admin on *.* to 'clone-recipient'@'10.0.0.%';"
mysql -uroot -pMySQL.Labs_4ALL -e "select User, Host from mysql.user;"
mysql -uroot -pMySQL.Labs_4ALL -e "set global clone_valid_donor_list='10.0.0.201:3306';"
mysql -uroot -pMySQL.Labs_4ALL -e "show global variables like 'clone_valid_donor_list';"
mysql -uclone-recipient -pMySQL.Labs_4ALL -e "clone instance from 'clone-donor'@'10.0.0.201':3306  identified by 'MySQL.Labs_4ALL';"
mysql -uroot -pMySQL.Labs_4ALL -e "select * from performance_schema.clone_status\G"
mysql -uroot -pMySQL.Labs_4ALL -e "select * from performance_schema.clone_progress\G"

# in each mysqlsrv<N> host
# as labs user
mysql -uroot -pMySQL.Labs_4ALL -e "set global gtid_mode=OFF_PERMISSIVE;"

# in each mysqlsrv<N> host
# as labs user
mysql -uroot -pMySQL.Labs_4ALL -e "set global gtid_mode=ON_PERMISSIVE;"

# in each mysqlsrv<N> host
# as labs user
mysql -uroot -pMySQL.Labs_4ALL -e "set persist enforce_gtid_consistency=ON;"
mysql -uroot -pMySQL.Labs_4ALL -e "set persist gtid_mode=ON;"

# in the mysqlsrv2 host
# as labs user
mysql -uroot -pMySQL.Labs_4ALL -e "change replication source to source_user='repl', source_host='10.0.0.201', source_password='MySQL.Labs_4ALL', source_auto_position=1, source_ssl=1, source_ssl_ca='root_ca.crt', source_ssl_capath='/var/lib/mysql', source_ssl_cert='/var/lib/mysql/mysqlsrv1-client.crt', source_ssl_key='/var/lib/mysql/mysqlsrv1-client.key' for channel 'mysql-repl-2';"
mysql -uroot -pMySQL.Labs_4ALL -e "start replica for channel 'mysql-repl-2';"
mysql -uroot -pMySQL.Labs_4ALL -e "show replica status for channel 'mysql-repl-2'\G"
