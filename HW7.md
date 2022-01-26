'# Homework

## Repositories and Packages

#### 1. Download sysstat package.

```bash
[hero@HeroWithin ~]$ wget http://mirror.centos.org/centos/7/os/x86_64/Packages/sysstat-10.1.5-19.el7.x86_64.rpm
--2021-12-30 23:09:41--  http://mirror.centos.org/centos/7/os/x86_64/Packages/sysstat-10.1.5-19.el7.x86_64.rpm
Resolving mirror.centos.org (mirror.centos.org)... 85.236.43.108, 2a02:2658:1056:0:222:19ff:fed6:7c99
Connecting to mirror.centos.org (mirror.centos.org)|85.236.43.108|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 323020 (315K) [application/x-rpm]
Saving to: ‘sysstat-10.1.5-19.el7.x86_64.rpm’

100%[==========================================>] 323,020      341KB/s   in 0.9s

2021-12-30 23:09:42 (341 KB/s) - ‘sysstat-10.1.5-19.el7.x86_64.rpm’ saved [323020/323020]
```

#### 2. Get information from downloaded sysstat package file.

```bash
[hero@HeroWithin ~]$ sudo rpm -qip sysstat-10.1.5-19.el7.x86_64.rpm
[sudo] password for hero:
Name        : sysstat
Version     : 10.1.5
Release     : 19.el7
Architecture: x86_64
Install Date: (not installed)
Group       : Applications/System
Size        : 1172488
License     : GPLv2+
Signature   : RSA/SHA256, Sat 04 Apr 2020 12:08:48 AM MSK, Key ID 24c6a8a7f4a80eb5
Source RPM  : sysstat-10.1.5-19.el7.src.rpm
Build Date  : Wed 01 Apr 2020 07:36:37 AM MSK
Build Host  : x86-01.bsys.centos.org
Relocations : (not relocatable)
Packager    : CentOS BuildSystem <http://bugs.centos.org>
Vendor      : CentOS
URL         : http://sebastien.godard.pagesperso-orange.fr/
Summary     : Collection of performance monitoring tools for Linux
Description :
The sysstat package contains sar, sadf, mpstat, iostat, pidstat, nfsiostat-sysstat,
tapestat, cifsiostat and sa tools for Linux.
The sar command collects and reports system activity information. This
information can be saved in a file in a binary format for future inspection. The
statistics reported by sar concern I/O transfer rates, paging activity,
process-related activities, interrupts, network activity, memory and swap space
utilization, CPU utilization, kernel activities and TTY statistics, among
others. Both UP and SMP machines are fully supported.
The sadf command may be used to display data collected by sar in various formats
(CSV, XML, etc.).
The iostat command reports CPU utilization and I/O statistics for disks.
The tapestat command reports statistics for tapes connected to the system.
The mpstat command reports global and per-processor statistics.
The pidstat command reports statistics for Linux tasks (processes).
The nfsiostat-sysstat command reports I/O statistics for network file systems.
The cifsiostat command reports I/O statistics for CIFS file systems.
```

#### 3. Install sysstat package and get information about files installed by this package.

```bash
[hero@HeroWithin ~]$ sudo rpm -ivh sysstat-10.1.5-19.el7.x86_64.rpm
[sudo] password for hero:
error: Failed dependencies:
        libsensors.so.4()(64bit) is needed by sysstat-10.1.5-19.el7.x86_64
[hero@HeroWithin ~]$ sudo wget https://repo.almalinux.org/almalinux/8/BaseOS/x86_64/os/Packages/lm_sensors-libs-3.4.0-23.20180522git70f7e08.el8.x86_64.rpm
--2021-12-30 23:22:33--  https://repo.almalinux.org/almalinux/8/BaseOS/x86_64/os/Packages/lm_sensors-libs-3.4.0-23.20180522git70f7e08.el8.x86_64.rpm
Resolving repo.almalinux.org (repo.almalinux.org)... 136.243.31.169
Connecting to repo.almalinux.org (repo.almalinux.org)|136.243.31.169|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 59228 (58K) [application/x-redhat-package-manager]
Saving to: ‘lm_sensors-libs-3.4.0-23.20180522git70f7e08.el8.x86_64.rpm’



100%[======================>] 59,228      --.-K/s   in 0.04s

2021-12-30 23:22:34 (1.32 MB/s) - ‘lm_sensors-libs-3.4.0-23.20180522git70f7e08.el8.x86_64.rpm’ saved [59228/59228]

[hero@HeroWithin ~]$ sudo rpm -ivh lm_sensors-libs-3.4.0-23.20180522git70f7e08.el8.x86_64.rpm
warning: lm_sensors-libs-3.4.0-23.20180522git70f7e08.el8.x86_64.rpm: Header V4 RSA/SHA256 Signature, key ID c21ad6ea: NOKEY
Preparing...                                                    ################################# [100%]
Updating / installing...
   1:lm_sensors-libs-3.4.0-23.20180522                          ################################# [100%]
[hero@HeroWithin ~]$ sudo rpm -ivh sysstat-10.1.5-19.el7.x86_64.rpm
Preparing...                                                    ################################# [100%]
Updating / installing...
   1:sysstat-10.1.5-19.el7                                      ################################# [100%]
[
```

