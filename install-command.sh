#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run this script with root acces"
    exit 1 
else
    echo "You are running with root access"
fi

dnf install mysqlsdffsf -y

if [ $? -eq 0 ]
then
    echo "Installing MySQL is ... SUCCESS"
else
    echo "Installing MySQL is ... FAILURE"
    exit 1
fi 