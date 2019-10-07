#!/bin/sh
### BEGIN INIT INFO
# Provides:          networking ifupdown
# Required-Start:    mountkernfs $local_fs urandom
# Required-Stop:     $local_fs
# Default-Start:     S
# Default-Stop:      0 6
# Short-Description: Raise network interfaces.
### END INIT INFO

case "$1" in
    start)
    ip link set dev lo up
    ;;

    stop)
    ;;

    *)
    echo "Usage: /etc/init.d/network.sh {start|stop}" >&2
    exit 1
    ;;
esac

exit 0
