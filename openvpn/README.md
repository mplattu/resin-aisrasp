# OpenVPN configuration files

These files will copied to `/etc/openvpn` by `package-preinstall.sh`.

This folder should contain your OpenVPN configuration file `aisclient.conf`.

Do not place your client certificates here. Use device-specific environment
variables `OPENVPN_` instead.
