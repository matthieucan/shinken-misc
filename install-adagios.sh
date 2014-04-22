#!/bin/bash

# Adafios last version installer for Ubuntu 12.04

# You need to run this as root.

set -e
set -o pipefail

apt-get install python-pip --yes

pip install django\<1.5 pynag simplejson
# note: requires last pynag, from github

# https://github.com/opinkerfi/adagios/wiki/Installing-Adagios-from-source-on-Debian

git clone git@github.com:matthieucan/adagios.git

# python manage.py runserver 0.0.0.0:8000

# notes:
# a few conf parameters to update, like log_file or archive_log_file
# either update adagios/etc/adagios.conf (nagios_config) to point to Shinken,
# or create symlink
