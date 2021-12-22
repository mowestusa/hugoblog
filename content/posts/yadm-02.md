---
title: "Wrangle Dotfiles Round 2"
date: 2020-12-22T16:50:48-04:00
draft: false
categories:
- Article
tags:
- dotfiles
- yadm
- vpn
- terminal
- git
---

![Wrangling dotfiles header graphic](/img/yadm-wrangle.png)

What do the following technologies have in common?

* 1st Generation Raspberry Pi B with 512mb of RAM
* Wireguard VPN
* Git
* Bash "if than elif fi"
* yadm

Well, I kind of gave it away with the title to this article. These technologies have taken my management of configuration files to the next level. I have been able to implement the 2.0 version of managing my dotfiles, and I'm thrilled with the results. So, let me tell you about the time I have been spending in the Linux CLI lately.

## Raspberry Pi 1 B

Released in Febuary 2012, it became the first mainstream RPi, and it was the first one that came into my possession. Its CPU runs at 700mhz, has 512mb of RAM, and only had two USB ports next to the ethernet port. Unlike the models that came after it, it didn't even have the familiar 40 pin GPIO pins that have become one of the most familar features of the RPi single board computers. It doesn't have wifi or bluetooth either. Yet, 4 and 1/2 years ago my son learned how to program in C++ on this RPi. Since the GUI was so slow and limited on that machine, he fell in love with the Linux CLI and vim as his text editor. My son has moved onto a Dell refurbished laptop and desktops that we salvaged from schools and a library that no longer of have uses for them. In fact, the vast majority of computer hardware that he and I run Linux on are what most people would consider ewaste, but we have breathed a second life into this older hardware. This old RPi was just sitting in the pile of unused hardware, and I wanted to find a way to give it purpose. First, I practiced setting it up as a server with just ssh running and applying the principles that I had learned from a number of articles that involve securing a Linux server. I applied those principles to a Debian server that I set up at the office running a web based CRM just on our Intranet with no access to the broader Internet. Because it just sips power, I decided to use the RPi as my network device that would wake on lan the Debian server so that it wasn't on all of the time, but only when I needed it running. Okay all of that is working great, but what else could I do with it?

As I examined my computer collection I realized that I had the following systems that I was using regularly at work and at home.

* Home: Main System ("Half Top" the bottom half of an HP Envy 17" Laptop that had a broken screen that I removed, and hooked up to a new 32" monitor through the HDMI port. This is my best speced system with an i7-7500U CPU, Nvidia GeForce 940MX, 16GB of RAM, and an upgraded 512GB SSD.) running Fedora 35 Workstation.
* Home: Home Storage Server (Repurposed tower with the same motherboard, RAM, and power supply as mentioned in this [article]({{< ref "/recycled-workstation" >}} "Recycled Workstation Build") running Fedora 35 Server, but is rarely on.
* Home: Old HP DV4 "Entertainment" Laptop running MX Linux 21, Fluxbox Edition. I enjoy taking this laptop when I'm on vacation, so it doesn't get a lot of use, but I like it to mirror my recycled workstation that I have at work with my standing desk.
* Work: 8 Year Old Toshiba Laptop running Windows 10 and Ubuntu LTS in WSL 2. I have a new system on order for work, but it hasn't arrived yet.
* Work: 11-12 Year Old Toshiba Laptop running Ubuntu Mate LTS and is hooked up to a projector for presentations.
* Work: 11-12 Year Old Toshiba Laptop (twin of one above) running Debian and acting as my server that runs the web based CRM that I mentioned earlier.
* Work: The Recycled Workstation that was mentioned above in the blog article that was referenced. I love this system which is what I use when I'm at my standing desk. This system is running MX Linux 21, the Fluxbox Edition.
* Work: The Raspberry Pi 1 B

Besides the Ubuntu Mate laptop that is attached to the projector, I like to have similar configurations on those systems. I like to have the same `.vimrc` and `.bashrc`. I also have been using ROXterm (see this [article]({{< ref "/roxterm" >}} "ROXterm a Full Featured Terminal") for more details), and I appreciate having the same configurations available on all of my systems for my terminal emulator. The last time I wrangled my dotfiles it was mostly so I could keep my two computers that were running MX Linux Fluxbox in sync with each other. I wanted the same keyboard shortcuts in both of my Fluxbox environments. I had planned to add my Fedora system into the mix, but it runs Gnome, and Fedora does things a bit differently than Debian, so I never figured out how I could bring those two worlds together until recently.

I'm trying to learn bash scripting, but I'm moving at a snail's pace. Now with the 2.0 version of managing my dotfiles, I had some motivation to dive back into learning bash scripting. Little did I realize that I wouldn't even need to leave the kiddie pool of bash scripting to accomplish what I wanted to do with my 2.0 version of dotfiles. I had the following goals with the 2.0 version of dotfile management.

1. Unify my configuration files so that I could have one system that would work on Fedora, MX, Debian, and Raspberry Pi OS. Since three out of those four are almost pure Debian that should make things easier.
2. Move my dotfiles off of Github. Yes, it is fun to show off your dotfiles on Github, but I always feared that I would accidently send a file with my secrets up to the Github repo and then my "git fu" would fail me when I tried to remove them. So to be on the safe side, I wanted my git repo to stay on one of my Intranets, either at home or work without access to the Internet.
3. Securely connect my home and work networks together without opening up Port 22 for ssh. I knew that this would involve setting up a VPN, but I wasn't sure how to accomplish this piece. I'm doing some major network upgrades at work, so I contemplated waiting till I had that new equipment in place, but with the current climate of back orders and part shortages, I would try to use tools that I already had. This is when I remembered my RPi 1 B.

## Wireguard VPN on Bullseye Raspberry Pi OS with PiVPN

I had heard great things about *Wireguard* and *VPN's*, but I had never set one up, and I had no idea if the RPi 1 B could handle being my VPN connection point on my work network. It was time to install a fresh version of Raspberry Pi OS since the Bullseye version had come out at the end of October 2021. I wiped the SD card, installed the latest version of Raspberry Pi OS Lite, Bullseye Edition. I did my RPi hardening that I have done in the past to make the RPi more secure. Then I ran the PiVPN install script which further hardens the Raspberry Pi OS against possible attacks. I created my Wireguard client configuration files for my home systems, but this is where I got stuck for a little bit.

Although, Network Manager (the Linux utility that most distros use to access and control the system's network interfaces) supports Wireguard, their are not GUI's on Linux yet. As an example, it is easy to import an OpenVPN configuration file in Gnome on Fedora 35, but the GUI in Gnome 41 doesn't recognize Wireguard configuration files yet.



FOSS programmers have given us amazing choices to use when wrangling our dotfiles. You can try [rcm](https://github.com/thoughtbot/rcm) from the amazing coders at [Thoughtbot](https://thoughtbot.com/). [Homesick](https://github.com/technicalpickles/homesick) seems to have its fans. Besides being a french word that I probably shouldn't attempt to say out load [Chezmoi](https://www.chezmoi.io/) can take your dotfile management to a whole new level. This tutorial by Ryan Walter will get you started with this powerful tool ["Take back your dotfiles with Chezmoi"](https://fedoramagazine.org/take-back-your-dotfiles-with-chezmoi/). You can find others that I failed to mention, but I like [yadm](https://yadm.io/) as my dotfile wrangler.






*Original header image by [VViktor](https://pixabay.com/users/VViktor-5823236/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2826195) from [Pixabay](https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2826195). Image effects were created using the FOSS [Krita](https://krita.org/en/), [figlet](http://www.figlet.org/), and [lolcat](https://github.com/busyloop/lolcat).*
