#!/bin/bash

echo '########## Gitlab Runner 环境搭建 ###########'
apt-get update && apt-get install -y git wget  unzip curl
wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.3.0/graalvm-ce-java17-linux-amd64-22.3.0.tar.gz
wget https://nodejs.org/download/release/v16.19.0/node-v16.19.0-linux-x64.tar.gz
wget https://github.com/apache/maven-mvnd/releases/download/1.0.0-m1/maven-mvnd-1.0.0-m1-linux-amd64.tar.gz
wget https://downloads.gradle-dn.com/distributions/gradle-7.6-bin.zip

echo '########## 安装JDK ###########'

mkdir /usr/local/java
tar -zxvf graalvm-ce-java17-linux-amd64-22.3.0.tar.gz
mv graalvm-ce-java17-22.3.0/ /usr/local/java/jdk17
tar -zxvf maven-mvnd-1.0.0-m1-linux-amd64.tar.gz

mv maven-mvnd-1.0.0-m1-linux-amd64/ /usr/local/java/mvnd
unzip gradle-7.6-bin.zip
mv gradle-7.6 /usr/local/java/gradle


echo '########## Node.js环境 ###########'

tar -zxvf node-v16.19.0-linux-x64.tar.gz
mv node-v16.19.0-linux-x64/ /usr/local/node
npm install -g npm@9.2.0
npm install --global yarn

echo '########## 环境变量配置 ###########'


cat << 'EOF' >> /etc/profile

JAVA_HOME=/usr/local/java/jdk17
PATH=$JAVA_HOME/bin:$PATH:.
CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar:.
export JAVA_HOME
export PATH
export CLASSPAT

export PATH=/usr/local/java/mvnd/bin:$PATH
export PATH=/usr/local/java/gradle/bin:$PATH

export PATH=/usr/local/node/bin:$PATH
export PATH=/usr/local/java/mvnd/mvn/bin:$PATH

EOF


echo "########## 安装Docker ###########'"
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh
systemctl enable docker
systemctl start docker
echo '########## 安装完成 ###########'