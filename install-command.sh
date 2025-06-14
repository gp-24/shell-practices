#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run this script with root acces"
    exit 1 
else
    echo "You are running with root access"
fi

dnf install mysql -y

if [ $? -ne 0 ]
then
    echo "MySQL is not installed... going to install it"
else
    echo "MySQL is already installed... Nothing to do"
    exit 1
fi 
dnf install mysql -y

if [ $? -eq 0 ]
then
    echo "Installing MySQL is ... SUCCESS"
else
    echo "Installing MySQL is ... FAILURE"
    exit 1
fi 