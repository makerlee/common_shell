#!/bin/bash

nowdate=$(date "+%Y-%m-%d %H:%M:%S")
processnum=`ps -ef|grep apollo|grep -v grep|awk '{print $2}'`
echo $processnum >> /root/test2.txt
num=`jmap -heap $processnum|grep used|grep -v "="|sed -e 's/%//g'|awk '{print $1}'|awk '{if($1>40) print $0}'|wc -l`
   echo $nowdate'[超过70%指标数：'$num']' >> /root/test2.txt
   if [ "${num}" -gt "1" ]; then
      echo $nowdate'[restart apollo,pid='$processnum']' >> /root/test2.txt
      echo $nowdate'['`jmap  -heap $processnum|grep used|grep -v "="` >> /root/test2.txt
      #kill -9 $processnum
      #nohup /home/fortadmin/apollo/mqtt/myapollo/bin/apollo-broker run &
   fi
