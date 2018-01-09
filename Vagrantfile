Vagrant.configure("2") do |config|
  config.vm.box = "wegotoeleven/xenial64"
  config.vm.box_url = 's3://wegotoeleven-vagrantboxes/xenial64.box'
  config.vm.hostname = "dplab"
  config.vm.provider "vmware_fusion" do |vmware|
    vmware.vmx["memsize"] = "1024"
    vmware.vmx["numvcpus"] = "1"
    vmware.gui = false
  end
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 1
    vb.gui = false
  end
  config.vm.network :forwarded_port, guest: 8081, host: 8081, auto_correct: true
  config.vm.provision :shell, :path => "scripts/dpSetup.sh"
  config.ssh.forward_agent = true
end
