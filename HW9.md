# Homework

### 1. add secondary ip address to you second network interface enp0s8. Each point must be presented with commands and showing that new address was applied to the interface. To repeat adding address for points 2 and 3 address must be deleted (please add deleting address to you homework log) Methods:

   #### 1.1 using ip utility (stateless)

```bash
[hero@centos ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:dd:4d:e3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.225.128/24 brd 192.168.225.255 scope global noprefixroute dynamic ens33
       valid_lft 963sec preferred_lft 963sec
    inet6 fe80::dfdb:481:367b:712/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
[hero@centos ~]$ sudo ip addr add 192.168.225.129/24 dev ens33
[sudo] password for hero:
[hero@centos ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:dd:4d:e3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.225.128/24 brd 192.168.225.255 scope global noprefixroute dynamic ens33
       valid_lft 1798sec preferred_lft 1798sec
    inet 192.168.225.129/24 scope global secondary ens33
       valid_lft forever preferred_lft forever
    inet6 fe80::dfdb:481:367b:712/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
[hero@centos ~]$ sudo ip addr del 192.168.225.129/24 dev ens33
[hero@centos ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:dd:4d:e3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.225.128/24 brd 192.168.225.255 scope global noprefixroute dynamic ens33
       valid_lft 1776sec preferred_lft 1776sec
    inet6 fe80::dfdb:481:367b:712/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
```

   #### 1.2 using centos network configuration file (statefull)

```bash
[hero@centos ~]$ sudo nano /etc/sysconfig/network-scripts/ifcfg-ens33:1
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="none"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
IPADDR="192.168.225.129"
DEVICE="ens33:1"
ONBOOT="yes"
[hero@centos ~]$ systemctl restart network
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentication is required to manage system services or units.
Authenticating as: hero
Password:
==== AUTHENTICATION COMPLETE ===
[hero@centos ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:dd:4d:e3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.225.128/24 brd 192.168.225.255 scope global noprefixroute dynamic ens33
       valid_lft 1799sec preferred_lft 1799sec
    inet 192.168.225.129/24 brd 192.168.225.255 scope global secondary noprefixroute ens33:1
       valid_lft forever preferred_lft forever
    inet6 fe80::dfdb:481:367b:712/64 scope link tentative noprefixroute
       valid_lft forever preferred_lft forever
[hero@centos ~]$ sudo nano /etc/sysconfig/network-scripts/ifcfg-ens33:1 #removed config
[hero@centos ~]$ systemctl restart network
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentication is required to manage system services or units.
Authenticating as: hero
Password:
==== AUTHENTICATION COMPLETE ===
[hero@centos ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:dd:4d:e3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.225.128/24 brd 192.168.225.255 scope global noprefixroute dynamic ens33
       valid_lft 1799sec preferred_lft 1799sec
    inet6 fe80::dfdb:481:367b:712/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
```

   #### 1.3 using nmcli utility (statefull)

```bash
[hero@centos ~]$ sudo nmcli con mod ens33 +ipv4.addresses "192.168.225.129/24"
[hero@centos ~]$ sudo reboot
[hero@centos ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:dd:4d:e3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.225.128/24 brd 192.168.225.255 scope global noprefixroute dynamic ens33
       valid_lft 1795sec preferred_lft 1795sec
    inet 192.168.225.129/24 brd 192.168.225.255 scope global secondary noprefixroute ens33
       valid_lft forever preferred_lft forever
    inet6 fe80::dfdb:481:367b:712/64 scope link noprefixroute
       valid_lft forever preferred_lft f
```

### 2. You should have a possibility to use ssh client to connect to your node using new address from previous step. Run tcpdump in separate tmux session or separate connection before starting ssh client and capture packets that are related to this ssh connection. Find packets that are related to TCP session establish.
### 3. Close session. Find in tcpdump output packets that are related to TCP session closure.

```bash
[hero@HeroWithin ~]$ sudo tcpdump -i eth0 -w /home/hero/ch9/dump
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
^C62 packets captured
64 packets received by filter
0 packets dropped by kernel
==================================================================================
[hero@HeroWithin ~]$ ssh hero@192.168.225.128
hero@192.168.225.128's password:
Last login: Sat Jan  1 20:36:54 2022 from 192.168.225.1
[hero@centos ~]$ exit
logout
Connection to 192.168.225.128 closed.
[hero@HeroWithin ~]$
```

#### terminal (Windows)

##### Start SSH session (establishing a connection) ![start SSH session](https://user-images.githubusercontent.com/33420376/147834440-f2545088-2d76-4fe5-b019-053049dd1df5.png)
##### The end SSH session ![closing a connection](https://user-images.githubusercontent.com/33420376/147834474-f4227143-3ec2-406a-b3d4-c74bcfb16706.png)

### 4. run tcpdump and request any http site in separate session. Find HTTP request and answer packets with ASCII data in it.  Tcpdump command must be as strict as possible to capture only needed packages for this http request.

#### Dump session

```bash
[hero@HeroWithin ~]$ sudo tcpdump -A tcp port 80 -i eth0 -w /home/hero/ch9/dump2
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
^C20 packets captured
20 packets received by filter
0 packets dropped by kernel
```

#### curl session

```bash
[hero@HeroWithin ~]$ curl http://manpages.ubuntu.com/manpages/bionic/ru/man1/vimtutor.1.html
```

##### Dump data ![image](https://user-images.githubusercontent.com/33420376/147834696-72fd14a2-0027-4da8-89a8-ece2b07a8602.png)


