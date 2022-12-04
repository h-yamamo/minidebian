# mini Debian

It is a small system for maintenance and rescue, and its size is about 50 MBytes.

## Specification

- All system files are packed in An initramfs (initrd.img).
- The root file system is tmpfs. So after the system boots up, no storage medium is used.
- Of cource it is CUI only system.
- The /sbin/init adopts busybox init.
- Merged /usr.
- This system is created by copying system files from the base system.
- Debian 12 "Bookworm" is supported as a base system.

## Requirements of machine to operating

- X86 machines, 64-bit and 32-bit
- 256 MB RAM or more

## Preparation

Make sure you have `make` package installed, as we will use `make` below
to install the required packages and build mini Debian.
If `make` is not installed, install it as follows.

```
sudo apt install make
```

## Building a mini Debian

First, `git clone` this repository,
or somehow get it and extract it into a working directory.

Run the following as `root` in the working directory.

### Required debian package installation

Make sure `non-free` component is specified in `/etc/apt/sources.list`.

```
make prepare_package
```

### Create mini Debian initrd

If you want to change the default RTC and/or Time-Zone settings,
uncomment the appropriate export lines in `main.sh` script in advance.

```
make
```

### Copy kernel and the initrd

- Copy `/boot/vmlinuz-6.1.0-N-XXX` and `initrd.img-minideb-6.1.0-N-XXX` to target.
- Enable booting with `grub` or `syslinux`.
- No kernel boot option required.

For example, to install mini Debian on your Debian system,
do the following with `root` privilege.

1) Copy it to boot directory
```
cp (build dir)/initrd.img-minideb-6.1.0-3-amd64 /boot/
```

2) Edit `/etc/grub.d/40_custom`
```
menuentry 'mini Debian' {
    search --no-floppy --fs-uuid --set=root XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
    linux   /boot/vmlinuz-6.1.0-3-amd64
    initrd  /boot/initrd.img-minideb-6.1.0-3-amd64
}
```

3) Update grub.cfg
```
update-grub
```

Now, reboot and select 'mini Debian' from the grub menu to boot `mini Debian`.

### Boot options

There is a mini Debian specific boot option `rootfssize=`.
Specify if there is a problem with the default value.
See `man 5 tmpfs` for how to specify it. e.g. `rootfssize=60%` or
`rootfssize=256m` If you have a computer with a small amount of memory,
you should specify it. If the installed memory is 1GB,
specify around 85% to 90%, and if it is 512MB, specify around 70% to 80%.

You can also specify general kernel command line options. (May need to be specified.)

If the console display is blank during boot, try specifying the `nomodeset` option.

If you want to change the console resolution, specify the `video=` option.
e.g. `video=800x600-16` or `video=1024x768`

If you want to limit the SATA speed, specify the `libata.force=` option.
e.g. `libata.force=3.0` or `libata.force=1.5`

If you are doing a network boot, you may need to specify the `initrd=` option.

## Login accounts

- `root/minidebian`
- `user/mini`

## All commands of mini Debian

