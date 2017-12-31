#!/bin/bash

PID_FILE='/home/masternode/.poliscore/polisd.pid'

start() {
       touch $PID_FILE
       eval "/bin/su masternode -c '/usr/bin/polisd 2>&1 >> /dev/null'"
       PID=$(ps aux | grep polisd | grep -v grep | awk '{print $2}')
       echo "Starting polisd with PID $PID"
       echo $PID > $PID_FILE
}
stop () {
       pkill polisd
       rm $PID_FILE
       echo "Stopping polisd"
}

case $1 in
    start)
       start
       ;;
    stop)  
       stop
       ;;
     *)  
       echo "usage: polisd {start|stop}" ;;
 esac
 exit 0
