#!/bin/bash
source ./common.sh
app_name=payment
check_root

dnf install python3 gcc python3-devel -y &>>$logfile
VALIDATE $? "installing python3"

app_setup

pip3 install -r requirements.txt &>>$logfile
VALIDATE $? "downloading dependies"

sytemd_setup
check_time