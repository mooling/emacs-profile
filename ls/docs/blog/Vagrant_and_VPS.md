
### 参考 ###
	
	1. [vagrant打造自己的开发环境](http://lovelace.blog.51cto.com/1028430/1423343)
	2. Box 下载地址 ： [Vagrantbox.es](http://www.vagrantbox.es/)

###  ###



### 安装过程 ###

	- 下载box

		下载 Debian 7.4 x86 ： <http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_debian-7.4-i386_chef-provisionerless.box>

	- 添加到Vagrant，添加后就可以在vagrant新建的系统中使用了名字来引用了
	
		`vagrant box add **debian** opscode_debian-7.4-i386_chef-provisionerless.box`  

	- 配置文件 ： Vagrantfile，可以放置在任意目录中，如 D:\vps\debian
	
		# -*- mode: ruby -*-
		# vi: set ft=ruby :
		
		# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
		VAGRANTFILE_API_VERSION = "2"
		
		Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
		  config.vm.box = "debian"
		  config.vm.network "forwarded_port", guest: 80, host: 8080
		  config.vm.network "private_network", ip: "192.168.33.10"
		  config.vm.synced_folder "../data", "/vagrant_data"
		
		  config.vm.provider "virtualbox" do |vb|
		    vb.name = "debian.vps"
		    vb.customize ["modifyvm", :id, "--memory", "128"]
		  end
		end

	- 启动改系统

		`vagrant up` 

	- 可能的问题
	
		- 无法连接虚拟机，特别是64位的系统，这个是因为bios中没有开启虚拟化支持