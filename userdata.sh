#!/usr/bin/env bash
set -x

# OpenVPN Environment Variable Definition
admin_user=${vpn_username}
admin_pw=${vpn_password}
reroute_gw=1
reroute_dns=1

# Update Ubuntu Server
apt-get update
apt-get -y upgrade
