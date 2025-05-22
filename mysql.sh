#!/bin/bash
source ./common.sh
app_name=mysql
check_root

echo "please enter roboshop user password"
read -s MYSQL_PASSWD

dnf install mysql-server -y &>>$logfile
VALIDATE $? "installing mysql"

systemctl enable mysqld
systemctl start mysqld  

VALIDATE $? "enable and start mysql"

mysql_secure_installation --set-root-pass $MYSQL_PASSWD &>>$logfile
check_time