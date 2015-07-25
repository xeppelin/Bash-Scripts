#!/bin/bash
_EXTERNALIP="";
_INTERNALIPS="";
_PREVIOUSINTERNALIPS="";
_PREVIOUSEXTERNALIP="";
_EMAILADDRESS="youremail@address.com";
_CHECK_INTERVAL=60;
_HOSTNAME=$(hostname -f);

while sleep $_CHECK_INTERVAL; do
	_EXTERNALIP=$(dig +short myip.opendns.com @resolver1.opendns.com);
	_INTERNALIPS=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1');
	if [ "$_EXTERNALIP" != "$_PREVIOUSEXTERNALIP" ] || [ "$_INTERNALIPS" != "$_PREVIOUSINTERNALIPS"  ]; then
		echo -e "$_HOSTNAME\nExternal IP: $_EXTERNALIP\nInternal IP: $_INTERNALIPS" | mail "$_EMAILADDRESS";
	fi
	_PREVIOUSEXTERNALIP="$_EXTERNALIP";
	_PREVIOUSINTERNALIPS="$_INTERNALIPS";
done
