
#!/bin/bash
while :
do
    today=`date +%Y%m%d`
    path=/root/scripts/log/`date +%Y-%m-%d`
    dir=$path/free.log
    if [ ! -x "$path" ]; then
        mkdir -p "$path"
    fi
    if [ ! -f "$dir" ]; then
        touch "$dir"
    fi
    while :
    do
        date "+%Y-%m-%d %H:%M:%S" >> $dir
        newday=`date +%Y%m%d`
        #抓取物理内存总量
        echo "Mem-Total:" `free -h | grep Mem | awk '{print $2}'`M >> $dir
        #抓取物理内存已使用值
        echo "MemUsed:" `free -h | grep Mem | awk '{print $3}'`M >> $dir
        #抓取物理内存free值
        echo "Mem-free:" `free -h | grep Mem | awk '{print $4}'`M >> $dir
        #抓取缓冲区的free值
        echo "Mem-buffers/cache-free" `free -h | grep Mem | awk '{print $6}'`M >> $dir
        #抓取Swap总量
        echo "Swap-Total:" `free -h | grep Swap | awk '{print $2}'`M >> $dir
        #抓取Swap已使用值
        echo "Swap-Used:" `free -h | grep Swap | awk '{print $3}'`M >> $dir
        #抓取Swap分区free值
        echo "Swap-free:" `free -h | grep Swap | awk '{print $4}'`M >> $dir
        echo "----------------------------------------------------------" >> $dir
        if [ $today -eq $newday ];then
            echo  "相等" >> /dev/null
        else
            break
        fi
    sleep 30
    done
done
