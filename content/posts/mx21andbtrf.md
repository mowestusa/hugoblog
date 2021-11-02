---
title: "Diving Into a Pool of Butter with MX-21 and Btrfs"
date: 2021-11-01T14:00:00-04:00
draft: false
categories:
- Articles
tags:
- btrfs
- MX-Linux
- timeshift
- RAID1
- hardware
---

![MX Logo diving into pool of butter labeled with the btrfs logo](/img/diveintobtrfs-header.png)

## Thoughts Before MX-21 Install

MX-21 was officially released on October 21, 2021 in its XFCE, KDE, and Fluxbox editions with the standard Debian 11 kernel. MX Linux has been a joy to use since my first install that you can read about in [MX Fluxbox Puts a Shine on Old Code](https://discoverfoss.com/posts/mxfb-shine/). Now with two of my computers running MX Linux Fluxbox Edition, I definitely planned to upgrade. I had done some testing while MX-21 Fluxbox was in beta, but I didn't know how I would handle upgrading my MX Linux desktop that had a btrfs RAID1 array. After unproductive Internet searches and a MX forum post that received the chirps of crickets, I figured I would need to come up with my own solution. Yes, I had a backup of the data on the btrfs RAID1 array, but this was my home folder. I wanted to avoid the pain of restoring the data to my `/home` folder when I move from one version of MX Linux to the next.

As he often does, Dolphin Oracle, one of the main devs, released a [video](https://www.youtube.com/watch?v=Y_Xz4GJO9Bo) showcasing the new custom partition editor in the MX-21 installer. He does this by creating a btrfs partition and sub volumes for the root partition that enables you to use [Timeshift](https://teejeetech.com/timeshift/) which makes use of the snapshot features of btrfs to both create and restore system snapshots. Once I saw that video, I wanted all of my drives with btrfs. I was already taking advantage of having a btrfs RAID1 array to help preserve my data from bit rot. Now on my system drive I could take advantage of snapshots, another great feature of btrfs.

This video and the overwhelming sound of crickets on my MX Forum post still left me wondering if I could safely use the installer with its custom partition editor to reconnect to my btrfs RAID1 pool as my `/home` folder.

## Jumping Into the Deep End of the Buttery Pool

As a reminder, here are the 3 drives that I have in the system.

* Bay #1 = 120GB SSD
* Bay #2 = 1TB Western Digital Blue HDD
* Bay #3 = 1TB Western Digital Blue HDD

The 120GB SSD had the `/root` system install of MX-19, and I decided that I would again use that drive as `/root` for MX-21. This time I would install btrfs with the new custom partition editor in the MX installer, and add the appropriate sub volumes needed by Timeshift for btrfs snapshots. Bay #2 and #3 or sdb1 and sdc1 were my btrfs RAID1 array mounted as `/home`.I decided that I would not touch those drives during the install. The reason I went this route is because when I got to the custom partition editor in the MX installer, it saw both drives and saw that they were both running with btrfs. What the installer didn't seem to see was that they were in a RAID1 array. After you run the command to format the partitions and create the RAID1 array, the system usually sees the two separate drives as one drive with a single UUID. Since the installer saw two drives, I couldn't trust that it recognized that these drives were formatted to be in a RAID1 array. By leaving them untouched this meant that the installer would put both `/root` and `/home` on the 120GB SSD. This ended up being an advantage, because of the significant changes that have been made to the MX-21 Fluxbox edition. Since the customizations of MX Fluxbox are saved and installed into `/home` this would mean that I would have a `/home` folder with all of the new MX-21 customizations instead of this new version of MX-21 trying to use my `.fluxbox` folder from my MX-19 install.

The MX-21 Fluxbox edition install went off without a hitch, then came the adventure.

## Reconnecting the RAID Array

I didn't know if my formatted btrfs RAID1 array would survive the install of a new OS. Yes, it was still MX with its lovely Debian Stable base, but it was a clean install of the system without touching or formatting the two 1TB drives. After booting into my fresh install of MX-21 Fluxbox edition, I ran the following command to see what it would say.

	sudo btrfs fi show

The output of this command made my day. It recognized all three drives as btrfs formatted drives, but it also saw the two 1TB drives as a RAID1 array with a single UUID. Now for the moment of truth. Could I mount my RAID1 array and browse my files? I ran the next two commands so that I would have a mount point that I could use to transfer files from my new `/home` on the SSD to my old `/home` on the RAID1 array.

	sudo mkdir /mnt/butter
	sudo chmod -R 777 /mnt/butter

Next I added an entry into the `/etc/fstab` file, that used the same **UUID** that I used in MX-19 and used `/mnt/butter` as the mount point. See [Bake Up a Btrfs RAID1 Array](https://discoverfoss.com/posts/btrfsandraid1/) for the details.

Now I took advantage of having all of the new configuration files that were installed by MX-21 Fluxbox into `/home`. First, I changed all of the folders on the btrfs RAID1 array that had configuration files from my old MX-19 install to something like:

        /home/.fluxbox to /home/.fluxbox-mx19 

Now I would be able to copy over the `.config` and `.fluxbox` and other directories to the RAID1 array without loosing my old configuration files. I copied every file that was in `/home` over to the RAID1 array, and took the next steps in making the RAID1 array my new `/home` folder.

1. I changed the name of the `/home` folder on the 120GB SSD to `/home-original`.
2. I created a new `/home` folder that was empty.
3. I changed the `/etc/fstab` file from the mount point `/mnt/butter` to `/home`.
4. Then I rebooted just to be safe that everything would be found and restarted from the RAID1 array `/home` folder.

It worked! My new MX-21 Wildflower Fluxbox edition booted up with the btrfs RAID1 array mounted as `/home`. I'm thrilled!

## Final Steps in Using Btrfs to the Fullest

I would encourage you to watch Dolphin Oracle's video that I referenced above. I used his tutorial at the end of that video to set up Timeshift to use the btrfs snapshots on a weekly basis. I'm looking forward to putting btrfs to the test in the months to come. This whole system is running with recycled hard drives and hardware, so a drive failure is a possibility, but I'm hoping that with my weekly snapshots and RAID1 array that I will be able to recover from either a messed up upgrade or a failing data drive. Thanks to MX-21 being committed to track with all of the point releases of Debian 11, I won't have to deal with a clean install for probably two more years or whenever Debian 12 gets released. I like the idea of having a solid system that I can count on at work for the years to come.

## Wrap Up

*Could I have used the MX installer and assigned `/home` to sdb1 without issues?* Maybe, but I didn't want to take the risk. This is more of a production machine that I use regularly at work to get things done. Although it would have been good to test the MX installer so I could offer feedback on its future development, I didn't want to be without this computer for too long at work.

*Are there easier ways to achieve what I accomplished?* Possibly, but I was surprised how little I found in my Internet searches. I found information about creating a btrfs RAID1 array in different distros either during the install or post install, but I didn't find a single article that talked about reattaching to a btrfs RAID1 array that already existed. Because of this I was convinced that when I did a clean install of the system, that I might destroy the bits that told the OS that the two drivers were in a RAID1 array. Clearly, I have much to learn about file systems, RAID arrays, and what happens during the creation of a file system on a disk and how those details are stored.

I'm hoping that the search engines will find this article and provide it as a resource to others who would like to do a clean install of their system, but would also like to preserve their `/home` folder that rests on top of a btrfs RAID1 array.

The original pictures used in the header graphic for this article are the following:

- "Butter and sugar melt together" by jessicafm on [Flickr](https://flickr.com/photos/jessicafm) is licensed with CC BY 2.0. [A Copy of this License](https://creativecommons.org/licenses/by/2.0/)
- [MX Logo](https://mxlinux.org/art/)
- [Btrfs Logo](https://btrfs.wiki.kernel.org/index.php/Main_Page)