#### verifying sysstat installation

```bash
[hero@HeroWithin ~]$ mpstat -V
sysstat version 10.1.5
(C) Sebastien Godard (sysstat <at> orange.fr)
```

#### - Add NGINX repository (need to find repository config on https://www.nginx.com/) and complete the following tasks using yum:

```bash
[hero@HeroWithin ~]$ sudo nano /etc/yum.repos.d/nginx.repo
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
[hero@HeroWithin ~]$ sudo yum-config-manager --enable nginx-mainline
```

#### 1. Check if NGINX repository enabled or not.

```bash
[hero@HeroWithin ~]$ yum repolist
Loaded plugins: fastestmirror
Determining fastest mirrors
 * base: mirror.axelname.ru
 * extras: mirror.axelname.ru
 * updates: mirror.axelname.ru
nginx-mainline                           | 2.9 kB     00:00
nginx-stable                             | 2.9 kB     00:00
(1/2): nginx-stable/7/x86_64/primary_db    |  71 kB   00:00
(2/2): nginx-mainline/7/x86_64/primary_db  | 230 kB   00:01
repo id                        repo name                  status
base/7/x86_64                  CentOS-7 - Base            10,072
extras/7/x86_64                CentOS-7 - Extras             500
nginx-mainline/7/x86_64        nginx mainline repo           887
nginx-stable/7/x86_64          nginx stable repo             258
updates/7/x86_64               CentOS-7 - Updates          3,242
repolist: 14,959
```

#### 2. Install NGINX.

```bash
[hero@HeroWithin ~]$ sudo yum install nginx
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.axelname.ru
 * extras: mirror.axelname.ru
 * updates: mirror.axelname.ru
nginx-mainline                           | 2.9 kB     00:00
nginx-stable                             | 2.9 kB     00:00
(1/2): nginx-stable/7/x86_64/primary_db    |  71 kB   00:00
(2/2): nginx-mainline/7/x86_64/primary_db  | 230 kB   00:00
Resolving Dependencies
--> Running transaction check
---> Package nginx.x86_64 1:1.21.5-1.el7.ngx will be installed
--> Processing Dependency: libpcre2-8.so.0()(64bit) for package: 1:nginx-1.21.5-1.el7.ngx.x86_64
--> Running transaction check
---> Package pcre2.x86_64 0:10.23-2.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================
 Package Arch     Version                Repository        Size
================================================================
Installing:
 nginx   x86_64   1:1.21.5-1.el7.ngx     nginx-mainline   796 k
Installing for dependencies:
 pcre2   x86_64   10.23-2.el7            base             201 k

Transaction Summary
================================================================
Install  1 Package (+1 Dependent package)

Total download size: 997 k
Installed size: 3.3 M
Is this ok [y/d/N]: y
Downloading packages:
(1/2): pcre2-10.23-2.el7.x86_64.rpm        | 201 kB   00:00
warning: /var/cache/yum/x86_64/7/nginx-mainline/packages/nginx-1.21.5-1.el7.ngx.x86_64.rpm: Header V4 RSA/SHA1 Signature, key ID 7bd9bf62: NOKEY
Public key for nginx-1.21.5-1.el7.ngx.x86_64.rpm is not installed
(2/2): nginx-1.21.5-1.el7.ngx.x86_64.rpm   | 796 kB   00:01
----------------------------------------------------------------
Total                              785 kB/s | 997 kB  00:01
Retrieving key from https://nginx.org/keys/nginx_signing.key
Importing GPG key 0x7BD9BF62:
 Userid     : "nginx signing key <signing-key@nginx.com>"
 Fingerprint: 573b fd6b 3d8f bc64 1079 a6ab abf5 bd82 7bd9 bf62
 From       : https://nginx.org/keys/nginx_signing.key
Is this ok [y/N]: y
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
Warning: RPMDB altered outside of yum.
  Installing : pcre2-10.23-2.el7.x86_64                     1/2
  Installing : 1:nginx-1.21.5-1.el7.ngx.x86_64              2/2
----------------------------------------------------------------------

Thanks for using nginx!

Please find the official documentation for nginx here:
* https://nginx.org/en/docs/

Please subscribe to nginx-announce mailing list to get
the most important news about nginx:
* https://nginx.org/en/support.html

Commercial subscriptions for nginx are available on:
* https://nginx.com/products/

----------------------------------------------------------------------
  Verifying  : pcre2-10.23-2.el7.x86_64                     1/2
  Verifying  : 1:nginx-1.21.5-1.el7.ngx.x86_64              2/2

Installed:
  nginx.x86_64 1:1.21.5-1.el7.ngx

Dependency Installed:
  pcre2.x86_64 0:10.23-2.el7

Complete!
```

