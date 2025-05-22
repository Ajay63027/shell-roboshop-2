#!/bin/bash
source ./common.sh
app_name=shipping
check_root

echo "please enter roboshop user password"
read -s MYSQL_PASSWD

app_setup
maven_setup
sytemd_setup

dnf install mysql -y  &>>$logfile
VALIDATE $? "installing mysql client"

mysql -h mysql.ajay6.space -uroot -p$MYSQL_PASSWD < /app/db/schema.sql &>>$logfile
mysql -h mysql.ajay6.space -uroot -p$MYSQL_PASSWD < /app/db/app-user.sql  &>>$logfile
mysql -h mysql.ajay6.space -uroot -p$MYSQL_PASSWD < /app/db/master-data.sql &>>$logfile
VALIDATE $? "loading data successfull"

check_time
