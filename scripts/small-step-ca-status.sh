#!/usr/bin/env bash

# in the cntlrsrv host (small step ca server)
# as labs user
sudo systemctl status step-ca --no-pager
# as step user
step ca health --ca-url=https://cntlrsrv.labs.io --root=$HOME/.step/certs/root_ca.crt 

# encripted connection using ssl mode VERIFY_CA | VERIFY_IDENTITY (ssl-ca must be provided)
mysql -umonitor -pMySQL.Labs_4ALL \
    -hmysqlsrv1.labs.io -P3306 --protocol=tcp \
    --ssl-mode=VERIFY_CA --ssl-ca=/stage/ssl/certs/root_ca.crt \
    -e "status;"

# encripted connection using ssl mode REQUIRED and user account created with REQURE X509
# as step user create the client certificate
step ca certificate cntlrsrv.labs.io \
    /tmp/cntlrsrv.crt /tmp/cntlrsrv.key \
    --provisioner-password-file=/etc/step-ca/smallstep-provisioner-password
# as root user provision the client certificate
mv /tmp/cntlrsrv.* /stage/ssl/certs/
chmod 644 /stage/ssl/certs/cntlrsrv.*
# as labs user create the user account to REQUIRE X509
mysql -uk6 -pMySQL.Labs_4ALL -hmysqlsrv1.labs.io -P3306 --protocol=tcp -e "DROP USER IF EXISTS 'root-ssl'@'%';"
mysql -uk6 -pMySQL.Labs_4ALL -hmysqlsrv1.labs.io -P3306 --protocol=tcp -e "CREATE USER 'root-ssl'@'%' IDENTIFIED WITH caching_sha2_password BY 'MySQL.Labs_4ALL' REQUIRE X509;"
# connect as root-ssl user to the mysql server instance (ssl-ca, ssl-cert and ssl-key must be provided)
mysql -uroot-ssl -pMySQL.Labs_4ALL -hmysqlsrv1.labs.io -P3306 --protocol=tcp \
    --ssl-mode=REQUIRED \
    --ssl-ca=/stage/ssl/certs/root_ca.crt \
    --ssl-cert=/stage/ssl/certs/cntlrsrv.crt \
    --ssl-key=/stage/ssl/certs/cntlrsrv.key \
    -e "status;"
