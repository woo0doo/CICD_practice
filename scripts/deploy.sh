#!/bin/bash
PROJECT_NAME=chillin

echo "> 현재 실행 중인 Docker 컨테이너 pid 확인" >> /home/ubuntu/deploy.log
CURRENT_PID=$(pgrep -fl $PROJECT_NAME | grep java | awk '{print $1}')

if [ -z $CURRENT_PID ]
then
  echo "> 현재 구동중인 Docker 컨테이너가 없으므로 종료하지 않습니다." >> /home/ec2-user/deploy.log
else
  echo "> sudo docker stop $CURRENT_PID"   # 현재 구동중인 Docker 컨테이너가 있다면 모두 중지
  sudo docker stop $CURRENT_PID
  sleep 5
fi

cd /home/ubuntu/app
sudo docker build -t chillin-spring-boot-docker .
sudo docker run -d -p 8080:8080 tcat-api-spring-boot-docker