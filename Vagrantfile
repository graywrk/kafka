# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_SERVER_URL'] = 'https://vagrant.elab.pro'

Vagrant.configure("2") do |config|
  # Общие настройки для всех машин
  config.vm.box = "ubuntu/jammy64"
  config.vm.box_check_update = false

  # Настройка машины kafka01
  config.vm.define "kafka01" do |kafka|
    kafka.vm.hostname = "kafka01"
    kafka.vm.network "private_network", ip: "192.168.56.10"
    kafka.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
  end

  # Настройка машины kafka02
  config.vm.define "kafka02" do |kafka|
    kafka.vm.hostname = "kafka02"
    kafka.vm.network "private_network", ip: "192.168.56.11"
    kafka.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
  end

  # Настройка машины kafka03
  config.vm.define "kafka03" do |kafka|
    kafka.vm.hostname = "kafka03"
    kafka.vm.network "private_network", ip: "192.168.56.12"
    kafka.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
  end

  # Настройка машины db01
  config.vm.define "db01" do |db|
    db.vm.hostname = "db01"
    db.vm.network "private_network", ip: "192.168.56.13"
    db.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 2
    end
  end

  # Настройка машины web01
  config.vm.define "web01" do |web|
    web.vm.hostname = "web01"
    web.vm.network "private_network", ip: "192.168.56.14"
    web.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = 1
    end
  end
end 