#!/bin/bash

if [ -z $CONTENTS_SOURCE_URL ]; then
   exit 1
fi

git clone $CONTENTS_SOURCE_URL /data

cd /data
while true
do
   date
   sleep 60
   git pull
done
