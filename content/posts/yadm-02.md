---
title: "Wrangle Dotfiles Round 2.0"
date: 2021-12-23T14:50:48-04:00
draft: false
categories:
- Articles
- Tutorials
tags:
- dotfiles
- yadm
- vpn
- terminal
- git
---

![Wrangling dotfiles header graphic](/img/yadm-wrangle.png)

How do these technologies fit together?

* 1st Generation Raspberry Pi B with 512mb of RAM
* Wireguard VPN
* Git
* Bash "if then elif fi"
* yadm

I gave away the answer with this article's title. Using these technologies, I have taken dotfile management to the next level. This technology stack is how I implemented the 2.0 version of dotfile management. If you want to read about my version 1.0 adventure, you can read [Wrangle Dotfiles with Yadm]({{< ref "/yadm-01" >}} "Wrangle Dotfiles with Yadm"). I'm excited to share the 2.0 version with you. Come and discover how I have been spending my time in the Linux CLI.

## Raspberry Pi 1 B

![Picture of Raspberry Pi 1 B](/img/rpi1b.jpg)

Released in February 2012, it became the first mainstream RPi, and it was the first RPi in my home. Its CPU runs at 700mhz with 512mb of RAM. This model only had two USB ports next to the ethernet port and a 26 pin GPIO. Later models added two additional USB ports and a 40 pin GPIO among other improvements. It doesn't have wifi or bluetooth. Yet, 4 and 1/2 years ago my son learned how to program in C++ on this RPi. Since the GUI was slow and limited on those specs, he fell in love with the Linux CLI and vim as his text editor. My son has moved onto a Dell refurbished laptop and desktops that we salvaged from schools and a library that no longer of had uses for them. In fact, the vast majority of computer hardware that he and I run Linux on are what most people would consider e-waste. We have been able to give this hardware a second life in our homelab. This old RPi sat in a pile of unused hardware, and I wanted to find a way to give it purpose. First, I practiced setting it up as a secured headless server by applying the principles that I had learned from my Linux server research. I applied those lessons to a Debian server that I set up at work that runs a web based CRM on the work Intranet with no access on the public Internet. Because the RPi sips power, I decided to use the RPi as my network device that would wake on lan the Debian server so that it wasn't on all of the time, but only when I needed it running. This worked great, but what else could I do with a RPi that was on all the time on my work network?

As I examined my computer collection I realized that I had the following Linux systems that I used regularly at work and home.

* **Home:** Main System ("Half Top" the bottom half of an HP Envy 17" Laptop that had a broken screen that I removed, and hooked up to a new 32" monitor through the HDMI port. This system has the best specs with an i7-7500U CPU, Nvidia GeForce 940MX, 16GB of RAM, and an upgraded 512GB SSD.) running Fedora 35 Workstation.
* **Home:** Home Storage Server (Repurposed tower with the same motherboard, RAM, and power supply as mentioned in this [article about a recycled workstation build]({{< ref "/recycled-workstation" >}} "Recycled Workstation Build")) running Fedora 35 Server which is on just for backups.
* **Home:** Old HP DV4 "Entertainment" Laptop running MX Linux 21, Fluxbox Edition. This is my vacation laptop. It doesn't get a lot of use, but I like to have it mirror my recycled workstation at work with my standing desk.
* **Work:** 8 Year Old Toshiba Laptop running Windows 10 and Ubuntu LTS in WSL 2. I have a new system on order for work, but it hasn't arrived yet.
* **Work:** 11-12 Year Old Toshiba Laptop running Ubuntu Mate LTS and is hooked up to a projector for presentations.
* **Work:** 11-12 Year Old Toshiba Laptop (twin of one above) running Debian and acting as my server that runs the web based CRM that I mentioned earlier.
* **Work:** [The Recycled Workstation]({{< ref "/recycled-workstation" >}} "Recycled Workstation Build") at my standing desk running MX Linux 21, the Fluxbox Edition.
* **Work:** Raspberry Pi 1 B

