﻿#!/bin/bash
# 获取短版本号
GITHASH=`git rev-parse --short HEAD`
APPNAME='app1'
PUBLISHFOLDER='publishedappp'
APPPORT='5002'
echo
echo ---------------版本号为...------------------
echo
echo $GITHASH
echo
echo
echo ---------------服务名...------------------
echo
echo $APPNAME
echo
echo ---------------发布...------------------
echo
dotnet publish $APPNAME  -c Release -o $PUBLISHFOLDER
echo
echo
echo ---------------跳到制定目录------------------
echo
cd  $APPNAME/$PUBLISHFOLDER/
echo


echo ---------------移除容器...------------------
echo
docker rm -f $APPNAME || true
echo
echo ---------------Build镜像...------------------
echo
docker build -t $APPNAME:$GITHASH .
echo
echo ---------------镜像打标签...------------------
echo
docker tag $APPNAME:$GITHASH $APPNAME:latest
echo
echo ---------------启动容器...------------------
echo
docker run --name $APPNAME -d -p $APPPORT:5000 --env ASPNETCORE_ENVIRONMENT=Development $APPNAME:latest