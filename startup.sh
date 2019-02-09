#!/usr/bin/env bash

# turn off selinux
sed -i "s/^SELINUX=.*/SELINUX=permissive/g" /etc/selinux/config
setenforce 0

# run all services
systemctl enable pcsd
systemctl enable corosync
systemctl enable pacemaker
# systemctl enable drbd

systemctl start pcsd
systemctl start corosync
systemctl start pacemaker
# systemctl start drbd

# drdb setup on all clusters
drbdadm create-md d0
drbdadm down d0
drbdadm up d0