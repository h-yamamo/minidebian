#!/bin/sh -e
[ $(id -u) -ne 0 ]  && echo "Run as root!" && exit 1
umask 022

# whether the RTC is UTC or Local is determined by /etc/adjtime
# default Time Zone is UTC
export MINIDEB_TZ_JST=yes

# kernel version
kvs=$(ls /boot/vmlinuz* | \
	sed -ne "s|^/boot/vmlinuz-\([3-7]\.[0-9]\+.\+\)$|\1|p")
vn=0
echo "Select linux kernel:"
for kn in $kvs; do vn=$(expr $vn + 1); echo " $vn: $kn"; done
if [ $vn -gt 1 ]; then
  read -p "> " rp
  [ "$rp" -gt 0 -a "$rp" -le $vn ] || exit 1
elif [ $vn -eq 1 ];then
  rp=1
  echo "(auto select 1)"
else
  echo " not found kernel."; exit 1
fi

#kv="4.19.0-6-amd64"
kv=$(echo $kvs | sed "s/ /\n/g" | head -${rp} | tail -1)

# check
[ ! -e /boot/initrd.img-${kv} ] && echo "initrd.img-${kv} not found" && exit 1
[ ! -e /boot/vmlinuz-${kv} ] && echo "vmlinuz-${kv} not found" && exit 1

# Source
mkdir w0
unmkinitramfs /boot/initrd.img-${kv} w0
if [ ! -d w0/main ]; then
	mkdir w0/main
	mv w0/[a-ln-z]* w0/main/
fi

rm -f w0/main/etc/ld.so.conf.d/libc.conf
rm -f w0/main/etc/modprobe.d/alsa-base.conf
rm -f w0/main/etc/modprobe.d/blacklist*.conf
rm -f w0/main/etc/modprobe.d/intel*.conf

mkdir w1 w2

# Make the System.
./make_system $kv
# Make the initrd.
./make_initrd $kv

unset MINIDEB_TZ_JST

