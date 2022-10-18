#!/bin/bash

# 下载
wget https://download.bell-sw.com/java/11.0.16.1+1/bellsoft-jdk11.0.16.1+1-linux-amd64.tar.gz
wget https://downloads.gradle-dn.com/distributions/gradle-7.5.1-bin.zip
wget https://nodejs.org/dist/v16.18.0/node-v16.18.0-linux-x64.tar.xz
wget https://image.guiyunweb.com/2021/maven-mvnd-0.8.2-linux-amd64.tar.gz

# 解压
tar -zxvf bellsoft-jdk11.0.16.1+1-linux-amd64.tar.gz
unzip gradle-7.5.1-bin.zip 
tar -xvf node-v16.18.0-linux-x64.tar.xz 
tar -zxvf maven-mvnd-0.8.2-linux-amd64.tar.gz

mv jdk-11.0.16.1 /usr/local/jdk
mv gradle-7.5.1 /usr/local/gradle
mv node-v16.18.0-linux-x64 /usr/local/node/
mv maven-mvnd-0.8.2-linux-amd64 /usr/local/mvnd/

cat << EOF >> /etc/profile

JAVA_HOME=/usr/local/jdk/
PATH=$JAVA_HOME/bin:$PATH:.
CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:.
export JAVA_HOME
export PATH
export CLASSPAT

export PATH=/usr/local/gradle/bin/:$PATH
export PATH=/usr/local/node/bin/:$PATH
export PATH=/usr/local/mvnd/bin/:$PATH
EOF