Besides the Ubuntu Mate laptop that is attached to the projector, I like to have similar configurations on my systems. I like to have the same `.vimrc` and `.bashrc`. I also have been using ROXterm (see [ROXterm a Full Featured Terminal]({{< ref "/roxterm" >}} "ROXterm a Full Featured Terminal") for more details), and I appreciate having the same configurations available on all of my systems for my terminal emulator. The last time I wrangled my dotfiles it was mostly so I could keep my two computers that were running MX Linux Fluxbox in sync with each other. I wanted the same keyboard shortcuts in both of my Fluxbox environments. I had planned to add my Fedora system into the mix, but it runs Gnome, and Fedora does things a bit differently than Debian, so I never figured out how I could bring those two worlds together until recently.

I'm trying to learn bash scripting, but I'm moving at a snail's pace. Now with the 2.0 version of managing my dotfiles, I had some motivation to dive back into learning bash scripting. Little did I realize that I wouldn't even need to leave the kiddie pool of bash scripting to accomplish what I wanted to do with my 2.0 version of dotfiles. I had the following goals with the 2.0 version of dotfile management.

1. Unify my configuration files so that I could have one system that would work on Fedora, MX, Debian, Raspberry Pi OS, and even Ubuntu running on WSL. Since four out of those five are Debian based that should make things easier.
2. Move my dotfiles off of GitHub. Yes, it is fun to show off your dotfiles on GitHub, but I always feared that I would accidentally send a file with secrets (keys or passwords) up to the GitHub repo. I was not confident in my "git fu" that I would be able to reverse the damage that was done. So to be on the safe side, I wanted my git repo to stay on one of my local networks at home or work.
3. Securely connect my home and work networks together. A VPN seemed to be the best solution, but I wasn't sure how I would accomplish this part of the puzzle. I'm doing some major network upgrades at work, so I contemplated waiting till I had the new equipment in place, but with the current climate of back orders and part shortages, I decided to try to use tools that I already had. As I thought about this, I remembered my RPi 1 B.

## Wireguard VPN on Bullseye Raspberry Pi OS with PiVPN

I had heard great things about *Wireguard* and *VPN's*, but I had never set one up, and I had no idea if the RPi 1 B could handle being my VPN connection point on my work network. It was time to install a fresh version of Raspberry Pi OS since the Bullseye version had come out at the end of October 2021. I wiped the SD card, installed the latest version of Raspberry Pi OS Lite, Bullseye Edition. I did my RPi hardening that I have done in the past to make the RPi more secure. Then I followed this [tutorial on PiMyLifeUp](https://pimylifeup.com/raspberry-pi-wireguard/) to install PiVPN and Wireguard. Following this tutorial, I created my Wireguard client configuration files for my home systems, but then I got stuck when I tried to use these configuration files on my home systems.

