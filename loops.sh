#!bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FLODER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FLODER/$SCRIPT_NAME.log"
 
mkdir -p $LOGS_FLODER
echo "script started executing at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root acces $N" | tee -a $LOG_FILE
    exit 1 
else
    echo "You are running with root access" |  tee -a $LOG_FILE
fi

VALIDATE(){

    if [ $? -eq 0 ]
    then
        echo -e "Installing $2 is ... $G SUCCESS $N" | tee  -a $LOG_FILE
    else
        echo -e "Installing $2 is ... $R FAILURE $N" | tee  -a $LOG_FILE
        exit 1
    fi 
}

dnf installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]
then 
    echo "MySQL is not installed... going to install it" | tee  -a $LOG_FILE
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "python3"
else
    echo -e "Nothing to do MySQL... $Y already installed $N" |  tee  -a $LOG_FILE
fi 

dnf list  installed python3 &>>$LOG_FILE
if [ $? -ne 0 ]
then
    echo "python3 is not installed... going to install it"  |  tee  -a $LOG_FILE
    dnf install python3 -y &>>$LOG_FILE
    VALIDATE $? "python3"
else
    echo -e "Nothing to do python... $Y already installed $N" |  tee  -a $LOG_FILE
fi 
    
dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]
then 
    echo "nginx is not installed... going to install it" | tee  -a $LOG_FILE
    dnf install nginx -y &>>$LOG_FILE
    VALIDATE $? "nginx"
else
    echo -e "Nothing to do nginxL... $Y already installed $N" |  tee  -a $LOG_FILE
fi 

