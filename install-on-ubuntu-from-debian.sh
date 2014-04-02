#!/bin/bash

# Shinken last version installer for Ubuntu 12.04

# This will install required packages, then  fetch Shinken packages from
# Debian sid (unstable)
# You need to run this as root.

set -e
set -o pipefail

# conf
MIRROR=http://ftp.ca.debian.org/debian/pool/main
SHINKEN_VERSION=1.4.2-1
ARCH=amd64

# store the packages in order to install them in a row
# (avoid cycle dependencies)
to_install=

# install name pkg_name version arch
function install {
    file=$2_$3_$4.deb
    pkg=$MIRROR/${1:0:1}/$1/$file
    wget $pkg
    #dpkg -i $file
    to_install=$to_install $file
}

function finalize {
    dpkg -i $to_install
}

# let's update our packages
apt-get update
apt-get upgrade

# be sure to have these essentials
yes | apt-get install python pyro libjs-jquery

# now, install packages from Debian
cd /tmp
mkdir pkg_debian -p
cd pkg_debian

# this is not in Ubuntu 12.04 yet
#install jquery libjs-jquery 1.7.2+dfsg-3 all
install fonts-font-awesome fonts-font-awesome 4.0.3~dfsg-2 all

# yeah, shinken!
install shinken shinken-common $SHINKEN_VERSION $ARCH
install shinken shinken-module-broker-webui $SHINKEN_VERSION $ARCH
install shinken shinken-module-broker-webui-cfgpassword $SHINKEN_VERSION $ARCH
install shinken shinken-module-broker-webui-sqlitedb $SHINKEN_VERSION $ARCH
install shinken shinken-module-retention-picklefile $SHINKEN_VERSION $ARCH
install shinken shinken $SHINKEN_VERSION $ARCH

install shinken shinken-module-broker-livestatus-sqlite $SHINKEN_VERSION $ARCH
install shinken shinken-module-broker-livestatus $SHINKEN_VERSION $ARCH

#finalize
echo to_install

# clean
cd ..
rm -rf pkg_debian