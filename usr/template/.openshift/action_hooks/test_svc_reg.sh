#!/bin/bash


source `dirname $0`/util.sh

PLATFORMER_SVC_REG="caqrcode.atgte.am 6380"
echo -ne "PING\r\nDBSIZE\r\n" | nc $PLATFORMER_SVC_REG
echo "######### input ############"

if [ "$IN_URI_NIO"x = "x" ]; then
	IN_URI_NIO="tcp://unknown:61616"
fi


redis_reg_broker
redis_get_broker

redis_unreg_broker
redis_get_broker


