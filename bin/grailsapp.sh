#!/bin/sh

GRAILSAPP_NAME="grailsapp"
GRAILSAPP_DIR="/home/grails"
GRAILSAPP_PID="${GRAILSAPP_DIR}/example.pid"

case $1 in
    start)
        echo "Starting server..."
        if [ ! -f $GRAILSAPP_PID ]; then
            nohup java -jar ${GRAILSAPP_DIR}/docker-example.war &
            echo $! > $GRAILSAPP_PID
        else
            echo "${GRAILSAPP_NAME} is already running."
        fi
    ;;

    stop)
        if [ -f $GRAILSAPP_PID ]; then
            PID=$(cat $GRAILSAPP_PID);
            echo "Stopping $GRAILSAPP_NAME..."
            kill $PID;
            echo "${GRAILSAPP_NAME} stopped!"
            rm $GRAILSAPP_PID
        else
            echo "${GRAILSAPP_NAME} is not running."
        fi
    ;;

    *)
        echo "Usage: grailsapp.sh <start|stop>"
    ;;
esac
