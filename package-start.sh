#!/bin/sh

# Get OpenVPN client certificate & key and server CA from environment variable
if [ "${OPENVPN_CERT}" != "" ]; then
	echo ${OPENVPN_CERT} | awk '{gsub(/\\n/,"\n")}1' >/etc/openvpn/aisclient.cert
fi

if [ "${OPENVPN_KEY}" != "" ]; then
	echo ${OPENVPN_KEY} | awk '{gsub(/\\n/,"\n")}1' >/etc/openvpn/aisclient.key
fi

if [ "${OPENVPN_CA}" != "" ]; then
	echo ${OPENVPN_CA} | awk '{gsub(/\\n/,"\n")}1' >/etc/openvpn/aisclient.ca
fi

# Start OpenVPN. Make sure the config path points to your openvpn config file
if [ "${OPENVPN_HOST}" ]; then
	openvpn --remote ${OPENVPN_HOST} --config /etc/openvpn/aisclient.conf &
else
	openvpn --config /etc/openvpn/aisclient.conf &
fi

# Find existing tty device for AIS receiver
selected_dev=
for this_dev in ${AIS_TTYS}
do
	if [ -c ${this_dev} ]; then
		selected_dev=${this_dev}
	fi
done

if [ "${selected_dev}" != "" ]; then
	echo "Starting aisdispatcher with device ${selected_dev}"
	/usr/local/bin/aisdispatcher -r -d ${selected_dev} ${AIS_SETTINGS}
else
	echo "None of the devices for AIS receiver exist (${AIS_TTYS})"
	echo "aisdispatcher was not started"
fi

sleep infinity
