#!/bin/bash
while :
do
    today=`date +%Y%m%d`
    path=/root/scripts/log/`date +%Y-%m-%d`
    dir=$path/diskio.log
    if [ ! -x "$path" ];then
         mkdir -p "$path"
    fi
    if [ ! -f "$dir" ]; then
        touch "$dir"
    fi
    while :
    do
        date "+%Y-%m-%d %H:%M:%S" >> $dir
    newday=`date +%Y%m%d`
    echo "sda磁盘%util："  `iostat -x | tail -n3 | head -n1 |awk '{print $NF}'` "%" >> $dir
    echo "sdb磁盘%util："  `iostat -x | tail -n2 | head -n1 |awk '{print $NF}'` "%" >> $dir
    echo "              "  `iostat -x | tail -n8 | head -n1 | awk  -F "   " '{$1="";print}'`  >> $dir
    echo "sda磁盘io情况:"  `iostat -x | tail -n3 | head -n1 | awk  -F "    " '{$1="";print}'` >> $dir
    echo "sdb磁盘io情况:"  `iostat -x | tail -n2 | head -n1 | awk  -F "    " '{$1="";print}'` >> /$dir
    echo "----------------------------------------"   >> $dir
    sleep 30
    if [ $today -eq $newday ];then
        echo  "相等" >> /dev/null
    else
        break
    fi
    done
done

