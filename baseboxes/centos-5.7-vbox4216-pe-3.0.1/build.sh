#!/bin/bash

CurrentDir=$(pwd)
BoxBaseName=${PWD##*/}
VMName=Learning\ Puppet\ VM\ \(pe-3.0.1\)
VMPath=~/VirtualBox\ VMs/${VMName}/${VMName}.vbox
BoxName=${BoxBaseName}.box
OVFName=box.ovf
VagrantBoxName=LearnPuppetVM-PE301

printf "Creating a vagrant basebox named $BoxName \n"

# Remove existing artifacts
rm -f box-disk1.vmdk
rm -f box.ovf
rm -f $BoxName

# Prepare the VM
vboxmanage export "$VMPath" -o $OVFName #--vsys 0 --eula "This is for evaluation purposes only. You must provide a valid license to use this box."

# Tar and gzip the box
tar --exclude='*.sh' -cvzf $BoxName ./*

# Remove the artifacts to save space
rm -f box-disk1.vmdk
rm -f box.ovf

# Add/update the box
vagrant box add "$VagrantBoxName" $BoxName --provider virtualbox --force