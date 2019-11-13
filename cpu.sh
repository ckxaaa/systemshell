#!/bin/bash
while :  
do  
    today=`date +%Y%m%d`
    #存放脚本文件夹
    path=/root/scripts/log/`date +%Y-%m-%d`  
    dir=$path/cpu.log  
    if [ ! -x "$path" ]; hen  
        mkdir -p "$path"  
    fi  
    if [ ! -f "$dir" ]; then  
       touch "$dir"
    fi
    while :  
    do  
        date "+%Y-%m-%d %H:%M:%S" >> $dir  
        newday=`date +%Y%m%d`
        echo "cpu使用情况: " `top -b -n 1 | grep Cpu` >> $dir
        echo `vmstat | tail -n2 | head -n1` >> $dir
        echo `vmstat | tail -n1 | head -n1` >> $dir
        echo "------------------------------------------" >> $dir
        if [ $today -eq $newday ]; then
            echo "相等" >> /dev/null
        else
            break
        fi
        sleep 30
    done
done
