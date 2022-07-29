---
title: "Volley Your Files From One Computer to Another"
date: 2022-07-28T10:10:00-04:00
draft: false
categories:
- Articles
tags:
- MX-Linux
- Fedora
- terminal
---

![Volleyball with scp and sftp being hit header graphic](/img/scp-volley-header.jpg)

# It's Magical 

The ability to transfer files from one computer to another on my home network using `scp` felt magical when I first got into Linux. I had been using *"sneaker net"*. In those days, *"sneaker net"* meant putting the file on a 3.5" floppy and walking the floppy disk across the house into the room where the other computer was located. Before I started running Linux on old computers, I never had a network of computers. Once I had networked two Linux computers that I could `ssh` between, this new world of networking fed my computer geek love.

# A Flaw

On August 8th, 2018 Harry Sintonen working for F-Secure Corporation discovered the first vulnerabilities with the transfer protocol used by `scp`. Although it creates compatibility bugs and issues to use a different transfer protocol, `scp` can be used with the well tested and secure protocol behind `sftp`. After these vulnerabilities were discovered, the team behind **OpenSSH** determined that the original protocol had too much technical debt and too many issues to attempt fixing the original protocol. At first, the encouragement came from the **OpenSSH** developers to just stop using `scp` and instead use `sftp`, `rsync`, or some other program that securely transfers files from one computer to another.

# The Fix

Yes, in the world of free and open source software, we have plenty of secure options for transferring our files from one computer to another, `scp` is a useful tool that is probably included in a number of sysadmin scripts and engrained into the muscle memory of a number of Linux users. Red Hat decided to patch their builds of **OpenSSH**. Their patch included in all their builds of 8.7 and above make the default `scp` protocol `sftp` instead of its original and now discovered insecure protocol.

If you are using a Red Hat, CentOS, or Fedora distribution that is using **OpenSSH 8.7** or above, than you can use `scp` without concern about it being insecure. On Fedora 36, I am running **OpenSSH 8.8p** which has the Red Hat patch installed.

**OpenSSH** decided to adopt the Red Hat patch into their mainline stable edition as of version 9.0 which was released in April of 2022. As this version makes its way into the repos of your preferred distribution, your version of `scp` will also use the `sftp` protocol as its default as well. If you run into one of the compatibility bugs, you will be able to use the flag `scp -O` to use the *"original"* protocol which is know to have vulnerabilities that are not fixed.

Besides using Fedora as my main desktop at home, and as my server OS in my home lab, I also have two workstations running MX Linux, Fluxbox Edition, and a Debian stable server at work. From my research these systems which are all built from Debian stable are using the unpatched version of **OpenSSH**, version 8.4p. Therefore, on those systems it would be advisable to use `sftp` directly instead of `scp`.

# Rediscovering the Magic of scp and sftp

If you can `ssh` into your remote computer or a computer on your LAN, you can use `sftp` and `scp`. Here is a handy cheat sheet for `sftp`.

## Cheat sheet for sftp

### Connect to a remote server and enter an interactive command mode:

    sftp remote_user@remote_host

### Connect using an alternate port:

    sftp -P remote_port remote_user@remote_host

### Connect using a predefined host (in `~/.ssh/config`):

    sftp host

### Transfer remote file to the local system:

    get /path/remote_file

### Transfer local file to the remote system:

    put /path/local_file

### Transfer remote directory to the local system recursively (works with `put` too):

    get -R /path/remote_directory

### Get list of files on local machine:

    lls

### Get list of files on remote machine:

    ls

`sftp` allows you to engage with your local and your remote file system interactively. As you can see above, you can `ls` your remote file system or you can change directories too with the common `cd` command. To view the files on your local computer while you are connected via `sftp` you need to us `lls` for "local list files" and `lcd` for "local change directory." For most users `sftp` provides a more powerful and useful experience. Since I have all of my remote computers that I ssh into configured in my `~/.ssh/config` file it feels super easy to either `put` files from my local computer to my remote computer, or `get` files from my remote computer to my local computer.

Unlike `sftp`, `scp` is a utility that simply lets you copy files from one computer to another, but you can't interact with the file system on other computer. You must simply know that path and file names that you desire to transfer from one computer to another. Once again, having your remote computers configured in your `~/.ssh/config` file will save you from some typing mistakes.

## Cheat sheet scp 

### Basic Syntax to Grab a File from a Remote Computer to the current-working-directory on your Local Computer.

- By default here, port 22 is used, or whichever port is otherwise configured for SSH.

    scp remote_user@remote_host:/path/remote_file ./

### Copy a File from Local Computer to Remote Computer

    scp local_file remote_user@remote_host:/path/remote_directory

### Like `sftp` You Can Use SSH Aliases Defined in `~/.ssh/config` File.

- Additionally you have to specify in `scp` the destination directory, which in the example below is the current-working-directory.

    scp ssh_alias:/path/remote_file ./

### Unlike `sftp` You Can Use `scp` to Copy Files Between Two Remote Computers

If you would like a config file that is on one of your remote computers copied to another remote computer, you can use `scp` to make that file transfer happen from your local computer without ever using `ssh` to log into either of those remote computers. Consider the example below.

    scp ssh_alias1:/path/remote_file ssh_alias2:/path/remote_directory

- The above only works if you have exchanged ssh keys between the two remote machines, since `scp` can't ask for passwords or passphrases between the two remote machines.

    scp -3 ssh_alias1:/path/remote_file ssh_alias2:/path/remote_directory

- Adding the "-3" flag enables you to pass a file between the two remote computers through your local computer. 

# Just Another Tool in the Toolbox

If you read other articles in this blog you know that I don't depend on `scp` and `sftp` to do all of my file transfers. I definitely need to do an article about `rsync` which gets used everyday in my home lab. I also use `git` or `git` in combination with the bash script `yadm` to sync all of my configuration files between the computers on my home and work networks. Sometimes, it is great to remember that you have `scp` and `sftp` at your finger tips because you more than likely have `ssh` installed on your computers. Also, users of Fedora and the Red Hat family of distros can feel safe using `scp` because of their patched version of **OpenSSH**, and soon everyone will be using **OpenSSH 9.0** or above as well. Since my file transfers happen between my home and work networks that are connected by a VPN, I'm not concerned with using `scp` on my Debian systems either since the traffic is going through my encrypted Wireguard tunnel. The beauty of Free and Open Source Software is often the number of solutions that are available to use, but that can also be challenging to determine which solution is the best as well.

*Photos used to create the header graphic came from [Unsplash photographer Angelo Pantazis](https://unsplash.com/@angelopantazis?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText") for the Volleyball player photo, and [Unsplash photographer Chandan Chaurasia](https://unsplash.com/@chaurasia?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText") for the volleyball photo.*

