#!/bin/bash

# A simple menu system
helper () {
	if [ -x /home/shota/.cargo/bin/bat ]
	then
		/home/shota/.cargo/bin/bat /opt/shotaqemu/README.md
	else
		/bin/cat /opt/shotaqemu/README.md
	fi
}

### source vars and func ###
#source vars
source /opt/shotaqemu/func

### mkdir tmp ###
if [ ! -d $WD/tmp ]
then
	mkdir $WD/tmp
fi

actions='help doglist dogcreate dogedit rgqemu killqemu startqemu configure Quit'
PS3='Select action №: '

select action in $actions
do
  if [ $action == "Quit" ]
  then
	  break
  elif [ $action == "help" ]
  then
	  helper
  elif [ $action == "rgqemu" ]
  then
	  rgqemu
  elif [ $action == "doglist" ]
  then
	  doglist
  elif [ $action == "dogedit" ]
  then
	  doglist
	  read -p "Enter VDI name for edit: " EDITVDINAME
	  read -p "(Example 1024M)Enter new size enter 0 for delete the disk: " EDITVDINEWSIZE
	  if [ $EDITVDINEWSIZE == "0" ]
	  then
		  dogvdidelete $EDITVDINAME
	  else
		  dogresize $EDITVDINAME $EDITVDINEWSIZE
	  fi
  elif [ $action == "dogcreate"  ]
  then
	  read -p "Enter new VDI name: " NEWVDINAME
	  read -p "(Default 100M)Enter new VDI disk size: " NEWVDISIZE
	  if [ -z $NEWVDISIZE  ]
	  then
	  	dogcreate $NEWVDINAME 100M
	  else
	  	dogcreate $NEWVDINAME $NEWVDISIZE
	  fi
  elif [ $action == "configure" ]
  then
	  configvminstance
  elif [ $action == "startqemu" ]
  then
	  startinstance
  elif [ $action == "killqemu" ]
  then
	  read -p "!!!CAUTION first use rgqemu to find proper process ID!!! Enter process id to kill: " QEMUKILLID
	  kill $QEMUKILLID
  fi
  echo $action done
done
echo Bye