#### 3. Check yum history and undo NGINX installation.

```bash
[hero@HeroWithin ~]$ sudo yum history list
Loaded plugins: fastestmirror
ID     | Command line             | Date and time    | Action(s)      | Altered
-------------------------------------------------------------------------------
     5 | install nginx            | 2021-12-30 23:24 | Install        |    2 E<
     4 | update                   | 2021-12-30 23:11 | I, U           |   81 >E
     3 | install wget             | 2021-12-11 16:51 | Install        |    1
     2 | install git              | 2021-11-29 02:53 | Install        |   31
     1 | install nano             | 2021-11-25 00:05 | Install        |    1
history list
[hero@HeroWithin ~]$ sudo yum history package-info nginx
[sudo] password for hero:
Loaded plugins: fastestmirror
Transaction ID : 5
Begin time     : Thu Dec 30 23:24:36 2021
Package        : nginx-1:1.21.5-1.el7.ngx.x86_64
State          : Install
Size           : 2,913,067
Build host     : ip-10-1-17-74.eu-central-1.compute.internal
Build time     : Tue Dec 28 21:46:48 2021
Vendor         : NGINX Packaging <nginx-packaging@f5.com>
License        : 2-clause BSD-like license
URL            : https://nginx.org/
Source RPM     : nginx-1.21.5-1.el7.ngx.src.rpm
Commit Time    : Tue Dec 28 15:00:00 2021
Committer      : Konstantin Pavlov <thresh@nginx.com>
Reason         : user
Command Line   : install nginx
From repo      : nginx-mainline
history package-info
[hero@HeroWithin ~]$ sudo yum history undo 5
Loaded plugins: fastestmirror
Undoing transaction 5, from Thu Dec 30 23:24:36 2021
    Install     nginx-1:1.21.5-1.el7.ngx.x86_64 @nginx-mainline
    Dep-Install pcre2-10.23-2.el7.x86_64        @base
Resolving Dependencies
--> Running transaction check
---> Package nginx.x86_64 1:1.21.5-1.el7.ngx will be erased
---> Package pcre2.x86_64 0:10.23-2.el7 will be erased
--> Finished Dependency Resolution

Dependencies Resolved

================================================================
 Package Arch     Version               Repository         Size
================================================================
Removing:
 nginx   x86_64   1:1.21.5-1.el7.ngx    @nginx-mainline   2.8 M
 pcre2   x86_64   10.23-2.el7           @base             556 k

Transaction Summary
================================================================
Remove  2 Packages

Installed size: 3.3 M
Is this ok [y/N]: y
Downloading packages:
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Erasing    : 1:nginx-1.21.5-1.el7.ngx.x86_64              1/2
  Erasing    : pcre2-10.23-2.el7.x86_64                     2/2
  Verifying  : pcre2-10.23-2.el7.x86_64                     1/2
  Verifying  : 1:nginx-1.21.5-1.el7.ngx.x86_64              2/2

Removed:
  nginx.x86_64 1:1.21.5-1.el7.ngx   pcre2.x86_64 0:10.23-2.el7

Complete!
```

#### 4. Disable NGINX repository.

