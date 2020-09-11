#!/bin/bash

# 重试操作
function retry_run()
{
    local retry_n=0
    local retry_times=3
    local retry_inteval=5
    local cmd="echo \"no commamd\" "
    local retval=0
    if [ $# -ge 3 ];then
        retry_times=$1
        retry_inteval=$2
        cmd=$3
    fi

    while (( retry_n < retry_times ))
    do
        (eval ${cmd})
        retval=$?
        if [  ${retval} -eq 0 ];then
            break
        fi
        ((retry_n++))
        sleep $retry_inteval
    done
    return ${retval}
}

# 远程执行
function remote_run()
{
    user=$1
    host=$2
    cmd=$3
    echo "run cmd [ssh $user@$host . /etc/profile;  $cmd]"
    #ssh "$user"@"$host" "hostname -i ; . /etc/profile;  $cmd"
    ssh "$user"@"$host" ". /etc/profile;  $cmd"
    if [ $? -ne 0 ];then
         echo "run cmd[ "$cmd" ] failed"
         exit 1
    fi
    return 0
}

# 校验操作
function check_result()
{
    ret=$1
    if [ $ret -ne 0 ];then
        echo $2 "error !"
        exit -1
    fi
}
