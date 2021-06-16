
Vagrant.configure("2") do |config|

  config.vm.define "namenode" do |namenode|
    namenode.vm.box = "debian/bullseye64"
    namenode.vm.network "private_network", ip: "172.16.0.110"
    namenode.vm.hostname = "namenode.example.org"

    config.vm.synced_folder ".", "/vagrant"

    namenode.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 512
    end
  end

  config.vm.define "secondarynamenode" do |secondarynamenode|
    secondarynamenode.vm.box = "debian/bullseye64"
    secondarynamenode.vm.network "private_network", ip: "172.16.0.111"
    secondarynamenode.vm.hostname = "secondarynamenode.example.org"

    config.vm.synced_folder ".", "/vagrant"
    
    secondarynamenode.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 512
    end
  end

  config.vm.define "resourcemanager" do |resourcemanager|
    resourcemanager.vm.box = "debian/bullseye64"
    resourcemanager.vm.network "private_network", ip: "172.16.0.120"
    resourcemanager.vm.hostname = "resourcemanager.example.org"

    config.vm.synced_folder ".", "/vagrant"
    
    resourcemanager.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 1024
    end
  end

  config.vm.define "datanode1" do |datanode1|
    datanode1.vm.box = "debian/bullseye64"
    datanode1.vm.network "private_network", ip: "172.16.0.131"
    datanode1.vm.hostname = "datanode1.example.org"

    config.vm.synced_folder ".", "/vagrant"
    
    datanode1.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 1024
    end
  end

  config.vm.define "datanode2" do |datanode2|
    datanode2.vm.box = "debian/bullseye64"
    datanode2.vm.network "private_network", ip: "172.16.0.132"
    datanode2.vm.hostname = "datanode2.example.org"

    config.vm.synced_folder ".", "/vagrant"
    
    datanode2.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 1024
    end
  end

  config.vm.define "datanode3" do |datanode3|
    datanode3.vm.box = "debian/bullseye64"
    datanode3.vm.network "private_network", ip: "172.16.0.133"
    datanode3.vm.hostname = "datanode3.example.org"

    config.vm.synced_folder ".", "/vagrant"
    
    datanode3.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 1024
    end
  end

  config.vm.define "client" do |client|
    client.vm.box = "debian/bullseye64"
    client.vm.network "private_network", ip: "172.16.0.150"
    client.vm.hostname = "client.example.org"

    config.vm.synced_folder ".", "/vagrant"
    
    client.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 512
    end
  end

  config.vm.provision "shell", inline: "bash -x /vagrant/common.sh"
end

