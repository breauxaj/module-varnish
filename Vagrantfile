# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/home/vagrant/varnish", type: "rsync", rsync__exclude: ".git/"
  config.ssh.insert_key = false

  config.vm.define "centos" do |centos|
    centos.vm.box     = 'breauxaj/centos7'
    centos.vm.box_url = "http://vagrant.breaux.io/centos7.json"

    centos.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests"
      puppet.manifest_file  = "vagrant.pp"
      puppet.options        = ["--modulepath", "/home/vagrant"]
    end
  end

end
