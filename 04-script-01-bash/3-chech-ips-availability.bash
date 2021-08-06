#!/usr/bin/env bash

urls=("192.168.0.1:80" "173.194.222.113:80" "87.250.250.242:80")
for i in ${urls[@]}
do
   curl --retry 5 --max-time 1 --retry-max-time 1 --silent --output /dev/null $i
   if (($? == 0))
   then
       echo $i" доступен" >> log
   else
       echo $i" НЕ доступен" >> log
   fi
done


