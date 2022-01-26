# Homework

### 1. Imagine you was asked to add new partition to your host for backup purposes. To simulate appearance of new physical disk in your server, please create new disk in Virtual Box (5 GB) and attach it to your virtual machine.
### Also imagine your system started experiencing RAM leak in one of the applications, thus while developers try to debug and fix it, you need to mitigate OutOfMemory errors; you will do it by adding some swap space.

```bash
[hero@centos ~]$ lsblk
NAME            MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda               8:0    0  10G  0 disk
├─sda1            8:1    0   1G  0 part /boot
└─sda2            8:2    0   9G  0 part
  ├─centos-root 253:0    0   8G  0 lvm  /
  └─centos-swap 253:1    0   1G  0 lvm  [SWAP]
sdb               8:16   0   5G  0 disk
```

#### /dev/sdb - 5GB disk, that you just attached to the VM (in your case it may appear as /dev/sdb, /dev/sdc or other, it doesn't matter)
#### 1.1. Create a 2GB   !!! GPT !!!   partition on /dev/sdc of type "Linux filesystem" (means all the following partitions created in the following steps on /dev/sdc will be GPT as well)

```bash
[hero@centos ~]$ sudo fdisk /dev/sdb
WARNING: fdisk GPT support is currently new, and therefore in an experimental phase. Use at your own discretion.
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p

Disk /dev/sdb: 5368 MB, 5368709120 bytes, 10485760 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: gpt
Disk identifier: 85BA364D-F08F-4060-8431-DAE71E1430AF


#         Start          End    Size  Type            Name

Command (m for help): g
Building a new GPT disklabel (GUID: 8B7CB4C4-4935-4309-80E6-7908EE994206)


Command (m for help): n
Partition number (1-128, default 1):
First sector (2048-10485726, default 2048):
Last sector, +sectors or +size{K,M,G,T,P} (2048-10485726, default 10485726): +size 2G
Last sector, +sectors or +size{K,M,G,T,P} (2048-10485726, default 10485726): +2G
Created partition 1


Command (m for help): p

Disk /dev/sdb: 5368 MB, 5368709120 bytes, 10485760 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: gpt
Disk identifier: 8B7CB4C4-4935-4309-80E6-7908EE994206


#         Start          End    Size  Type            Name
 1         2048      4196351      2G  Linux filesyste

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
[hero@centos ~]$ lsblk
NAME            MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda               8:0    0  10G  0 disk
├─sda1            8:1    0   1G  0 part /boot
└─sda2            8:2    0   9G  0 part
  ├─centos-root 253:0    0   8G  0 lvm  /
  └─centos-swap 253:1    0   1G  0 lvm  [SWAP]
sdb               8:16   0   5G  0 disk
└─sdb1            8:17   0   2G  0 part
[hero@centos ~]$
```

#### 1.2. Create a 512MB partition on /dev/sdc of type "Linux swap"

```bash
[hero@centos ~]$ sudo fdisk /dev/sdb
WARNING: fdisk GPT support is currently new, and therefore in an experimental phase. Use at your own discretion.
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): n
Partition number (2-128, default 2):
First sector (4196352-10485726, default 4196352):
Last sector, +sectors or +size{K,M,G,T,P} (4196352-10485726, default 10485726): +512M
Created partition 2


Command (m for help): t
Partition number (1,2, default 2): 2
Partition type (type L to list all types): 19
Changed type of partition 'Linux filesystem' to 'Linux swap'

Command (m for help): p

Disk /dev/sdb: 5368 MB, 5368709120 bytes, 10485760 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: gpt
Disk identifier: 8B7CB4C4-4935-4309-80E6-7908EE994206


#         Start          End    Size  Type            Name
 1         2048      4196351      2G  Linux filesyste
 2      4196352      5244927    512M  Linux swap

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
Syncing disks.
```

#### 1.3. Format the 2GB partition with an XFS file system

```bash
[hero@centos ~]$ sudo mkfs.xfs /dev/sdb1
meta-data=/dev/sdb1              isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
```

#### 1.4. Initialize 512MB partition as swap space

```bash
[hero@centos ~]$ sudo mkswap /dev/sdb2
Setting up swapspace version 1, size = 524284 KiB
no label, UUID=e31b0469-ea09-41fb-8f03-e96f38d66fd4
[hero@centos ~]$ sudo swapon /dev/sdb2
```

#### 1.5. Configure the newly created XFS file system to persistently mount at /backup

