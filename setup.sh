#!/bin/bash

AWS_CREDENTIALS_DIRECTORY=$HOME/ansible
AWS_CREDENTIALS_FILE=$AWS_CREDENTIALS_DIRECTORY/aws_keys

if [ ! -f $AWS_CREDENTIALS_FILE ];
then
   mkdir $AWS_CREDENTIALS_DIRECTORY
   echo "File $AWS_CREDENTIALS_FILE does not exist."
   echo "This file must contain keys to connect to AWS."
   echo "Create new keys here: https://console.aws.amazon.com/iam/home#/users"
   echo "I believe the user should have AmazonEC2FullAccess policy attached"
   echo
   echo "You can read more about Access Keys at"
   echo "http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html"
   echo
   read -p "Enter the Access key ID: " ACCESS_ID
   read -p "Enter the Secret access key: " SECRET_ID
   echo "export AWS_ACCESS_KEY_ID=$ACCESS_ID" >> $AWS_CREDENTIALS_FILE
   echo "export AWS_SECRET_ACCESS_KEY=$SECRET_ID" >> $AWS_CREDENTIALS_FILE
fi