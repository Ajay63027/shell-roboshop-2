#!/bin/bash
source ./common.sh
app_name=redis
check_root

dnf module disable redis -y &>>$logfile
VALIDATE $? "disabling redis"

dnf module enable redis:7 -y &>>$logfile
VALIDATE $? "enabling redis"

dnf install redis -y &>>$logfile
VALIDATE $? "installing redis"

sed -i -e 's/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>$logfile
VALIDATE $? "opening ip to all and chnaging protected mode"

systemctl enable redis 
systemctl start redis 
VALIDATE $? "enabling and starting redis"
check_time