#!/usr/bin/env bash

echo oretykotlety | passwd --stdin hacluster

(cat > /etc/hosts) <<EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.10.60   drbd0
192.168.10.61   drbd1
192.168.10.62   drbd2
EOF

# corosync configuration
cp /vagrant/corosync.conf /etc/corosync/corosync.conf

# drbd resource file
cp /vagrant/d0.res /etc/drbd.d/d0.res

# httpd configuration file
cp /vagrant/httpd.conf /etc/httpd/conf/httpd.conf

cp /vagrant/*.sh ~