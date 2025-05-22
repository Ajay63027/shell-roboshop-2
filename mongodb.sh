#!/bin/bash
source ./common.sh
app_user=mongod
check_user

cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "copied content"

dnf install mongodb-org -y &>>$logfile
VALIDATE $? "mongodb installation"

systemctl enable mongod 
VALIDATE $? "enabling mongod"

systemctl start mongod 
VALIDATE $? "starting mongod"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "changing ip to 0.0.0.0"

systemctl restart mongod
VALIDATE $? "mongodb restart"

check_time