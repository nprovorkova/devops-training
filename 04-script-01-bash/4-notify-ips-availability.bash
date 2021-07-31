#!/usr/bin/env bash

urls=("192.168.0.1:80" "173.194.222.113:80" "87.250.250.242:80")
while ((1==1))
do
   for i in ${urls[@]}
   do
       ping $i &>/dev/null
       if (($? != 0))
       then
           echo $i >> error
           break 2
       fi
   done
done
