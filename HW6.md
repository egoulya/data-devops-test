# Homework

## Task 1

### remotehost - 18.221.144.175 (public IP)
### webserver - 172.31.45.237 (private IP)

#### 1.1. SSH to remotehost using username and password provided to you in Slack. Log out from remotehost.

```bash
[hero@HeroWithin ~]$ ssh Egor_Ermolaev@18.221.144.175
Egor_Ermolaev@18.221.144.175's password:
Last login: Thu Dec 23 20:25:15 2021 from 91.238.229.3

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
No packages needed for security; 4 packages available
Run "sudo yum update" to apply all updates.
[Egor_Ermolaev@ip-172-31-33-155 ~]$ exit
logout
Connection to 18.221.144.175 closed.
```

#### 1.2. Generate new SSH key-pair on your localhost with name "hw-5" (keys should be created in ~/.ssh folder).

```bash
[hero@HeroWithin ~]$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/hero/.ssh/id_rsa): hw-5
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in hw-5.
Your public key has been saved in hw-5.pub.
The key fingerprint is:
SHA256:Jkj8Jz8dWyh4NpnCFu0RsUvK9pdpg633UctzTNW8l1U hero@HeroWithin
The key's randomart image is:
+---[RSA 2048]----+
|        o.      E|
|   .   . o     .o|
|    o . =       =|
|   . = * = .    =|
|    . % S o . .oo|
|     o @ * * o +.|
|        = X . + o|
|         =.. . o |
|        .. ..    |
+----[SHA256]-----+
```

#### 1.3. Set up key-based authentication, so that you can SSH to remotehost without password.

```bash
ssh-copy-id -i ~/.ssh/hw-5.pub Egor_Ermolaev@18.221.144.175
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/hero/.ssh/hw-5.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
Egor_Ermolaev@18.221.144.175's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'Egor_Ermolaev@18.221.144.175'"
and check to make sure that only the key(s) you wanted were added.
```

#### 1.4. SSH to remotehost without password. Log out from remotehost.

```bash
[hero@HeroWithin ~]$ ssh -i .ssh/hw-5 Egor_Ermolaev@18.221.144.175
Last login: Thu Dec 23 20:29:02 2021 from 91.238.229.3

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
No packages needed for security; 4 packages available
Run "sudo yum update" to apply all updates.
[Egor_Ermolaev@ip-172-31-33-155 ~]$
```

#### 1.5. Create SSH config file, so that you can SSH to remotehost simply running `ssh remotehost` command. As a result, provide output of command `cat ~/.ssh/config`.

```bash
[hero@HeroWithin ~]$ nano .ssh/config
Host remotehost
        Hostname 18.221.144.175
        User Egor_Ermolaev
        IdentityFile ~/.ssh/hw-5
[hero@HeroWithin ~]$ sudo chmod 644 .ssh/config
[hero@HeroWithin ~]$ ssh remotehost
Last login: Thu Dec 23 20:29:48 2021 from 91.238.229.3

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/
No packages needed for security; 4 packages available
Run "sudo yum update" to apply all updates.
[Egor_Ermolaev@ip-172-31-33-155 ~]$
```

#### 1.6. Using command line utility (curl or telnet) verify that there are some webserver running on port 80 of webserver.  Notice that webserver has a private network IP, so you can access it only from the same network (when you are on remotehost that runs in the same private network). Log out from remotehost.

```bash
[Egor_Ermolaev@ip-172-31-33-155 ~]$ curl 172.31.45.237:80
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"><html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
                <title>Apache HTTP Server Test Page powered by CentOS</title>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <!-- Bootstrap -->
    <link href="/noindex/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="noindex/css/open-sans.css" type="text/css" />

<style type="text/css"><!--

body {
  font-family: "Open Sans", Helvetica, sans-serif;
  font-weight: 100;
  color: #ccc;
  background: rgba(10, 24, 55, 1);
  font-size: 16px;
}

h2, h3, h4 {
  font-weight: 200;
}

h2 {
  font-size: 28px;
}

.jumbotron {
  margin-bottom: 0;
  color: #333;
  background: rgb(212,212,221); /* Old browsers */
  background: radial-gradient(ellipse at center top, rgba(255,255,255,1) 0%,rgba(174,174,183,1) 100%); /* W3C */
}

.jumbotron h1 {
  font-size: 128px;
  font-weight: 700;
  color: white;
  text-shadow: 0px 2px 0px #abc,
               0px 4px 10px rgba(0,0,0,0.15),
               0px 5px 2px rgba(0,0,0,0.1),
               0px 6px 30px rgba(0,0,0,0.1);
}

.jumbotron p {
  font-size: 28px;
  font-weight: 100;
}

.main {
   background: white;
   color: #234;
   border-top: 1px solid rgba(0,0,0,0.12);
   padding-top: 30px;
   padding-bottom: 40px;
}

.footer {
   border-top: 1px solid rgba(255,255,255,0.2);
   padding-top: 30px;
}

    --></style>
</head>
<body>
  <div class="jumbotron text-center">
    <div class="container">
          <h1>Hello!</h1>
                <p class="lead">You are here because you're probably a DevOps courses member. In that case you should open <a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ"> THIS LINK </a></p>
                </div>
  </div>
</body></html>
```

#### 1.7. Using SSH setup port forwarding, so that you can reach webserver from your localhost (choose any free local port you like).

```bash
[hero@HeroWithin ~]$ ssh -f -N -L 5800:172.31.45.237:80 remotehost
```

#### 1.8 Like in 1.6, but on localhost using command line utility verify that localhost and port you have specified act like webserver, returning same result as in 1.6.