Although, Network Manager (the Linux utility that most distros use to access and control the system's network interfaces) supports Wireguard, graphical user interfaces to control and configure Wireguard connections are lagging behind on Linux. As an example, it is easy to import an OpenVPN configuration file in Gnome on Fedora 35, but the GUI in Gnome 41 doesn't recognize Wireguard configuration files. The Wireguard community has developed robust CLI's to control and configure Wireguard tunnels. This makes it possible to create scripts that can bring up and take down your Wireguard VPN easily. I wanted to take advantage of Network Manager's support of Wireguard. Network Manager sees a Wireguard connection as if it is just a physical network interface, and it creates a profile for the Wireguard VPN that enables it to easily reconnect to the Wireguard VPN tunnel after reboots of the system. [Thomas Haller's blog](https://blogs.gnome.org/thaller/2019/03/15/wireguard-in-networkmanager/) helped me use the Wireguard configuration files that I created using PiVPN to connect my Fedora 35 system to the Wireguard VPN tunnel. Thomas explains how you can use the Network Manager CLI utility, `nmcli`, to set up the Wireguard interface and create the encrypted tunnel with the computer on the other network that is running Wireguard.

1. Run the following command to use the Wireguard ".conf" file to set up the Wireguard interface in Network Manager.

```
nmcli connection import type wireguard file "$CONF_FILE"
```

2. After running the above command, I discovered that Network Manger not only created the Wireguard interface and profile, but it had also connected me to the Wireguard VPN tunnel.
3. I soon discovered that my Wireguard configuration was not exactly what I wanted, so I found that the easiest way to make changes to the configuration, was to first delete the Wireguard interface and profile created by Network Manager with this command.

```
nmcli connection delete "$NAMEOFCONNECTION"
```
4. Then I would make my configuration changes to the Wireguard ".conf" file, and simply rerun the `nmcli connection import` command again and test the new connection.

Below is an example of what the Wireguard ".conf" file might look like that PiVPN creates for you depending on the options you choose during the setup of PiVPN.

```
[Interface]
PrivateKey = $UNIQUE_PrivateKey
Address = 10.10.10.4/24
DNS = 9.9.9.9, 149.112.112.112

[Peer]
PublicKey = $UNIQUE_PublicKey
PresharedKey = $UNIQUE_PresharedKey
Endpoint = your.publicipORpersonaldomainpointingtopublicip.me:$PORTNUMBER_PickedduringPiVPNSetup
AllowedIPs = 0.0.0.0/0, ::0/0
```

This redacted Wireguard.conf file gives us the opportunity to talk about some configuration considerations. All of the redacted "keys" in the above file will be created by PiVPN when you go through the ".conf" file creation.

In order to make a VPN connection between two different networks that have different public IP addresses provided by the Internet providers, you will need to either have a static public IP from your Internet provider or you will need to tie a personal domain to your public IP using a Dynamic DNS service. I decided to use [freedns.afraid.org] (https://freedns.afraid.org). Through this service you can get a free domain name that you can link to your public IP. Since my Internet service provider does not provide me with a static public IP, freedns provides a super simple crontab script that you can copy and paste into your crontab that will ping their service throughout the day to ensure that your public IP if changed is still linked to the free domain name that you set up through their service. In the file above, I have my free domain name on the line that says, "Endpoint." Notice that after your domain name you will need to put after the ":" the port number that you set Wireguard to run on when you ran the setup script for PiVPN. This also means that you will have to go into your router or firewall and forward that port to the computer that is running Wireguard, which in my case is my Raspberry Pi 1 B. I also decided to run the cron script that updates my link between my domain name and my public IP on the Raspberry Pi as well.

When my "client" computer connects to the Wireguard tunnel it is given an IP that is in the range specified on the "Address" line. When you look at the "clients" that have connected to the PiVPN you will notice that they have IP addresses from that range which is not the actual IP address that your computer has from your DHCP server on your network, and that's okay.

When I used the above Wireguard ".conf" file, I noticed something that I didn't want. Since I was connecting from my home network, and not from some public coffee shop, I didn't want all of my Internet traffic to go through the VPN tunnel. Yet this is what will happen when you have the "AllowedIP's" configured as you see above with all "0". That configuration is telling Network Manager to send all of my Internet traffic through the VPN tunnel. You may want this option if you are frequently on untrusted networks like those in hotels and coffee shops. I'm using this VPN tunnel to connect my home systems to my work systems. So that only the network traffic between home and work systems traveled over the VPN tunnel, I need to make some changes to the Wireguard configuration.

1. First, make sure that the DHCP server that you are using at home and at work are giving out IP addresses to your systems that are in different ranges. Typically, your DHCP server will be running either on your router or a system that is acting as your DNS server. If your home DHCP is handing out addresses in the 192.168.100.0/24 range then make sure that your work DHCP is handing out addresses in a different 192.168.400.0/24 range or a 10.100.1.0/24 or something different from your home network.

2. In my case since I was connecting my home systems to my Raspberry Pi 1 B on my work network, so I needed to put the address range used by my work DHCP server in the "AllowedIPs" line.

3. After making that configuration change, and reimporting it into Network Manager as explained above I discovered a new problem. On my home computer I could SSH into the Raspberry Pi at work using its DHCP reserved IP that it gets from the work DHCP server, but I couldn't surf to any other place on the Internet. I deleted that profile and wondered what I had done wrong in my configuration. After a number of Internet searches I discovered that if I wanted a "Split VPN Tunnel" where I only wanted my communication to my systems at work to go through the VPN tunnel and all other Internet traffic to go through my home network's Internet provider, then I needed to delete the line under "[Interface]" that gives "DNS" server information. After deleting that line, and reimporting the ".conf" file, everything worked as expected. I could SSH into my systems at work. I could view a web based CRM in my web browser by going to the IP address of my Debian server, but the rest of my Internet traffic when out through my home's connection to the Internet.

Honestly, I don't know enough about how Wireguard works to understand why the DNS reference caused that unexpected behavior in my Internet access. I couldn't find a clear explanation of what is happening in my Internet research on this behavior. My guess, and I hope that I learn whether this guess is correct is the following. I believe that when Network Manager makes the creates the Wireguard "interface" and makes the connection to the VPN tunnel that it will try to route all traffic through that tunnel as the default behavior. As soon as I entered a limited range of IP addresses on the "AllowedIPs" line, all Internet traffic to IP's outside of that range were blocked. When I deleted the "DNS" information under interface, I think Network Manager saw that it no longer had a way to resolve DNS requests through the VPN tunnel so it looked for a DNS server that was connected to one of my other system's interfaces, which it found through my wifi connection on my home network. So, Network Manager than changed to forward all network traffic that needed DNS through my home wifi connection, and only the network traffic that was going to the specified "AllowedIPs" went through the VPN tunnel. If my guess is incorrect, I welcome the correction and the opportunity to learn more about networking and VPNs.

## RPi 1 B As Git Server

My old Raspberry Pi has opened up some amazing possibilities. Thanks to PiVPN running on the RPi 1B I have an encrypted connection between my home network and my work network. Now I can easily and securely share my dotfiles between all of my Linux systems, but I need a Git server to store the versioning of these dotfiles that will be created by [yadm](https://yadm.io/). As I mentioned, I want to self host my Git server so that I can be more cautious with any secrets that might end up accidentally in my Git repository. I have played with [Gitea](https://gitea.io) in the past, but I really didn't need a entire self-hosted GitHub for my dotfiles. I found this tutorial on [PiMyLifeUp](https://pimylifeup.com/raspberry-pi-git-server/) which just uses the power of Git as a distributed versioning system. The only requirement is to have Git installed on the RPi and SSH access from the computers that will be using it as their remote Git repository server. The steps to create a remote repository on the RPi were super simple.

1. Create a new directory in the $HOME folder or the user that you will use to connect to the RPi with SSH.
2. `cd` into that newly created directory.
3. Initialize the Git repo with the following *bare* command: `git init --bare`
4. Create a Git repo on your "client" system in a directory with the same name as the directory created above on the RPi using `git init`.
5. Connect the "client" git repo with the remote git bare repo on the RPi using the following command: `git remote add $NAMEOFGITREPO $RPi-user@$RPiIP:/home/$RPi-user/git/$NAMEOFGITREPO`
6. If there are already files in the git repo on the RPi than you can simply connect to it using the command: `git clone $RPi-user@$RPiIP:/home/$RPi-user/git/$NAMEOFGITREPO`

Ok, so now my old RPi 1B from 2012 is running PiVPN, acting as my remote git server, and runs a cron script to keep its public IP updated. Have I reached the limits of this old single board computer? Well, I just checked in on the RPi and ran `htop` which by far is the most resource intensive program running on it. I'm using between 4%-16% of the CPU, and about 32MB of the 512MB of RAM. To wrangle my dotfiles, I don't need to run anything else except the [yadm](https://yadm.io/) bash script that I will talk about in a little bit. This leaves me with significant system resources that I could use for other purposes. What other cool things can I run on this old RPi to continue to extend its usefulness?

## Unifying My .bashrc

In version 1.0 of this project, I never ended up using **yadm** to manage my dotfiles on my other Linux systems that were not running MX Linux Fluxbox. It ended up being super useful to keep my Fluxbox settings in sync between my two MX systems. In version 2.0 I wanted all of my dotfiles to be managed by this system regardless of what Linux distro they might be running. As I thought about what I needed to do to accomplish this my biggest hurdle was my .bashrc. Let me explain by highlighting what was different about the other dotfiles that I would be wrangling with this system.

### vimrc

I like vim to look and act the same way on all of my systems. So, I only needed one vimrc that had all of the same configuration options and plugins. When I discovered recently that I could keep my vimrc in `~/.vim/` along with my favorite color scheme and lightline configurations, this made things simple to organize for vim.

### ~/.config/roxterm.sourceforge.net

I use ROXterm on both Fedora 35 and MX-21. The rest of my Linux systems are CLI only. I can have the same configurations on both distributions by simply managing the files in that sub directory under `.config` in my home folder.

### ~/.fluxbox

Only two of my systems use fluxbox, the two that run MX-21. Since there are just a couple of small files in the `~/.fluxbox/` directory that I need to keep synced up, I don't feel as if it is a big deal if I have those files also in the home directories of my systems that don't run fluxbox.

### ~/.bashrc

My `.bashrc` is the only configuration file that has the need for different configuration options depending on which distro I happen to be on. Here are some of the differences that I have discovered.

* I need different configuration options on Fedora and Debian systems when I want to use vim as my default editor. I use the **vimx** package on Fedora and **vim-gtk3** package on Debian to make it easy to use the system clipboard in **vim**. Unless I explicitly reference **vimx** on Fedora my git commits will fail to start vim because it doesn't think vim is installed. I tried to just use an alias to make all references to *vim* call *vimx* on Fedora, but this doesn't fix the issue with git. I'm not sure how Debian does it, but they create symlinks from any vim executable that you have installed to calls for *vim*, so these explicit references are not needed on my Debian based systems.
* Two servers get woken up with "wake on lan" but I need two different "wake on lan" commands depending on which system I'm configuring and which server is on its network. I haven't tried it, but I'm guessing that I can't send the magic packets over the VPN tunnel. So the network location determines which aliased command those systems receive.
* **Autojump** is one of my favorite bash utilities, but the installation of this program is slightly different on Fedora verses Debian based systems so those configurations in my .bashrc need to be different.

**yadm** offers a system to link alternate files that are tied to specific systems, so that I could have a unique .bashrc for MX, Fedora, Debian, Raspberry OS, and Ubuntu on WSL. However, in their documentation, they encourage you to have the same files across all of your systems whenever possible. Since I don't mind a few unused dotfiles being on all of my systems, this left just my `.bashrc` needing to be reworked so I could have one file that worked on all of my systems. The solution that I found was rather simple. Since I liked how my prompt looked, I could leave that the same for all systems. I could have all of the aliases that I like applied to all of my systems, and this left just a small section of the `.bashrc` that addressed the differences that I noted above. The solution was to add a section governed by the `if, then, elif, fi` statement.

Basically it looks like this:

```
if [ $HOSTNAME = System1 ]
then
    $HOME/bin/ufetch-fedora
    alias upup='sudo dnf update -y'
    # Alias will wakeonlan Fedora Server on home network
    alias wake='wol $FEDORASERVERMACADDRESS'
    # Setup Autojump for Bash
    export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"
    source /usr/share/autojump/autojump.bash
    # set default editor to Vim
    export EDITOR=vimx
    alias vim='vimx'
elif [ $HOSTNAME = System2 ]
then
    $HOME/bin/ufetch-mx
    alias upup='sudo apt update && sudo apt full-upgrade -y'
    # Alias will wakeonlan Debian Server on work network
    alias wake='wakeonlan $DEBIANSERVERMACADDRESS'
    # set default editor to Vim
    export EDITOR=vim
    # Installation instructions came from /usr/share/doc/autojump/README.Debian
    # Added the last line to source the shell script to enable autojump.
    # Uncomment the next line only if autojump doesn't seem to work.
    # export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"
    . /usr/share/autojump/autojump.sh
elif [ $HOSTNAME = RPi1 ]
then
    $HOME/bin/ufetch-raspbian
    alias upup='sudo apt update && sudo apt full-upgrade -y'
    # Alias will wakeonlan Debian Server on work network
    alias wake='wakeonlan $DEBIANSERVERMACADDRESS'
    # set default editor to Vim
    export EDITOR=vim
    # Installation instructions came from /usr/share/doc/autojump/README.Debian
    # Added the last line to source the shell script to enable autojump.
    # Uncomment the next line only if autojump doesn't seem to work.
    # export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"
    . /usr/share/autojump/autojump.sh
fi
```

That's enough to give you the general idea. If there is a bash configuration that is unique to one of my systems it goes into this block of code. By adding the **ufetch** scripts into these blocks, I get a visual reminder that these unique configuration options have been loaded into my bash session on that system.

## yadm

[Yadm](https://yadm.io/) was the key to wrangling my dotfiles in my 1.0 version, and it is still a key tool in keeping my dotfiles in sync across all of my systems. This time around I learned a new trick when it came to installing **yadm**. Originally, I chose **yadm** because I could install it from the Debian repos. I'm not sure how I missed it, but in the installation documentation they also suggest cloning the GitHub repository and adding a symlink to that git repo in the execution path on your local system. Since you have to have git installed for **yadm** to work, this installation method makes the most sense to ensure that you are always using the latest version, and the same version on all of your systems. In my .bashrc I have my `~/bin/` directory added to my $PATH, so I installed **yadm** with just these commands on all of my systems.

```
git clone https://github.com/TheLocehiliosan/yadm.git ~/.yadm-project
ln -s ~/.yadm-project/yadm ~/bin/yadm
```

With **yadm** installed, I carried out the next steps on the system that had my previously mentioned `.bashrc`.

1. Ran in my home directory: `yadm init`
2. Added my .bashrc: `yadm add .bashrc`
3. Committed my changes: `yadm commit`
4. Connected this local yadm managed repo with the remote repo on my RPi 1B: `yadm remote add origin $RPi-user@$RPiIP:/home/$RPi-user/git/$NAMEOFGITREPO`
5. Pushed my special .bashrc to the remote repo: `yadm push -u origin master (or this could be "main" depending on how you set up your git repo)`
6. All the rest of my systems I started using **yadm** by being in my home directory and running the command: `yadm clone $RPi-user@$RPiIP:/home/$RPi-user/git/$NAMEOFGITREPO`

My Wrangling Dotfiles 2.0 version will manage the configuration files of 7 out of the 8 systems mentioned at the beginning of this article, but this system gives me the flexibility and security I had hoped to achieve. I could easily add additional systems to this current structure in the future. Thanks for reading this article, and I hope that my adventure has given you some ideas that you could use to wrangle your own dotfiles.

*Original header image by [VViktor](https://pixabay.com/users/VViktor-5823236/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2826195) from [Pixabay](https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2826195). Image effects were created using the FOSS [Krita](https://krita.org/en/), [figlet](http://www.figlet.org/), and [lolcat](https://github.com/busyloop/lolcat).*
