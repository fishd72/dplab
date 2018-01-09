# DPLab (Distribution point Lab)

DPLab is an automated Jamf Pro Distribution Point deployment, leveraging Vagrant to quickly spin up a customised DP.

## Features

- Installs Apache 2 and Avahi
- Utilises the hostname of the VM using Avahi for the web server's FQDN
- Configures for HTTP (non-SSL) communication over 8081
- The repo containing packages is setup from within the Vagrant folder on the guest VM. This means that all packages can be copied to the working Vagrant directory on the Host device
- - Works with vagrant-jpslab

## Getting Started

### Prerequsites

- Virtualbox or VMware Fusion
- Vagrant

## More to come...!
