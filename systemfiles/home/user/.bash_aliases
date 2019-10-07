#
eval "$(lesspipe)"

alias df='df -T'
alias mu=mount
alias um=umount
alias cp='cp -i'
alias mv='mv -i'
alias l='ls -AxF'
alias ll='ls -lA'
alias lt='ls -lArt'
alias lR='ls -AxFR'
alias llR='ls -lAR'
alias lla='ls -la'
alias lls='ls -lArS'
alias llfl='ls --full-time -lA'

alias udevinfo='udevadm info -a -n'

#--- http://www.ainet.or.jp/~inoue/memo/dc-radix.html (missing)
function o2d () { dc -e "8i $1 p"; }
function o2x () { dc -e "16o 8i $1 p"; }
function d2o () { dc -e "8o $1 p"; }
function d2x () { dc -e "16o $1 p"; }
function x2o () { x=`echo $1|tr '[a-z]' '[A-Z]'`; dc -e "8o 16i $x p"; }
function x2d () { x=`echo $1|tr '[a-z]' '[A-Z]'`; dc -e "16i $x p"; }