```bash
[hero@HeroWithin ~]$ curl http://localhost:5800
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"><html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
                <title>Apache HTTP Server Test Page powered by CentOS</title>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <!-- Bootstrap -->
    <link href="/noindex/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="noindex/css/open-sans.css" type="text/css" />

<style type="text/css"><!--

body {
  font-family: "Open Sans", Helvetica, sans-serif;
  font-weight: 100;
  color: #ccc;
  background: rgba(10, 24, 55, 1);
  font-size: 16px;
}

h2, h3, h4 {
  font-weight: 200;
}

h2 {
  font-size: 28px;
}

.jumbotron {
  margin-bottom: 0;
  color: #333;
  background: rgb(212,212,221); /* Old browsers */
  background: radial-gradient(ellipse at center top, rgba(255,255,255,1) 0%,rgba(174,174,183,1) 100%); /* W3C */
}

.jumbotron h1 {
  font-size: 128px;
  font-weight: 700;
  color: white;
  text-shadow: 0px 2px 0px #abc,
               0px 4px 10px rgba(0,0,0,0.15),
               0px 5px 2px rgba(0,0,0,0.1),
               0px 6px 30px rgba(0,0,0,0.1);
}

.jumbotron p {
  font-size: 28px;
  font-weight: 100;
}

.main {
   background: white;
   color: #234;
   border-top: 1px solid rgba(0,0,0,0.12);
   padding-top: 30px;
   padding-bottom: 40px;
}

.footer {
   border-top: 1px solid rgba(255,255,255,0.2);
   padding-top: 30px;
}

    --></style>
</head>
<body>
  <div class="jumbotron text-center">
    <div class="container">
          <h1>Hello!</h1>
                <p class="lead">You are here because you're probably a DevOps courses member. In that case you should open <a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ"> THIS LINK </a></p>
                </div>
  </div>
</body></html>
```

## Task 2

#### 2.1. Imagine your localhost has been relocated to Havana. Change the time zone on the localhost to Havana and verify the time zone has been changed properly (may be multiple commands).

```bash
[hero@centos ~]$ timedatectl list-timezones | grep Havana
America/Havana
[hero@centos ~]$ date
Fri Dec 24 02:44:39 MSK 2021
[hero@centos ~]$ timedatectl set-timezone America/Havana
==== AUTHENTICATING FOR org.freedesktop.timedate1.set-timezone ===
Authentication is required to set the system timezone.
Authenticating as: hero
Password:
==== AUTHENTICATION COMPLETE ===
[hero@centos ~]$ ls -l /etc/localtime
ls -l /etc/localtime
lrwxrwxrwx. 1 root root 36 Dec 23 18:44 /etc/localtime -> ../usr/share/zoneinfo/America/Havana
[hero@centos ~]$ date
Thu Dec 23 18:45:03 CST 2[hero@centos ~]$

[hero@centos ~]$ timedatectl status
      Local time: Thu 2021-12-23 18:45:20 CST
  Universal time: Thu 2021-12-23 23:45:20 UTC
        RTC time: Thu 2021-12-23 23:45:20
       Time zone: America/Havana (CST, -0500)
     NTP enabled: n/a
NTP synchronized: no
 RTC in local TZ: no
      DST active: no
 Last DST change: DST ended at
                  Sun 2021-11-07 00:59:59 CDT
                  Sun 2021-11-07 00:00:00 CST
 Next DST change: DST begins (the clock jumps one hour forward) at
                  Sat 2022-03-12 23:59:59 CST
                  Sun 2022-03-13 01:00:00 CDT
[hero@centos ~]$
```

#### 2.2. Find all systemd journal messages on localhost, that were recorded in the last 50 minutes and originate from a system service started with user id 81 (single command).

```bash
[hero@centos ~]$ journalctl _UID=81 --since "50 minutes ago"
-- Logs begin at Thu 2021-12-23 18:40:16 CST, end at Thu 2021-12-23 18:44:51 CST. --
Dec 23 18:40:26 centos dbus[671]: [system] Activating via systemd: service name='org.freedeskt
Dec 23 18:40:27 centos dbus[671]: [system] Successfully activated service 'org.freedesktop.hos
Dec 23 18:40:27 centos dbus[671]: [system] Activating via systemd: service name='org.freedeskt
Dec 23 18:40:27 centos dbus[671]: [system] Successfully activated service 'org.freedesktop.nm_
Dec 23 18:44:47 centos dbus[671]: [system] Activating via systemd: service name='org.freedeskt
Dec 23 18:44:47 centos dbus[671]: [system] Successfully activated service 'org.freedesktop.tim
```

#### 2.3. Configure rsyslogd by adding a rule to the newly created configuration file /etc/rsyslog.d/auth-errors.conf to log all security and authentication messages with the priority alert and higher to the /var/log/auth-errors file. Test the newly added log directive with the logger command (multiple commands).

```bash
[hero@centos ~]$ cd /var/log/
[hero@centos log]$ sudo touch auth-errors
[hero@centos log]$ cd /etc/rsyslog.d/
[hero@centos rsyslog.d]$ sudo nano auth-errors.conf
[hero@centos rsyslog.d]$ systemctl restart rsyslog
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
Authentication is required to manage system services or units.
Authenticating as: hero
Password:
==== AUTHENTICATION COMPLETE ===
[hero@centos rsyslog.d]$ logger -p authpriv.alert log
[hero@centos rsyslog.d]$ tail -5 /var/log/auth-errors
Dec 23 18:59:50 centos hero: log
```