```bash
sudo yum-config-manager --disable repository nginx-mainline
Loaded plugins: fastestmirror
===================== repo: nginx-mainline =====================
[nginx-mainline]
async = True
bandwidth = 0
base_persistdir = /var/lib/yum/repos/x86_64/7
baseurl = http://nginx.org/packages/mainline/centos/7/x86_64/
cache = 0
cachedir = /var/cache/yum/x86_64/7/nginx-mainline
check_config_file_age = True
compare_providers_priority = 80
cost = 1000
deltarpm_metadata_percentage = 100
deltarpm_percentage =
enabled = 0
enablegroups = True
exclude =
failovermethod = priority
ftp_disable_epsv = False
gpgcadir = /var/lib/yum/repos/x86_64/7/nginx-mainline/gpgcadir
gpgcakey =
gpgcheck = True
gpgdir = /var/lib/yum/repos/x86_64/7/nginx-mainline/gpgdir
gpgkey = https://nginx.org/keys/nginx_signing.key
hdrdir = /var/cache/yum/x86_64/7/nginx-mainline/headers
http_caching = all
includepkgs =
ip_resolve =
keepalive = True
keepcache = False
mddownloadpolicy = sqlite
mdpolicy = group:small
mediaid =
metadata_expire = 21600
metadata_expire_filter = read-only:present
metalink =
minrate = 0
mirrorlist =
mirrorlist_expire = 86400
name = nginx mainline repo
old_base_cache_dir =
password =
persistdir = /var/lib/yum/repos/x86_64/7/nginx-mainline
pkgdir = /var/cache/yum/x86_64/7/nginx-mainline/packages
proxy = False
proxy_dict =
proxy_password =
proxy_username =
repo_gpgcheck = False
retries = 10
skip_if_unavailable = False
ssl_check_cert_permissions = True
sslcacert =
sslclientcert =
sslclientkey =
sslverify = True
throttle = 0
timeout = 30.0
ui_id = nginx-mainline/7/x86_64
ui_repoid_vars = releasever,
   basearch
username =
```

#### 5. Remove sysstat package installed in the first task.

```bash
[hero@HeroWithin ~]$ sudo yum remove sysstat
Loaded plugins: fastestmirror
Resolving Dependencies
--> Running transaction check
---> Package sysstat.x86_64 0:10.1.5-19.el7 will be erased
--> Finished Dependency Resolution

Dependencies Resolved

================================================================
 Package     Arch       Version             Repository     Size
================================================================
Removing:
 sysstat     x86_64     10.1.5-19.el7       installed     1.1 M

Transaction Summary
================================================================
Remove  1 Package

Installed size: 1.1 M
Is this ok [y/N]: y
Downloading packages:
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Erasing    : sysstat-10.1.5-19.el7.x86_64                 1/1
  Verifying  : sysstat-10.1.5-19.el7.x86_64                 1/1

Removed:
  sysstat.x86_64 0:10.1.5-19.el7

Complete!
```

#### 6. Install EPEL repository and get information about it.

```bash
[hero@HeroWithin ~]$ sudo yum -y install epel-release
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.axelname.ru
 * extras: mirror.axelname.ru
 * updates: mirror.axelname.ru
nginx-stable                             | 2.9 kB     00:00
Resolving Dependencies
--> Running transaction check
---> Package epel-release.noarch 0:7-11 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================
 Package            Arch         Version     Repository    Size
================================================================
Installing:
 epel-release       noarch       7-11        extras        15 k

Transaction Summary
================================================================
Install  1 Package

Total download size: 15 k
Installed size: 24 k
Downloading packages:
epel-release-7-11.noarch.rpm               |  15 kB   00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : epel-release-7-11.noarch                     1/1
  Verifying  : epel-release-7-11.noarch                     1/1

Installed:
  epel-release.noarch 0:7-11

Complete!
[hero@HeroWithin ~]$ sudo yum info epel-release
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.axelname.ru
 * epel: mirror.nsc.liu.se
 * extras: mirror.axelname.ru
 * updates: mirror.axelname.ru
Installed Packages
Name        : epel-release
Arch        : noarch
Version     : 7
Release     : 14
Size        : 25 k
Repo        : installed
From repo   : epel
Summary     : Extra Packages for Enterprise Linux repository
            : configuration
URL         : http://download.fedoraproject.org/pub/epel
License     : GPLv2
Description : This package contains the Extra Packages for
            : Enterprise Linux (EPEL) repository GPG key as well
            : as configuration for yum.
```

