replace_prop ()
{
	usage="$0 <file to edit> <key to replace> <value to set key too>"
	if [ $# -lt 3 ]; then
		echo "Usage: $usage"
		 exit 1 
  fi
	KEY=${2//\//\\/}
	VAL=${3//\//\\/}
	sed -i.old -e "s/^$KEY=.*/$KEY=$VAL/" $1
}

test_replace ()
{
	file=etc/org.ops4j.pax.web.cfg 
	replace_prop $file "org.ops4j.pax.web.listening.addresses" "my_IP_addr"
	diff $file ${file}.old
	mv ${file}.old $file
}





function redis_protocolize {
	cmd="*$#"
	for i in "$@"; do
		#echo ">>>>>>>>>>>>>>>>> ${#i}: $i <<<<<<<<<<<<<<<<<<<<<"
		cmd="$cmd\r\n\$${#i}\r\n$i"
	done
	cmd="$cmd\r\n"
	echo -ne $cmd

}

function redis_send {
	echo "$PLATFORMER_SVC_REG"
	if [ "$PLATFORMER_SVC_REG"x = "x" ]; then
		PLATFORMER_SVC_REG="caqrcode.atgte.am 6380"
	fi
	(redis_protocolize "$@"; sleep 1) | nc $PLATFORMER_SVC_REG

}

function redis_reg_broker {
	if [ "$IN_URI_NIO"x = "x" ]; then
		IN_URI_NIO="ERR NO NIO URL"
	fi
	redis_send SET telemetry_mgr "$IN_URI_NIO"
}

function redis_unreg_broker {
	redis_send DEL telemetry_mgr

}

function redis_get_broker {
	redis_send GET telemetry_mgr 

}