```bash
[hero@centos ~]$ sudo blkid
/dev/sda1: UUID="5e17690d-6e99-4682-9a20-d374b224ede7" TYPE="xfs"
/dev/sda2: UUID="LVO90O-RlvV-jr7V-5J8n-JKbt-i2bJ-DKKWfL" TYPE="LVM2_member"
/dev/sdb1: UUID="2c0b6099-3b7b-406c-a229-3933a16ada81" TYPE="xfs" PARTUUID="9e083b71-47e7-4ddc-b473-33b938a61667"
/dev/sdb2: UUID="e31b0469-ea09-41fb-8f03-e96f38d66fd4" TYPE="swap" PARTUUID="b8ec0c66-b9d1-49b4-b92e-705c48eb7b58"
/dev/mapper/centos-root: UUID="c6fe8ad8-f30f-40fe-a3ff-d84b09f2efa6" TYPE="xfs"
/dev/mapper/centos-swap: UUID="58b867ff-ba50-4cc2-a5f5-4ea3f377f974" TYPE="swap"
[hero@centos ~]$ sudo mkdir /backup
[hero@centos ~]$ sudo mount /dev/sdb1 /backup
[hero@centos ~]$ sudo nano /etc/fstab
#
# /etc/fstab
# Created by anaconda on Sat Nov 27 18:12:10 2021
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
/dev/mapper/centos-root /                       xfs     defaults        0 0
UUID=5e17690d-6e99-4682-9a20-d374b224ede7 /boot                   xfs     defaults        0 0
/dev/mapper/centos-swap swap                    swap    defaults        0 0
UUID=2c0b6099-3b7b-406c-a229-3933a16ada81       /backup xfs     defaults        0 0
```

#### 1.6. Configure the newly created swap space to be enabled at boot

```bash
[hero@centos ~]$ sudo nano /etc/fstab
#
# /etc/fstab
# Created by anaconda on Sat Nov 27 18:12:10 2021
#
# Accessible filesystems, by reference, are maintained under '/dev/disk'
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info
#
/dev/mapper/centos-root /                       xfs     defaults        0 0
UUID=5e17690d-6e99-4682-9a20-d374b224ede7 /boot                   xfs     defaults        0 0
/dev/mapper/centos-swap swap                    swap    defaults        0 0
UUID=2c0b6099-3b7b-406c-a229-3933a16ada81       /backup xfs     defaults        0 0
UUID=e31b0469-ea09-41fb-8f03-e96f38d66fd4       swap    swap    defaults        0 0
[hero@centos ~]$ sudo mount -a
```

#### 1.7. Reboot your host and verify that /dev/sdc1 is mounted at /backup and that your swap partition  (/dev/sdc2) is enabled

```bash
[hero@centos ~]$ df -h
Filesystem               Size  Used Avail Use% Mounted on
devtmpfs                 898M     0  898M   0% /dev
tmpfs                    910M     0  910M   0% /dev/shm
tmpfs                    910M  9.6M  901M   2% /run
tmpfs                    910M     0  910M   0% /sys/fs/cgroup
/dev/mapper/centos-root  8.0G  1.4G  6.6G  18% /
/dev/sdb1                2.0G   33M  2.0G   2% /backup
/dev/sda1               1014M  137M  878M  14% /boot
tmpfs                    182M     0  182M   0% /run/user/1000
[hero@centos ~]$ cat /proc/swaps
Filename                                Type            Size    Used    Priority
/dev/sdb2                               partition       524284  0       -2
/dev/dm-1                               partition       1048572 0       -3
[hero@centos ~]$
```

### 2. LVM. Imagine you're running out of space on your root device. As we found out during the lesson default CentOS installation should already have LVM, means you can easily extend size of your root device. So what are you waiting for? Just do it!
#### 2.1. Create 2GB partition on /dev/sdb of type "Linux LVM"

