---
title: "Recycled Workstation Build"
date: 2020-12-06T22:18:27-05:00
draft: false
categories:
- Articles
tags:
- MX-Linux
- hardware
---

![Picture of Workstation](/img/newworkstation.jpg)

I recycle computers into Linux boxes. Either I repurpose old hardware that I have purchased or I give a second life to computers that others plan to get ride of. Recently I assembled a new workstation to replace the spare computer that I use at work when I'm at my standing desk.

My primary computer at work runs Windows 10 so that I can still use a priopritary program that I need for my vocation. I have moved all of my other work tasks to FOSS programs that will run on Linux. My spare computer at my standing desk for the last 3 years was an old Toshiba Satellite C650-ST5N03 with the following specs.

* Intel i3-2310M CPU
* 4GB of RAM
* Built in screen with a resolution of 1366x768
* Silicon Power 120GB SSD
* Attached Acer 223W external monitor

The Toshiba has served well as my spare work computer. When I first set up the laptop, I installed Ubuntu Mate and recently I installed MX Linux using MX Fluxbox as my desktop or window manager environment. Overall, I was happy with the performance. When I recorded virtual instruction videos, I noticed that the sound and video were out of sync. I'm not sure if the problem came from performance limitations, the software stack I had chosen, or my poor choices of settings. This workstation proved to me the value of using dual screens, so I knew that I wanted that feature if I ever replaced the Toshiba laptop. 

My local library provided the opportunity to upgrade my workstation. The library is remodeling the interior and replacing all of their computers. Not too long ago the local high school remodeled and donated their used desktops to the library a mix of Dells and Asus desktops. Since I know one of the librarians they allowed me to go through all of the computers they were going to recycle and pick out ones that I could upcycle with Linux. The best desktop that I found was a Dell Optiplex 5040 with a 6th generation Intel i5 and 8GB of RAM. I set that aside to replace my son's primary desktop that he uses for programming. This would replace his Dell Optiplex with 4GB of RAM and a 2nd generation i3. For myself, I set aside an Asus M11AA desktop with the following specs.

* Intel i5-3340S (Quad Core Ivy Bridge)
* 4GB of RAM (upgraded to 8GB of RAM)
* 1TB Western Digital Blue 3.5" Hard Drive (upgraded to 1 Silicon Power 120GB SSD, and 2 1TB Western Digital Blue 3.5" Hard Drives)
* Two Dell E228WFP at 1680x1050 (mounted on a Mount-It! two monitor stand)
* One Dell AX510 speaker bar

Everything was recycled except the new monitor stand to hold the two Dell 22" monitors for $30 from Amazon. The memory upgrade and extra 1TB hard drive came from another Asus M11AA desktop that I stripped for parts. The SSD was in an old laptop that has not been used for more than a year. All the other parts were from the library recycling pile.

Even though this new system could handle the extra weight of a Fedora 33 Workstation install which is the Linux distribution I run on my home workstation, I knew that I wanted MX Linux on this computer. I have fallen in love with MX Fluxbox which I had been running on the old Toshiba laptop, and the MX community has been a wonderful support network as I continue to grow in the ways I use FOSS for both home and work tasks. I did try some new things with this workstation. I have never used RAID, and I have never had more than one drive in my Linux machines. So I decided to install MX Linux on the 120GB SSD using the EXT4 file system. I configured the two 1TB Western Digital Blues in a RAID-1 configuration with BTRFS file system. On the RAID array I have put my home folder keeping my data separate from the OS for the first time. 1TB is more than enough space for two decades of office documents, a few ripped CD's, and some beautiful wallpapers. Currently I'm only using 33GB of the 1TB RAID array. Everything starts up quickly and runs smoothly. I haven't played much with the BTRFS RAID array, but I would like to learn more about the BTRFS file system and its monitoring and repair tools. For now it is just doing its thing, saving and organizing my data files.

I'm enjoying this new workstation so much, that I have found myself at my standing desk for a longer period of my work day than in the past. I do a lot of teaching in my profession, and I'm enjoying having LibreOffice Writer or Impress open on one screen while gathering information and looking things up on the other screen. I find myself using the rightside dock in LibreOffice Writer and Impress often, especially when I'm in Impress, so having a full 1680x1050 just for those programs is nice.

The two Dell monitors have also eliminated another pain point that I had before with my former standing desk workstation. I have eliminated the Acer 223W monitor. This monitor does not work well with Linux. Every Linux distribution that I have tried fails to correctly identify the monitor's refresh rate as 60Hz. Instead every distribution believes the refresh rate needs to be 59Hz. Because of this misidentification of the refresh rate, the screen will be off center when Linux boots to the login manager or into a desktop environment. You can fix this by running a few `xrandr` commands like the ones below.

```
xrandr --newmode "1680x1050_60.00"  146.25  1680 1784 1960 2240  1050 1053 1059 1089 -hsync +vsync
xrandr --addmode VGA-1 1680x1050_60.00
xrandr --output  VGA-1 --mode 1680x1050_60.00
```

You may need to adjust `VGA-1` to `HDMI-1` or something else depending on how xrandr identifies your connection to that monitor. Typically, I place those lines above along with additional flags to identify the primary monitor and the physical arrangment of the monitors when I have used the Acer 223W in a dual monitor configuration. Depending on the desktop environment that I'm using, I auto run a script with these lines so that when the desktop environment is loaded the screen is no longer off center. Although this fixes the display, I found it to be annoying. Thankfully, my Dell monitors are correctly identified by Linux, and I no longer have that annoying paper cut issue.

I recycle hardware to run Linux out of financial necessity. If you can afford the latest hardware to run your favorite Linux distribution, that's great, enjoy the journey. If you struggle to find the funds necessary buy hardware to run Linux, don't be afraid to see what you can do with Linux and a computer that a family member, friend, or local business is going to send to the electronic recycler. You might be able to put together a great system from recycled parts that will serve you well and allow you to dive more deeply into Linux with a dedicated box.
