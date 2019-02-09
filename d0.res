resource d0 {
  net {
    protocol C;
  }
  device /dev/drbd0;
  disk /dev/sdb;
  meta-disk internal;
  on drbd0 {
    address 192.168.10.60:7788;
    node-id 0;
  }
  on drbd1 {
    address 192.168.10.61:7788;
    node-id 1;
  }
  on drbd2 {
    address 192.168.10.62:7788;
    node-id 2;
  }
  disk {
    resync-rate 110M;
  }
  connection-mesh {
    hosts drbd0 drbd1 drbd2;
  }
}