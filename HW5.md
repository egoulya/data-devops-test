# Processes

# 1. Run a sleep command three times at different intervals

```bash
[hero@HeroWithin ch5]$ sleep 10000 &
[1] 27

[hero@HeroWithin ch5]$ sleep 20000 &
[2] 28

[hero@HeroWithin ch5]$ sleep 50000 &
[3] 29
```

# 2. Send a SIGSTOP signal to all of them in three different ways.

```bash
[hero@HeroWithin ch5]$ kill -20 27

[1]+  Stopped                 sleep 10000

[hero@HeroWithin ch5]$ kill -SIGSTOP 28

[2]+  Stopped                 sleep 20000

[hero@HeroWithin ch5]$ fg %3
sleep 50000
^Z
[3]+  Stopped                 sleep 50000
```

# 3. Check their statuses with a job command

```bash
[hero@HeroWithin ch5]$ jobs
[1]   Stopped                 sleep 10000
[2]-  Stopped                 sleep 20000
[3]+  Stopped                 sleep 50000
```

# 4. Terminate one of them. (Any)

```bash
[hero@HeroWithin ch5]$ kill %1

[hero@HeroWithin ch5]$ jobs
[1]   Terminated              sleep 10000
[2]-  Stopped                 sleep 20000
[3]+  Stopped                 sleep 50000
```

# 5. To other send a SIGCONT in two different ways.

```bash
[hero@HeroWithin ch5]$ kill -18 %2

[hero@HeroWithin ch5]$ kill -SIGCONT 29

[hero@HeroWithin ch5]$ jobs
[2]-  Running                 sleep 20000 &
[3]+  Running                 sleep 50000 &
```

# 6. Kill one by PID and the second one by job ID

```bash
[hero@HeroWithin ch5]$ kill 28
[2]-  Terminated              sleep 20000

[hero@HeroWithin ch5]$ kill %3
[3]+  Terminated              sleep 50000
```

# systemd

# 1. Write two daemons: one should be a simple daemon and do sleep 10 after a start and then do echo 1 > /tmp/homework, the second one should be oneshot and do echo 2 > /tmp/homework without any sleep

```bash
[hero@HeroWithin ch5]$ nano firstdaemon.sh

[hero@HeroWithin ch5]$ nano seconddaemon.sh

[hero@HeroWithin ch5]$ sudo nano /etc/systemd/system/firstdaemon.service
[Unit]
Description=First daemon
[Service]
ExecStart=/home/hero/ch5/firstdaemon.sh

[hero@HeroWithin ch5]$ sudo nano /etc/systemd/system/seconddaemon.service
[Unit]
Description=Second daemon
[Service]
Type=oneshot
ExecStart=/home/hero/ch5/seconddaemon.sh
```

# 2. Make the second depended on the first one (should start only after the first)

```bash
[hero@HeroWithin ch5]$ sudo nano /etc/systemd/system/seconddaemon.service
[Unit]
Description=Second daemon
Requires=firstdaemon.service
After=firstdaemon.service
[Service]
Type=oneshot
ExecStart=/home/hero/ch5/seconddaemon.sh
```

# 3. Write a timer for the second one and configure it to run on 01.01.2019 at 00:00

```bash
[hero@HeroWithin ch5]$ sudo nano /etc/systemd/system/seconddaemon.timer
[Unit]
Description=Timer for the seconddaemon.service
[Timer]
OnCalendar=2019-01-01 00:00
Persistent=true
```

# 4. Start all daemons and timer, check their statuses, timer list and /tmp/homework

