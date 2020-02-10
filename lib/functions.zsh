function zsh_stats() {
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

function uninstall_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/uninstall.sh
}

function upgrade_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/upgrade.sh
}

function take() {
  mkdir -p $1
  cd $1
}

function sshr() {
    storage=`echo $1 |grep -v 'mdst' |grep -P '^s\d+\w+'`
    if [ -z $storage ]
    then
        ssh -l root $*
    else
        ssh -l kanst9 $*
    fi
}

function vpndown() {
  sudo kill `cat /var/run/openvpn.pid`
}

function hwclear() {
  ssh root@$1 rm -f /home/monitor/agents/tmp/mulca_hw_errors.msg.prev 2>/dev/null
}

function deb() {
  if [ -z $1 ] 
  then
    debuild && debrelease && debclean&& debcommit -a;
  else
    debuild && debrelease -t $1 && debclean&& debcommit -a
  fi
}

j () {
  local OLDIFS=$IFS
  IFS=${1:?"Missing separator"} 
  shift
  echo "$*"
  IFS=$OLDIFS 
}


function vimr() {
    export LC_ALL=C
    n=`echo $1 | awk -F "/" '{print $NF}' | grep -P "^\d+" -o`
    echo "start `date`" >> ~/yandex_disk/Documents/code/rebrain/time-$n
    vim $1
    echo "finish `date`" >> ~/yandex_disk/Documents/code/rebrain/time-$n
}
