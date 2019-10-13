#!/bin/sh
### BEGIN INIT INFO
# Provides:          checkroot mtab
# Required-Start:    mountdevsubfs hwclock
# Required-Stop:
# Default-Start:     S
# Default-Stop:
# Short-Description: Check mtab.
### END INIT INFO

. /lib/lsb/init-functions
. /lib/init/mount-functions.sh

case "$1" in
  start|"")
	mtab_migrate
	;;
  stop)
	# No-op
	;;
  *)
	echo "Usage: mtab.sh [start|stop]" >&2
	exit 3
	;;
esac

