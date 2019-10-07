#!/bin/sh
### BEGIN INIT INFO
# Provides:          syslog
# Required-Start:    $remote_fs $time
# Required-Stop:     umountnfs $time
# X-Stop-After:      sendsigs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: busybox syslogd
### END INIT INFO

#    -O file -l N (prio: 1-8) -S (short msg)
OPT=

case "$1" in
    start)
    /sbin/syslogd $OPT
    ;;

    stop)
    killall syslogd
    ;;

    *)
    echo "Usage: /etc/init.d/syslog.sh {start|stop}" >&2
    exit 1
    ;;
esac

exit 0
