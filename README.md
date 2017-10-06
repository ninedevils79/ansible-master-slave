# Deploy a Master and Slave servers using Ansible

This Ansible scripts will help you to deploy a master and a slave server using Ansible. 

You would need to have a few things ready in order to do this - and once done, you will be able to do quick deploy's and teardowns. 

All the Ansible scripts are part of the `play.yml`. In this way, you can run the individual playbooks should you wish. 

## What you need

* Cloud-Metadata script found at https://github.com/ninedevils79/cloud-metadata
* RHEL or CentOS qcow images. Fedora qcow images may work, but I haven't tested them.  
* Any server running `libvirt`

### Cloud-metadata 

Follow the README at https://github.com/ninedevils79/cloud-metadata

Create the `master` and the `slave` ISO's. You can use just one should you wish, but if you want to give a different IP's then you will need to use different ISO's, in this way you will get consistent IP's across builds and teardowns. 

Save the files as `master-init.iso` and as `slave-init.iso`. 

To make life easier, you can enter the IP's in your local `/etc/hosts` as well. Upto you!

## Prep work

Do the following to change to suit your environment. 

### Customize your environment

Once you have got your `qcow` image, change the `kvm_image` in `common-tasks/libvirt-vars.yml`

### change_hostname.sh

This script will change the `libvirt` hostname in all the scripts. Use it to make life easy!

### Ansible hosts file

Add the name of your `libvirt` in your `hosts` file so Ansible knows where to find it.

### Master playbook  

The `play.yml` is the master playbook which has different plays in it. 

A quick explanation 

- `ping.yml` 
  This will ping the `libvirt` host

- `file-status.yml`
  This will check if the `qcow's` exist. 

- `copy.yml`
  This will make a copy of the original qcow, as you don't want to download it all the time and give it appropriate names. 

- `launch.yml` 
  This will launch VM's on your `libvirt` host. 
  If by any chance if you are using a briding network, change the following line in your `launch.yml`
  `--network default` to `--network br0`

- `getip.yml`
  This will get the ip's of your VM's should you not have specified to use static IP address assignment for your VM's 

## cleanup.yml

For a teardown, use the `cleanup.yml` file to stop and destroy the VM's. Use as required.