#### 7. Find how much packages provided exactly by EPEL repository.
```bash
sudo yum --disablerepo="*" --enablerepo="epel" list available | tail -n +5 | wc -l
```

#### 8. Install ncdu package from EPEL repo.

```bash
[hero@HeroWithin ~]$ sudo yum --enablerepo="epel" install ncdu
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirror.axelname.ru
 * epel: mirror.nsc.liu.se
 * extras: mirror.axelname.ru
 * updates: mirror.axelname.ru
Resolving Dependencies
--> Running transaction check
---> Package ncdu.x86_64 0:1.16-1.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================
 Package     Arch          Version            Repository   Size
================================================================
Installing:
 ncdu        x86_64        1.16-1.el7         epel         53 k

Transaction Summary
================================================================
Install  1 Package

Total download size: 53 k
Installed size: 89 k
Is this ok [y/d/N]: y
Downloading packages:
ncdu-1.16-1.el7.x86_64.rpm                 |  53 kB   00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : ncdu-1.16-1.el7.x86_64                       1/1
  Verifying  : ncdu-1.16-1.el7.x86_64                       1/1

Installed:
  ncdu.x86_64 0:1.16-1.el7

Complete!
```

## Work with files

#### 1. Find all regular files below 100 bytes inside your home directory.

```bash
[hero@HeroWithin ~]$ sudo find /home/hero -size -100b -type f
/home/hero/.git-credentials
/home/hero/.bash_profile
/home/hero/.gitconfig
/home/hero/devops/HW5.md
.
.
.
```

#### 2. Find an inode number and a hard links count for the root directory. The hard link count should be about 17. Why?

```bash
[hero@HeroWithin ~]$ stat /
  File: ‘/’
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 810h/2064d      Inode: 2           Links: 19
Access: (0555/dr-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2021-12-18 23:11:16.799903938 +0300
Modify: 2021-12-30 23:08:25.276903814 +0300
Change: 2021-12-30 23:08:25.276903814 +0300
 Birth: -
```

##### because 17 directories are used by default

#### 3. Check what inode numbers have "/" and "/boot" directory. Why?

```bash
[hero@HeroWithin ~]$ stat /
  File: ‘/’
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 810h/2064d      Inode: 2           Links: 19
Access: (0555/dr-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2021-12-18 23:11:16.799903938 +0300
Modify: 2021-12-30 23:08:25.276903814 +0300
Change: 2021-12-30 23:08:25.276903814 +0300
 Birth: -
[hero@HeroWithin ~]$  stat /boot
  File: ‘/boot’
  Size: 4096            Blocks: 8          IO Block: 4096   directory
Device: 810h/2064d      Inode: 32773       Links: 5
Access: (0555/dr-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2021-12-30 23:24:32.466924197 +0300
Modify: 2021-12-30 23:14:00.496910879 +0300
Change: 2021-12-30 23:14:00.496910879 +0300
 Birth: -
```

##### /boot is a different file system of the same type (xfs), and it's the root directory of this file system, so it's very likely that it uses the same inode number as /. 

#### 4. Check the root directory space usage by du command. Compare it with an information from df. If you find differences, try to find out why it happens.

```bash
[hero@centos ~]$ df -h
Filesystem               Size  Used Avail Use% Mounted on
devtmpfs                 898M     0  898M   0% /dev
tmpfs                    910M     0  910M   0% /dev/shm
tmpfs                    910M  9.6M  901M   2% /run
tmpfs                    910M     0  910M   0% /sys/fs/cgroup
/dev/mapper/centos-root  8.0G  1.4G  6.7G  17% /
/dev/sda1               1014M  150M  865M  15% /boot
tmpfs                    182M     0  182M   0% /run/user/1000
[hero@centos ~]$ sudo du -hcs /
[sudo] password for hero:
du: cannot access ‘/proc/1769/task/1769/fd/4’: No such file or directory
du: cannot access ‘/proc/1769/task/1769/fdinfo/4’: No such file or directory
du: cannot access ‘/proc/1769/fd/3’: No such file or directory
du: cannot access ‘/proc/1769/fdinfo/3’: No such file or directory
1.5G    /
1.5G    total
```

##### df is accounting for all the space allocated for inodes and other administrative overhead, whereas du is just accounting for the space used by the files.

#### 5. Check disk space usage of /var/log directory using ncdu

```bash
[hero@centos ~]$ ncdu -x /var/log
 Total disk usage:   9.3 MiB  Apparent size:   9.6 MiB  Items: 59
```
