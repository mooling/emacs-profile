# 使用Vagrant来模拟VPS进行实验

## 参考
	
1. [vagrant打造自己的开发环境](http://lovelace.blog.51cto.com/1028430/1423343)
2. Box 下载地址 ： [Vagrantbox.es](http://www.vagrantbox.es/)
3. xshell 下载 ：[netsarang](http://www.netsarang.com/download/main.html)
4. [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
5. [Vagrant](https://www.vagrantup.com/downloads.html)

## 搬运
链接：[http://pan.baidu.com/s/1pJ81iAJ](http://pan.baidu.com/s/1pJ81iAJ) 密码：dfbg

## 安装过程

* 下载安装 [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
 
* 下载安装 [Vagrant](https://www.vagrantup.com/downloads.html)

* 下载 [Debian 7.4 x86 box](http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_debian-7.4-i386_chef-provisionerless.box)

* 添加到Vagrant，添加后就可以在vagrant新建的系统中使用了名字来引用了
	
	vagrant box add debian opscode_debian-7.4-i386_chef-provisionerless.box 

* 配置文件 ： Vagrantfile，可以放置在任意目录中，如 D:\vps\debian ，这里模拟VPS仅使用128M内存，在Win系统中可以直接通过xshell连接 192.168.33.10地址，因为Virtual Box会虚拟一个网卡用于内外网的连接。
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

* 启动改系统

	vagrant up

* 可能的问题
	
	无法连接虚拟机，特别是64位的系统，这个是因为bios中没有开启虚拟化支持

## 过程的一些理解

Box是一个封装，包含虚拟磁盘及其中安装好系统，以及相关的一些配置。当使用box add之后就可以在系统中引用，其本质就是Box是一个压缩文件，add的过程就是将这些文件解压缩至 **$USER\.vagrant.d\boxes\** 这个目录下，其中目录名即使add后面跟着的name参数，该参数在后续的配置文件中可以直接引用。

编写 Vagrantfile 是描述虚拟机的文件，如使用哪个box、端口映射、内存、IP地址等。这些是描述，本质Vagrant还是调用VirtualBox来进行自动的调用，与openstack类似，openstack如果说是一个虚拟机群的管理软件，底层通过调用libvirt来进行虚拟机的管理，那么vagrant就是一个单机的虚拟机管理软件，一个是用python实现，一个用ruby实现，其实和docker也比较类似，go实现的一个容器管理软件。Vagrant up 第一次调用是将虚拟的镜像磁盘、配置放入virtualbox中，存在一次拷贝的过程，放入 ** $USER\VirtualBox VMs\ ** 中，后续改命令仅仅是启动virtualbox虚拟机。


## Github地址

- [Vagrant_and_VPS.md](https://github.com/mooling/emacs-profile/blob/master/ls/docs/blog/Vagrant_and_VPS.md)