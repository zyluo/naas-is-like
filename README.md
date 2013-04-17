# naas-is-like

## What is naas-is-like?

> A collection of bash scripts for OpenStack virtual network service integration testing based on NaaS requirements.  
All scripts were written based on the [OpenStack administrator manuals](http://docs.openstack.org/run/)

## License
> No license. This is just a rewrite of the CLI commands in the admin docs.

## How to use the scripts
1. Download, install, and run [DevStack](http://devstack.org/)
1. Edit the 'globals' file to match your enviornment variables with DevStack's 'localrc'.
1. Run the scripts

    \./01\_setup\_network\_topology\.sh  
    \./02\_setup\_l2\_virtual_network\.sh  
    \./03\_test\_l2\_virtual\_network\.sh  
    \.\.\.  

## Contacts
> zhongyue.luo@gmail.com
