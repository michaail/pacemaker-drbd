#!/usr/bin/env bash

# drbd repos
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm

# install pacemaker, httpd, drbd
yum -y install pacemaker pcs resource-agents httpd php drbd90-utils kmod-drbd90
