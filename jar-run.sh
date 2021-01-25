#!/bin/sh
#Jar包名称，注意：不要带有.jar
apiID=$(ps -ef |grep 'app.jar'|grep -v 'grep'| awk '{print $2}')
# run
# 判断进程是否存在
if test $apiID ;then
    # 杀死进程
    kill -9 $apiID
    echo "[SUCCESS] 进程已杀死"
else
    # 提示不进程不存在
    echo "[ERROR] 进程不存在"
fi
# 休眠5秒
sleep 5

nohup java -jar  app.jar > app.log 2>&1 &