#!/bin/bash

#项目名称
PROJECT_NAME=boot-app

#项目父目录
PROGRAM_PARENT_DIR=/usr/local/program

# 日志前缀: boot-app-2022-02-02.log(这个要看具体log框架是如何配置)
LOG_PREFIX=${PROGRAM_PARENT_DIR}/${PROJECT_NAME}/logs/${PROJECT_NAME}/${PROJECT_NAME}-

# jar包路径 /usr/local/program/boot-app/boot-app.jar
JAR_PATH=${PROGRAM_PARENT_DIR}/${PROJECT_NAME}/${PROJECT_NAME}.jar

# spring boot配置
ACTIVE=dev

# 如果没有cd到当前目录，则logs会在当前目录创建
echo "cd  ${PROGRAM_PARENT_DIR}/${PROJECT_NAME}/"

# shellcheck disable=SC2164
cd  ${PROGRAM_PARENT_DIR}/${PROJECT_NAME}/

usage() {
  echo "Usage: sh ShellName.sh [start|stop|restart|status]"
  exit 1
}

file_is_exist() {
  if [ -f "${JAR_PATH}" ]; then
    return 1
  else
    echo "${JAR_PATH} is not exist"
    exit 0
  fi
}
# shellcheck disable=SC2120
is_run() {
  file_is_exist
  #echo "ps -ef|grep ${JAR_PATH}|grep -v grep|awk '{print $2}' "
  pid=$(ps -ef | grep ${JAR_PATH} | grep -v grep | awk '{print $2}')
  if [ -z "${pid}" ]; then
    return 1
  else
    return 0
  fi
}

start() {
  is_run
  if [ $? -eq "0" ]; then
    echo "${JAR_PATH} is already running. pid = ${pid} ."
  else
    # No default log is generated. Use logback or log4j2
    echo " nohup java -Xms512m -Xmx1024m -XX:+HeapDumpOnOutOfMemoryError \ "
    echo "-XX:HeapDumpPath=./ -jar  \  "
    echo "-Dspring.profiles.active=${ACTIVE} \ "
    echo "${JAR_PATH} >/dev/null 2>&1 & "

    nohup java -Xms512m -Xmx1024m -XX:+HeapDumpOnOutOfMemoryError \
      -XX:HeapDumpPath=./  -jar \
      -Dspring.profiles.active=${ACTIVE} \
      ${JAR_PATH} >/dev/null 2>&1 &
    now_date=$(date +%Y-%m-%d)
    echo "If you need to view the log, please execute ' tail -20f ${LOG_PREFIX}${now_date}.log '"
  fi
}

stop() {
  is_run
  if [ $? -eq "0" ]; then
    echo "kill -9 ${pid}"
    kill -9 $pid
    echo "${pid} Stopping."
  fi
  echo "${JAR_PATH} is NOT running."
}
parameter() {
  echo "jinfo -flags ${pid}"
  jinfo -flags ${pid}
}
status() {
  is_run
  if [ $? -eq "0" ]; then
    echo "${JAR_PATH} is running. Pid is ${pid}"
    parameter
    now_date=$(date +%Y-%m-%d)
    echo "If you need to view the log, please execute ' tail -20f ${LOG_PREFIX}${now_date}.log '"
  else
    echo "${JAR_PATH} is NOT running."
  fi
}
restart() {
  stop
  start
}

case "$1" in
"start")
  start
  ;;
"stop")
  stop
  ;;
"status")
  status
  ;;
"restart")
  restart
  ;;
*)
  usage
  ;;
esac
