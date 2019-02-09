#!/usr/bin/env bash

drbdadm --force primary d0
mkfs.ext4 /dev/drbd0

mount /dev/drbd0 /mnt
cp /vagrant/ed.php /mnt/index.php
chmod -R 777 /mnt
umount /mnt

drbdadm secondary d0

pcs cluster auth drbd0 drbd1 drbd2 -u hacluster -p oretykotlety --force
pcs cluster setup --force --name zajac drbd0 drbd1 drbd2
pcs cluster start --all

pcs property set stonith-enabled=false
pcs property set no-quorum-policy=ignore


pcs resource create \
    FloatingIPAddress IPaddr2 ip=192.168.10.50 cidr_netmask=24 \
    op monitor interval=1s

pcs resource create \
    Apache ocf:heartbeat:apache \
    configfile=/etc/httpd/conf/httpd.conf \
    statusurl="http://127.0.0.1/server-status" \
    op monitor interval=20s

pcs constraint colocation add Apache FloatingIPAddress INFINITY
pcs constraint order FloatingIPAddress then Apache


pcs cluster cib fs_cfg

pcs -f fs_cfg resource create \
    DRBDFS Filesystem device="/dev/drbd0" directory="/var/www/html" fstype="ext4"

pcs -f fs_cfg constraint colocation add FloatingIPAddress with DRBDFS INFINITY
pcs -f fs_cfg constraint order DRBDFS then FloatingIPAddress

pcs cluster cib-push fs_cfg

pcs resource op defaults timeout=10s
