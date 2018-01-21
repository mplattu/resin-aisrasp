# resin-aisrasp
In brief: AIS base station/relay for resin.io environment

resin-aisrasp is a minimal AIS data relay. It reads AIS data from serial port `/dev/ttyUSBn`
and transmits it over OpenVPN tunnel as UDP to relay server with static IP. The relay uses
[udp-relay](https://github.com/mplattu/udp-relay) to redirect the stream to [AIShub](http://www.aishub.net/).

This repo contains everything needed
(including latest [aisdispatcher binary](http://www.aishub.net/ais-dispatcher#linux), ARM glibc versio)
except your VPN settings. The `package-preinstall.sh` copies everything from `openvpn/` to `/etc/openvpn`
so all your configurations should go there.

## Configuration variables

 * `OPENVPN_CERT` OpenVPN client certificate. Make your certificate an one-liner before
   pasting it as resin.io device-specific environment variable:
   `cat file | awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}'`
   The value will be written to `/etc/openvpn/aisclient.cert` (newlines expanded).
 * `OPENVPN_KEY` OpenVPN client key. This should be a one-liner as well. The value will
   be written to `/etc/openvpn/aisclient.key` (newlines expanded).
 * `OPENVPN_CA` OpenVPN server CA. This should be a one-liner as well. The value will
   be writte to `/etc/openvpn/aisclient.ca` (newlines expanded).
 * `OPENVPN_HOST` OpenVPN host and optionally a port and proto. This variable will
   be fed directly to openvpn `remote` parameter.If not
   specified you must define `remote` (and `proto`) in your `openvpn/aisclient.conf`.
   Example: `yourrelay.yourdomain.com 6666`
 * `AIS_TTYS` Space-separated list of possible tty devices. `aisdispatcher` will be
   listening to the first device which exists in this list. Example: `/dev/ttyUSB0 /dev/ttyUSB1`
 * `AIS_SETTINGS` Parameters for `aisdispatcher` in addition to `-r -d TTY`. It should contain
   at least the endpoint (`-H`) which is the IP your VPN gives to you.
   Example: `-s 38400 -H 192.168.201.1:3232`

## Pushing to your devices

Get the git location from resin.io UI and set it to your repo:

```
git remote add resin yourresiniousername@git.resin.io:somepath.git
git push resin master
```

## License

This repo is dual licensed with GPLv3 (`LICENSE-GPL3`) and MIT (`LICENSE-MIT`).
Kindly note that the license does not cover content of `aishub-aisdispatcher`.
