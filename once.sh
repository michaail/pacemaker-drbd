#!/usr/bin/env bash
vagrant ssh drbd0 -c "sudo systemctl start drbd"
vagrant ssh drbd1 -c "sudo systemctl start drbd"
vagrant ssh drbd2 -c "sudo systemctl start drbd"

vagrant ssh drbd0 -c "cp /vagrant/setup.sh ~"

