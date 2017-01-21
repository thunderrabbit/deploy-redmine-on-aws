#!/bin/bash

AWS_ANSIBLE_DIRECTORY=$HOME/ansible
AWS_CREDENTIALS_FILE=$AWS_ANSIBLE_DIRECTORY/aws_keys

if [ ! -d $AWS_ANSIBLE_DIRECTORY ];
then
    mkdir $AWS_ANSIBLE_DIRECTORY
fi

if [ ! -f $AWS_ANSIBLE_DIRECTORY/ec2.ini ];
then
    cd $AWS_ANSIBLE_DIRECTORY
    curl https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini > ec2.ini
    curl https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py > ec2.py
    chmod 755 ec2.py

    ## git all the things
    git init
    git add ec2.py ec2.ini
    git commit -m "Initial versions of ec2.py and ec2.ini

    as pulled from
    curl https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py > ec2.py
    curl https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini > ec2.ini"

    # Focus on only one region, which seems to make things much faster.
    # TODO: make us-west-1 be specified by user when setup.sh is run
    sed -i 's/regions = all/regions = us-west-1/' ec2.ini

    git add ec2.ini
    git commit -m "Speed up requests by targeting just one region."

    echo aws_keys* >> .gitignore
    git add .gitignore
    git commit -m "Ignore aws_keys files which will be added to this directory soon."
fi

if [ ! -f $AWS_CREDENTIALS_FILE ];
then
   echo "File $AWS_CREDENTIALS_FILE does not exist."
   echo "This file must contain keys to connect to AWS."
   echo "Create new keys here: https://console.aws.amazon.com/iam/home#/users"
   echo "The user associated with these keys should have (at least) the following policies"
   echo
   echo "* AmazonEC2FullAccess"
   echo "* AmazonRDSReadOnlyAccess"
   echo "* AmazonElastiCacheReadOnlyAccess"
   echo
   echo "You can read more about Access Keys at"
   echo "http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html"
   echo
   read -p "Enter the Access key ID: " ACCESS_ID
   read -p "Enter the Secret access key: " SECRET_ID
   echo "export AWS_ACCESS_KEY_ID='$ACCESS_ID'" >> $AWS_CREDENTIALS_FILE
   echo "export AWS_SECRET_ACCESS_KEY='$SECRET_ID'" >> $AWS_CREDENTIALS_FILE
   source $AWS_CREDENTIALS_FILE
   echo "Keys have been saved and loaded into Environment vars so we can connect to AWS."
   echo "Testing connection with ~/ansible/ec2.py --refresh-cache"
   ~/ansible/ec2.py --refresh-cache
fi