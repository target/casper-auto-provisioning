#!/bin/bash
##
## Started as a simple wrapper over iptables, has gotten slightly more comlpicated
## takes a chain and a port. If that chain does not exist
## it will be created. If it exists, an accept ALL rule
## for that port will be inserted. To activate the chain:
## an insert rule will be put into the INPUT CHAIN
##simple wrapper over iptables
## takes a port number and inserts it in the input chain
## second from the last (to allow for DENY ALL at the end)


set -x
IPT=/sbin/iptables

case "${1}" in
	[a-zA-Z]*) CHAIN=${1};;
	*) 
	echo "unable to parse chain name"
	exit 1
	;;
esac

case "${2}" in
	[0-9]*) DPORT=${2};;
	[a-zA-Z]) 
	>&2 echo "Port must be number"
	exit 1
	;;
	*)
	>&2 echo "unable to parse port"
	exit 1
	;;
esac

$IPT -L ${CHAIN} >/dev/null 2>&1
if ! [ "$?" -eq 0 ]; then
# create the chain if it doesn't exist
	$IPT -N ${CHAIN}
fi
#Now see if our rule exists
$IPT -L ${CHAIN} -n | grep dpt:${DPORT} >/dev/null 2>&1
if ! [ "$?" -eq 0 ]; then 
	echo "Creating rule"
	$IPT -A ${CHAIN} -m state -p tcp --state NEW --dport ${DPORT} -j ACCEPT
else
	echo "Rule exists"
	exit 0	
fi

# now check for the rule jumping from INPUT
#sudo iptables -L INPUT| grep ELK
$IPT -L INPUT | $CHAIN >/dev/null 2>&1
if ! [ "$?" -eq 0 ]; then
	echo "Creating the jump rule"
	$IPT -I INPUT 2 -p tcp -j ${CHAIN}
else
	echo "Jump rule already exists"
fi

# Now Save the ruleset
/sbin/service iptables save
if [ "$?" -eq 0 ]; then
	echo "Successfully saved ruleset"
	exit 0
else
	echo "Unable to save ruleset"
	exit 1
fi