```
$ ls -l /usr/sbin/ | sed 's/\ \+/ /g' | cut -d ' ' -f 9-

acpid -> busybox
adjtimex -> busybox
arp -> busybox
arping -> busybox
blkdeactivate
blkdiscard -> busybox
blkid
blockdev -> busybox
brctl -> busybox
busybox
cfdisk
chroot -> busybox
cryptsetup
debootstrap
depmod -> /bin/kmod
devmem -> busybox
dhclient
dhclient-script
dmidecode
dmsetup
dmstats -> dmsetup
dump
dump.exfat
e2fsck
fatlabel
fdisk
findfs -> busybox
freeramdisk -> busybox
fsck
fsck.exfat
fsck.ext2 -> e2fsck
fsck.ext3 -> e2fsck
fsck.ext4 -> e2fsck
fsck.fat
fsck.msdos -> fsck.fat
fsck.vfat -> fsck.fat
fsfreeze -> busybox
fstab-decode
fstrim -> busybox
gdisk
getty -> busybox
halt -> busybox
hdparm
httpd -> busybox
hwclock -> busybox
ifconfig -> busybox
init -> busybox
insmod -> /bin/kmod
invoke-rc.d
ip -> /bin/ip
ipneigh -> busybox
iw
iwconfig
killall5
klogd -> busybox
ldconfig
linux32 -> busybox
linux64 -> busybox
loadfont -> busybox
loadkmap -> busybox
logread -> busybox
losetup
lsmod -> /bin/kmod
mkdosfs -> busybox
mke2fs
mkfs.exfat
mkfs.ext2 -> mke2fs
mkfs.ext3 -> mke2fs
mkfs.ext4 -> mke2fs
mkfs.fat
mkfs.msdos -> mkfs.fat
mkfs.ntfs -> mkntfs
mkfs.vfat -> mkfs.fat
mkhomedir_helper
mkntfs
mkswap -> busybox
modinfo -> /bin/kmod
modprobe -> /bin/kmod
mount.lowntfs-3g -> /bin/lowntfs-3g
mount.ntfs -> mount.ntfs-3g
mount.ntfs-3g -> /bin/ntfs-3g
nameif -> busybox
ntfsclone
pam-auth-update
pam_getenv
parted
partprobe -> busybox
pivot_root -> busybox
poweroff -> busybox
rdate -> busybox
reboot -> busybox
resize2fs
restore
rfkill
rmmod -> /bin/kmod
route -> busybox
service
sfdisk
sgdisk
smartctl
start-stop-daemon
swapoff -> busybox
swapon -> busybox
switch_root -> busybox
sysctl
syslogd -> busybox
tune.exfat
tune2fs
udhcpc -> busybox
udhcpd -> busybox
unix_chkpwd
unix_update
vconfig -> busybox
watchdog -> busybox
wpa_cli
wpa_supplicant

$ ls -l /usr/bin/ | sed 's/\ \+/ /g' | cut -d ' ' -f 9-

7z
[ -> busybox
[[ -> busybox
apg
ar -> busybox
arch -> busybox
ascii -> busybox
ash -> busybox
awk -> mawk
base64 -> busybox
basename -> busybox
bash
bc
bunzip2 -> busybox
busybox
bzcat -> busybox
bzip2 -> busybox
cal -> busybox
cat -> busybox
chgrp -> busybox
chmod
chown
chvt -> busybox
ckbcomp
clear -> busybox
cmp -> busybox
cp
cpio -> busybox
cpufreq-info
cpufreq-set
crc32 -> busybox
cttyhack -> busybox
cut -> busybox
date
dc
dd
deallocvt -> busybox
df
diff
dig
dircolors
dirname -> busybox
dmesg -> busybox
dnsdomainname -> busybox
dos2unix -> busybox
dpkg
dpkg-deb
du
dumpkmap -> busybox
dumpleases -> busybox
echo
egrep -> busybox
eject
env -> busybox
expand -> busybox
expr -> busybox
factor -> busybox
faked -> faked-sysv
faked-sysv
fakeroot -> fakeroot-sysv
fakeroot-sysv
fallocate -> busybox
false -> busybox
fatattr -> busybox
fgrep -> busybox
file
find
fold -> busybox
free -> busybox
ftp -> inetutils-ftp
ftpget -> busybox
ftpput -> busybox
fuser
getopt
gpgv
grep -> busybox
groups -> busybox
gunzip -> busybox
gzip -> busybox
hd -> hexdump
head -> busybox
hexdump
hexer
host
hostid -> busybox
hostname -> busybox
id -> busybox
inetutils-ftp
inetutils-telnet
ionice -> busybox
ip
ipcalc -> busybox
iperf
kbd_mode
kill -> busybox
killall -> busybox
kmod
last -> busybox
ldd
less
lessecho
lessfile -> lesspipe
lesspipe
link -> busybox
ln -> busybox
loadkeys
logger -> busybox
login
logname -> busybox
lowntfs-3g
ls
lsblk
lscpu
lsmod -> /bin/kmod
lspci
lsscsi -> busybox
lsusb
lzcat -> busybox
lzip -> lzip.lzip
lzip.lzip
lzma -> busybox
lzop -> busybox
make
mawk
md5sum -> busybox
microcom -> busybox
mkdir -> busybox
mkfifo -> busybox
mknod -> busybox
mkpasswd -> busybox
mktemp -> busybox
more -> busybox
mount
mountpoint
mt -> busybox
mv
nc -> nc.openbsd
nc.openbsd
netstat -> busybox
nl -> busybox
nproc -> busybox
nslookup -> busybox
ntfs-3g
ntfs-3g.probe
ntfsfix
ntfsinfo
objdump -> x86_64-linux-gnu-objdump
od -> busybox
openssl
openvt -> busybox
passwd
paste -> busybox
patch -> busybox
perl
pftp -> inetutils-ftp
pidof -> busybox
ping
ping4 -> ping
ping6 -> ping
printf -> busybox
ps
pstree
pv
pwd -> busybox
readlink
realpath -> busybox
renice -> busybox
reset -> tset
rev -> busybox
rm -> busybox
rmdir -> busybox
rpm -> busybox
rpm2cpio -> busybox
run-parts
savelog
scp
sed
seq -> busybox
setfont
setkeycodes -> busybox
setpriv -> busybox
setsid -> busybox
setupcon
setvtrgb
sftp
sh -> busybox
sha1sum -> busybox
sha256sum -> busybox
sha3sum -> busybox
sha512sum -> busybox
shred -> busybox
sleep -> busybox
sort -> busybox
ss
ssh
ssl_client -> busybox
stat -> busybox
stress
strings -> busybox
stty -> busybox
su
sync -> busybox
systemd-hwdb
tac -> busybox
tail -> busybox
tar
taskset -> busybox
tcpdump
tee -> busybox
telnet -> inetutils-telnet
test -> busybox
tftp -> busybox
time -> busybox
timeout -> busybox
top
touch -> busybox
tput
tr -> busybox
tracepath
traceroute -> busybox
true -> busybox
truncate -> busybox
ts -> busybox
tset
tty -> busybox
udevadm
umount
uname -> busybox
uncompress -> busybox
unexpand -> busybox
uniq -> busybox
unix2dos -> busybox
unlink -> busybox
unlzma -> busybox
unrar -> unrar-nonfree
unrar-nonfree
unxz -> xz
unzip -> busybox
unzstd -> zstd
uptime -> busybox
usb-devices
usleep -> busybox
uudecode -> busybox
uuencode -> busybox
uuidcdef
vi -> vim.tiny
view -> vim.tiny
vim.tiny
w -> busybox
watch -> busybox
wc -> busybox
wget
which -> busybox
who -> busybox
whoami -> busybox
x86_64-linux-gnu-objdump
xargs
xxd -> busybox
xz
xzcat -> xz
yes -> busybox
zcat -> busybox
zstd
zstdcat -> zstd
```

## Notes

It is optimized for ThinkPad X61, ThinkPad X230 and ThinkPad X250,
customization is recommended.  Update the following files to customize:
`make_system`, `data/*`, `systemfiles/*`

## For QEMU KVM

You can also build mini Debian for QEMU KVM.
This option uses `virtio` modules for network and storage drivers.
Run the following as `root`.

```
make MACHINE=kvm prepare_package

make MACHINE=kvm
```

## References

- [disklessfun/minimum-ubuntu](https://wikiwiki.jp/disklessfun/minimum-ubuntu)
- [BootUsbWithGrubRescu](https://wiki.debian.org/BootUsbWithGrubRescue)
- [Basic knowledge to start up embedded Linux](http://www.poyontech.com/wp/2017/02/07/post-131/)
- [Kernel mode setting - ArchWiki](https://wiki.archlinux.org/index.php/Kernel_mode_setting)