```bash
[hero@centos ~]$ sudo fdisk /dev/sdb
[sudo] password for hero:
WARNING: fdisk GPT support is currently new, and therefore in an experimental phase. Use at your own discretion.
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p

Disk /dev/sdb: 5368 MB, 5368709120 bytes, 10485760 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: gpt
Disk identifier: 8B7CB4C4-4935-4309-80E6-7908EE994206


#         Start          End    Size  Type            Name
 1         2048      4196351      2G  Linux filesyste
 2      4196352      5244927    512M  Linux swap

Command (m for help): n
Partition number (3-128, default 3):
First sector (5244928-10485726, default 5244928):
Last sector, +sectors or +size{K,M,G,T,P} (5244928-10485726, default 10485726): +2G
Created partition 3


Command (m for help): t
Partition number (1-3, default 3): 3
Partition type (type L to list all types): 31
Changed type of partition 'Linux filesystem' to 'Linux LVM'

Command (m for help): p

Disk /dev/sdb: 5368 MB, 5368709120 bytes, 10485760 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: gpt
Disk identifier: 8B7CB4C4-4935-4309-80E6-7908EE994206


#         Start          End    Size  Type            Name
 1         2048      4196351      2G  Linux filesyste
 2      4196352      5244927    512M  Linux swap
 3      5244928      9439231      2G  Linux LVM

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 16: Device or resource busy.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
Syncing disks.
[hero@centos ~]$ sudo partprobe
```
#### 2.2. Initialize the partition as a physical volume (PV)
```bash
[hero@centos ~]$ sudo pvcreate /dev/sdb3
  Physical volume "/dev/sdb3" successfully created.
```

#### 2.3. Extend the volume group (VG) of your root device using your newly created PV
```bash
[hero@centos ~]$ df /root/
Filesystem              1K-blocks    Used Available Use% Mounted on
/dev/mapper/centos-root   8374272 1415568   6958704  17% /
[hero@centos ~]$ sudo lvs -o +devices /dev/mapper/centos-root
  LV   VG     Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert Devices

  root centos -wi-ao---- <8.00g                                                     /dev/sda2(256)
[hero@centos ~]$ sudo vgextend centos /dev/sdb3
  Volume group "centos" successfully extended
```

#### 2.4. Extend your root logical volume (LV) by 1GB, leaving other 1GB unassigned
```bash
[hero@centos ~]$ sudo lvextend -L+1G /dev/centos/root
  Size of logical volume centos/root changed from <8.00 GiB (2047 extents) to <9.00 GiB (2303 extents).
  Logical volume centos/root successfully resized.
```

#### 2.5. Check current disk space usage of your root device
```bash
[hero@centos ~]$ sudo lvdisplay
  --- Logical volume ---
  LV Path                /dev/centos/swap
  LV Name                swap
  VG Name                centos
  LV UUID                pQ7DP5-WtJb-dG8z-dBii-xM3R-rNZG-dI94UX
  LV Write Access        read/write
  LV Creation host, time centos, 2021-11-27 18:12:08 +0300
  LV Status              available
  # open                 2
  LV Size                1.00 GiB
  Current LE             256
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:1

  --- Logical volume ---
  LV Path                /dev/centos/root
  LV Name                root
  VG Name                centos
  LV UUID                yA9JcU-bTqQ-8Lhx-fnAh-Rgxl-MSnI-pDoCTl
  LV Write Access        read/write
  LV Creation host, time centos, 2021-11-27 18:12:09 +0300
  LV Status              available
  # open                 1
  LV Size                <9.00 GiB
  Current LE             2303
  Segments               2
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:0
```

#### 2.6. Extend your root device filesystem to be able to use additional free space of root LV
```bash
[hero@centos ~]$ sudo xfs_growfs /dev/centos/root
meta-data=/dev/mapper/centos-root isize=512    agcount=4, agsize=524032 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0 spinodes=0
data     =                       bsize=4096   blocks=2096128, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal               bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
data blocks changed from 2096128 to 2358272
[hero@centos ~]$ df -h
Filesystem               Size  Used Avail Use% Mounted on
devtmpfs                 898M     0  898M   0% /dev
tmpfs                    910M     0  910M   0% /dev/shm
tmpfs                    910M  9.6M  901M   2% /run
tmpfs                    910M     0  910M   0% /sys/fs/cgroup
/dev/mapper/centos-root  9.0G  1.4G  7.7G  16% /
/dev/sda1               1014M  150M  865M  15% /boot
tmpfs                    182M     0  182M   0% /run/user/1000
/dev/sdb1                2.0G   33M  2.0G   2% /backup
[hero@centos ~]$
```

#### 2.7. Verify that after reboot your root device is still 1GB bigger than at 2.5.
```bash
[hero@centos ~]$ df -h
Filesystem               Size  Used Avail Use% Mounted on
devtmpfs                 898M     0  898M   0% /dev
tmpfs                    910M     0  910M   0% /dev/shm
tmpfs                    910M  9.5M  901M   2% /run
tmpfs                    910M     0  910M   0% /sys/fs/cgroup
/dev/mapper/centos-root  9.0G  1.4G  7.7G  16% /
/dev/sdb1                2.0G   33M  2.0G   2% /backup
/dev/sda1               1014M  150M  865M  15% /boot
tmpfs                    182M     0  182M   0% /run/user/1000
```
