#!/bin/bash
echo "Installing Vagrant dependencies ..."
vagrant plugin install vagrant-env
vagrant plugin install vagrant-proxyconf
vagrant plugin install vagrant-share
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-hostmanager

echo "Making Boxes dir ..."
mkdir Boxes

echo "Making sure base vm is down ..."
vagrant destroy -f base

echo "Starting cleaning up old box file ..."
rm -f Boxes/base.box
vagrant box remove --force file://Boxes/base.box

echo "Starting base vm ..."
vagrant up base

echo "Packing the new image into Boxes/base.box"
vagrant package --base base -o Boxes/base.box

echo "Cleaning up base vm ..."
vagrant destroy -f base
