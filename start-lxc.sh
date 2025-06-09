#!/bin/bash
ping -c 1 8.8.8.8 > /dev/null 2>&1 || exit 1
set -e
grep -qxF '. /etc/bash_completion' /root/.bashrc || echo '. /etc/bash_completion' >> /root/.bashrc
dpkg-reconfigure tzdata
dpkg-reconfigure locales
cat /etc/default/locale >> .bashrc
apt update -y
apt dist-upgrade -y
apt install -y curl htop gnupg
reboot