```bash
[hero@centos ch5]$ sudo systemctl start firstdaemon.service

[hero@centos ch5]$ sudo systemctl start seconddaemon.service

[hero@centos ch5]$ sudo systemctl start seconddaemon.timer

[hero@centos ch5]$ sudo systemctl status firstdaemon.service
● firstdaemon.service - First daemon
   Loaded: loaded (/etc/systemd/system/firstdaemon.service; static; vendor preset: disabled)
   Active: inactive (dead) since Sun 2021-12-19 02:48:56 MSK; 5s ago
  Process: 1992 ExecStart=/home/hero/ch5/firstdaemon.sh (code=exited, status=0/SUCCESS)
 Main PID: 1992 (code=exited, status=0/SUCCESS)

Dec 19 02:48:46 centos systemd[1]: Started First daemon.

[hero@centos ch5]$ sudo systemctl status seconddaemon.service
● seconddaemon.service - Second daemon
   Loaded: loaded (/etc/systemd/system/seconddaemon.service; static; vendor preset: disabled)
   Active: inactive (dead) since Sun 2021-12-19 02:48:48 MSK; 24s ago
  Process: 2002 ExecStart=/home/hero/ch5/seconddaemon.sh (code=exited, status=0/SUCCESS)
 Main PID: 2002 (code=exited, status=0/SUCCESS)

Dec 19 02:48:48 centos systemd[1]: Starting Second daemon...
Dec 19 02:48:48 centos systemd[1]: Started Second daemon.

[hero@centos ch5]$ sudo systemctl status seconddaemon.timer
● seconddaemon.timer - Timer for the seconddaemon.service
   Loaded: loaded (/etc/systemd/system/seconddaemon.timer; static; vendor preset: disabled)
   Active: active (elapsed) since Sun 2021-12-19 02:42:51 MSK; 6min ago

Dec 19 02:42:51 centos systemd[1]: Started Timer for the seconddaemon.service.

[hero@centos ch5]$ cat /tmp/homework
1
```

# 5. Stop all daemons and timer

```bash
[hero@centos ch5]$ sudo systemctl stop firstdaemon.service
[hero@centos ch5]$ sudo systemctl stop seconddaemon.service
Warning: Stopping seconddaemon.service, but it can still be activated by:
  seconddaemon.timer
[hero@centos ch5]$ sudo systemctl stop seconddaemon.timer
```

# cron/anacron

# 1. Create an anacron job which executes a script with echo Hello > /opt/hello and runs every 2 days

```bash
[hero@centos ch5]$ nano hello.sh
#!/bin/bash

echo Hello > /opt/hello

[hero@centos ch5]$ sudo vi /etc/anacrontab

# /etc/anacrontab: configuration file for anacron

# See anacron(8) and anacrontab(5) for details.

SHELL=/bin/sh
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
# the maximal random delay added to the base delay of the jobs
RANDOM_DELAY=45
# the jobs will be started during the following hours only
START_HOURS_RANGE=3-22

#period in days   delay in minutes   job-identifier   command
1       5       cron.daily              nice run-parts /etc/cron.daily
7       25      cron.weekly             nice run-parts /etc/cron.weekly
@monthly 45     cron.monthly            nice run-parts /etc/cron.monthly
2       0       hello.anacron           /bin/bash /home/hero/ch5/hello.sh
```

# 2. Create a cron job which executes the same command (will be better to create a script for this) and runs it in 1 minute after system boot.

```bash
[hero@centos ch5]$ sudo crontab -e

@reboot root sleep 60 && /home/hero/ch5/hello.sh
```

# 3. Restart your virtual machine and check previous job proper execution

```bash
[hero@centos ch5]$ sudo reboot
[hero@centos ch5]$ cat /opt/hello
Hello
```

# lsof

# 1. Run a sleep command, redirect stdout and stderr into two different files (both of them will be empty).


```bash
[hero@centos ch5]$ sleep 10000 1>output 2>errors &
[1] 2081
```

# 2. Find with the lsof command which files this process uses, also find from which file it gain stdin.

```bash
[hero@centos ch5]$ lsof -p 2081
COMMAND  PID USER   FD   TYPE DEVICE  SIZE/OFF     NODE NAME
sleep   2081 hero  cwd    DIR  253,0       109  8435755 /home/hero/ch5
sleep   2081 hero  rtd    DIR  253,0       224       64 /
sleep   2081 hero  txt    REG  253,0     33128 12692466 /usr/bin/sleep
sleep   2081 hero  mem    REG  253,0 106172832 12799787 /usr/lib/locale/locale-archive
sleep   2081 hero  mem    REG  253,0   2156272    15673 /usr/lib64/libc-2.17.so
sleep   2081 hero  mem    REG  253,0    163312    15666 /usr/lib64/ld-2.17.so
sleep   2081 hero    0u   CHR  136,0       0t0        3 /dev/pts/0
sleep   2081 hero    1w   REG  253,0         0  8435758 /home/hero/ch5/output
sleep   2081 hero    2w   REG  253,0         0  8435759 /home/hero/ch5/errors
```

# 3. List all ESTABLISHED TCP connections ONLY with lsof

```bash
lsof -i TCP -s TCP:ESTABLISHED
```
