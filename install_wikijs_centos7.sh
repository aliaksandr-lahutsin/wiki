#!/bin/bash

echo =====================================================================================================
echo
echo Install WikiJs + MongoDB on CentOS 7
echo
echo =====================================================================================================
echo
echo Congigure System
echo
sudo yum install epel-release -y
sudo yum groupinstall "Development Tools" -y
sudo yum install gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel -y
echo
echo
echo Instaling Git..
echo
sudo yum remove git -y
sudo yum install http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-2.noarch.rpm -y
sudo yum install git -y
echo
echo
git --version
echo
echo =====================================================================================================
echo
echo Instaling MongoDB...
echo
echo \ 
"""[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
""" > /etc/yum.repos.d/mongodb-org.repo
sudo yum install -y mongodb-org
sudo semanage port -a -t mongod_port_t -p tcp 27017
sudo systemctl enable mongod
sudo systemctl start mongod
echo
echo
mongod --version
echo
echo =====================================================================================================
echo
echo Instaling NodeJs from source..
echo
echo
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
yum install -y nodejs
sudo yum install gcc-c++ make
echo
echo
node --version
echo
echo =====================================================================================================
echo
echo
echo Instaling WikiJs..
echo
cd /opt
mkdir -p wiki
useradd wiki
chown wiki:wiki wiki
curl -sSo- https://wiki.js.org/install.sh | bash
firewall-cmd --zone=public --add-port=4573/tcp
node wiki configure 4573
echo
echo =====================================================================================================
echo
