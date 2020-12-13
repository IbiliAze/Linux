#!/bin/bash


nmcli #show interfaces
nmcli device status
nmcli device show ens33
sudo nmcli connection edit ens33
    > set connection.autoconnect yes
    > set ipv4.method manual #no DHCP
    > set ipv4.addr 10.23.12.323/24
    > set ipv4.gateway 10.1.1.1
    > save persistent #commits to hard drive
sudo nmcli connection reload #save the config



    
