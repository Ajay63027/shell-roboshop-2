#!/bin/bash
source ./common.sh
app_name=rabbitmq
check_root
echo "please enter rabbitmq user password"
read -s rabbitmq_PASSWD

cp $script_dir/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo

dnf install rabbitmq-server -y &>>$logfile
VALIDATE $? "installing rabbitmq"

systemctl enable rabbitmq-server &>>$logfile
systemctl start rabbitmq-server &>>$logfile
VALIDATE $? "enabling and start rabbitmq"

rabbitmqctl add_user roboshop $rabbitmq_PASSWD &>>$logfile
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$logfile
check_time