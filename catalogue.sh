#!/bin/bash
app_name=catalogue

source ./common.sh
check_root
app_setup
nodejs_setup
sytemd_setup

cp $script_dir/mongoclient.repo /etc/yum.repos.d/mongo.repo

dnf install mongodb-mongosh -y &>>$logfile
VALIDATE $? "installing mongoclient"

STATUS=$(mongosh --host mongodb.ajay6.space --eval 'db.getMongo().getDBNames().indexOf("catalogue")' --quiet)
if [ $STATUS -lt 0 ];then
mongosh --host mongodb.ajay6.space </app/db/master-data.js &>>$logfile
VALIDATE $? "loading data" 
else
echo -e "already data existed $Y SKIP THIS PART $N"
fi
check_time




