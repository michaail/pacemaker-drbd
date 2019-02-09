servers = [
  {
    hostname: 'drbd0',
    ip: '192.168.10.60',
    disk: './drbd0.vdi'
  }, {
    hostname: 'drbd1',
    ip: '192.168.10.61',
    disk: './drbd1.vdi'
  }, {
    hostname: 'drbd2',
    ip: '192.168.10.62',
    disk: './drbd2.vdi'
  }
]

Vagrant.configure('2') do |config|
  servers.each do |server|
    config.vm.define server[:hostname] do |e|
      # create a box
      e.vm.box = 'centos/7'
      e.vm.hostname = server[:hostname]
      e.vm.network 'private_network', ip: server[:ip]

      # add a virtual disk
      # file_to_disk = "/tmp/vdisk#{server[:hostname]}.hdi"
      e.vm.provider :virtualbox do |vb|
        if not File.exist?(server[:disk])
          vb.customize ['createhd', '--filename', server[:disk], '--size', 2 * 1024]
        end
        vb.customize ['storagectl', :id, '--name', 'SATA', '--add', 'sata']
        vb.customize ['storageattach', :id, '--storagectl', 'SATA', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', server[:disk]]
      end

      # run all the shit
      e.vm.provision 'shell', path: 'install.sh'
      e.vm.provision 'shell', path: 'configure.sh'
      e.vm.provision 'shell', path: 'startup.sh'
    end
  end
end
