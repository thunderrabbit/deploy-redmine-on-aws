#!/bin/bash

echo "Securing passwords which we will use in playbooks..."

echo "Changing mysql root password."
FILE_TO_CHANGE=~/deploy-redmine-on-aws/vars/vars_for_geerling.mysql.yml
PRE_PASSWORD="mysql_root_password: '"
POST_PASSWORD="'"
NEW_PWD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

sed -i "s/$PRE_PASSWORD.*$POST_PASSWORD/$PRE_PASSWORD$NEW_PWD$POST_PASSWORD/" $FILE_TO_CHANGE

echo "Changing mysql sample user password."
PRE_PASSWORD="    password: '"
POST_PASSWORD="'"
NEW_PWD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

sed -i "s/$PRE_PASSWORD.*$POST_PASSWORD/$PRE_PASSWORD$NEW_PWD$POST_PASSWORD/" $FILE_TO_CHANGE

echo "Changing redmine mysql password."
FILE_TO_CHANGE=~/deploy-redmine-on-aws/vars/vars_for_redmine-ansible.yml
PRE_PASSWORD="redmine_db_passwd: '"
POST_PASSWORD="'"
NEW_PWD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

sed -i "s/$PRE_PASSWORD.*$POST_PASSWORD/$PRE_PASSWORD$NEW_PWD$POST_PASSWORD/" $FILE_TO_CHANGE

echo "Changing redmine admin login password."
PRE_PASSWORD="redmine_admin_passwd: '"
POST_PASSWORD="'"
NEW_PWD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

sed -i "s/$PRE_PASSWORD.*$POST_PASSWORD/$PRE_PASSWORD$NEW_PWD$POST_PASSWORD/" $FILE_TO_CHANGE

echo "Finished changing passwords."
