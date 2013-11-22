#!/bin/bash
#
# Version: 0.1
#
#pidfile: /var/run/remd.pid

PIDFILE=/var/run/remd.pid
CONFFILE=remd.conf
RETVAL=0

start()
{
	RUNNING=0
	
	# Проверить не запущен ли уже
	if [ -f $PIDFILE ]; then
		f=`cat $PIDFILE`

		while read line; do
			list=( $line )
			if ps ax | grep -v grep | grep ${list[0]} > /dev/null
			then
				RUNNING=1
				break
			fi
		done < $PIDFILE
	fi

	if [ $RUNNING -eq 1 ]; then
		echo 'Already runing.'
		return 0
	fi

	cat /dev/null > $PIDFILE

	cat $CONFFILE | while read line
	do
		S=${line%%#*}
		list=( $S )
		if [ ${#list[@]} -eq 4 ]
		then
			nohup sudo -u ${list[0]} remserial -d -r ${list[1]} -p ${list[2]} -l /tmp/${list[3]} /dev/ptmx > /dev/null 2>&1 &
			echo $! >> $PIDFILE
		fi
	done
	echo 'Running'
}

stop()
{
	if [ -f $PIDFILE ]; then
		cat $PIDFILE | while read line
		do
			list=( $line )
			if ps ax | grep -v grep | grep ${list[0]} > /dev/null; then
				kill -TERM ${list[0]}
			fi
		done
		rm $PIDFILE
	else
		echo 'Not running.'
	fi
}

restart()
{
	stop
	start
}

check_status()
{
	if [ -f $PIDFILE ]; then
		echo 'Is Running'
	else
		echo 'Is Stoping'
	fi
}

# See how we were called.
case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	restart)
		restart
		;;
	status)
		check_status
		RETVAL=$?
		;;
	*)
		#msg_usage
		echo "${0##*/} {start|stop|restart|status}"
		RETVAL=1
esac

exit $RETVAL