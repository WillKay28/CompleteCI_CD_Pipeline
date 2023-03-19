#!/bin/bash -v
sudo yum update -y
sudo yum install -y tomcat7-webapps tomcat7-docs-webapp tomcat7-admin-webapps
sudo service tomcat7 start 