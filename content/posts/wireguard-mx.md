---
title: "MX Linux as Wireguard Client"
date: 2022-01-02T18:45:48-04:00
draft: false
categories:
- Tutorials
tags:
- vpn
- terminal
- MX-Linux
- Fedora
- Wireguard
---

![Wireguard Logo on top of MX Logo](/img/mx-wireguard-header.png)

In my previous post, I shared the excitement of getting a Wireguard VPN set up on a 1st Generation Raspberry Pi. At that point, I had only set up my main Linux system at home, my Fedora 35 system, as a Wireguard client to connect to the RPi Wireguard server. You can read about the configuration methods I went through by reading [Wrangle Dotfiles Round 2.0]({{< ref "/yadm-02" >}} "Wrangle Dotfiles Round 2.0") to get my Fedora 35 system connected to the Wireguard VPN.

I assumed that the same configuration methods would work with my secondary home system, an older laptop running MX Linux 21 Fluxbox edition, because it also uses Network Manager to control your network interfaces and connections. However, when I attempted to simply repeat the process that worked with my Fedora 35 system, I ran into the following issues.

* When I first used the command `nmcli connection import` I had a connection to the VPN tunnel, and I could ping the RPi, but I had no connection to the outside Internet.
* When I rebooted, I had no connection to the Internet or to the RPi through the VPN tunnel even though Network Manager reported that I had connection to the home network wifi and that the Wireguard VPN tunnel was on and active.

## First, SystemD

Since the exact same configuration with Network Manager had worked successfully on Fedora 35, I considered what might be different between my Fedora 35 system and my MX-21 system. The most obvious difference was the fact that I was using the default Init system in MX-21 which uses **SysV** instead of **SystemD**. However, this is an easy fix. When I rebooted MX-21 Fluxbox Edition, I chose the latest kernel and SystemD as my boot option. By running `systemctl status` in a terminal, you can see that SystemD is running as the active Init system.

Okay, now that I'm booted with SystemD running, I once again did `nmcli connection import` command, and this time everything worked as expected. I could ssh into the RPi hosting the Wireguard VPN tunnel on my work network. I could surf the broader Internet using the local network connection.

I rebooted, and checked all of my connections again. Unfortunately, I could not surf the broader Internet, nor could I ssh into my RPi on my work network. So neither the local connection to the Internet nor my VPN tunnel were functioning even though they were both clearly connected according to Network Manager.

Changing to SystemD was only part of the solution.

## Second, Configure Network Manager To Use Openresolv

After a few failed attempts, one Internet search brought me to a [post on the Arch forums](https://bbs.archlinux.org/viewtopic.php?id=240481). The person making the forum post had the same issue that I had after rebooting. The suggested fix was to reconfigure Network Manager to use openresolv by following these steps on MX-Linux.

1. `apt install openresolv`
2. Create the following file `/etc/NetworkManager/conf.d/rc-manager.conf`

```
[main]
rc-manager=resolvconf
```

After doing those steps to configure Network Manager to use `openresolv` I could reboot, and all of my connections in Network Manager would work as expected. The VPN tunnel was active and all the systems that I wanted to access through that tunnel were reachable. I could surf on the broader Internet using my local network connection.

## A Few Lingering Questions

I would imagine that after additional research, I will discover the answer to the following questions. Although everything is now working on MX-Linux as I hoped, I still am unsure of a few things.

1. Does Wireguard require SystemD?

In the documentation that have read so far, I haven't found anything to suggest that SystemD is a requirement for Wireguard, but I do recognize that other technologies in Linux have made SystemD a required dependency, so perhaps Wireguard has done this as well. Snapd from Canonical is an example of a technology that depends on SystemD. I have no horse in the race that is the debate on whether to use SystemD verses another Init system. MX Linux uses SysV to support their unique LiveUSB creation scripts, but offers easy ways to switch to using SystemD as your default Init system in MX, which it looks like I will be doing for the foreseeable future.

2. Why does Fedora 35 work with the configuration outlined in my previous article?

I decided to do a little investigation after I found this solution for running MX Linux as a client to my Wireguard server on my RPi. I thought that I would discover that Fedora has configured Network Manager to run `openresolv`. However, `openresolv` was not even installed on my Fedora 35 system. The `resolvconf` command is installed on my Fedora system. There is no `/etc/NetworkManager/conf.d/rc-manager.conf` file on my Fedora 35 system. Since `resolvconf` was not on my MX-Linux system, it is possible that on Fedora it is using resolvconf to manager the `/etc/resolv.conf` file while MX-Linux was allowing Network Manager to control `/etc/resolv.conf` using its own default methods.


