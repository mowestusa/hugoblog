---
title: "Bake Up a Btrfs RAID1 Array"
date: 2020-11-08T21:45:00-04:00
draft: false
categories:
- Articles
tags:
- btrfs
- hardware
---

![A Hard Drive on top of a pile of flour and butter](/img/btrfs-array-header.png)

I recently gave my spare work computer which runs Linux a serious upgrade. My old Toshiba laptop had served me well at my standing desk. Since I never unplugged the laptop from its perch on the standing desk it seemed natural to upgrade that machine to a "new to me" desktop computer. Now I had a desktop case that could hold three 3.5" HDD's. I filled those three bays with these spare drives that I had on hand.

* Bay #1 = 120GB SSD
* Bay #2 = 1TB Western Digital Blue HDD
* Bay #3 = 1TB Western Digital Blue HDD

This is the first time in recent history that I have run Linux on a desktop computer with multiple drives installed. Since I have never tried the btrfs file system or a RAID storage array, I decided to experiement. I decided to install my Linux distro on the 120GB SSD using the EXT4 file system. I decided to make the two identical 1TB Western Digital Blues my RAID1 array with the Btrfs file system. Here were my steps to get a working Btrfs RAID1 array up and running on the new desktop.

## 1. Creating the File System and Array

I read a few tutorials, but none of them seemed to apply to the exact situation I was trying to create. In the end I used [Gparted](https://gparted.org/) to erase both of the 1TB drives that I was recycling for this project. I did this by creating a new ***msdos*** partition table on each of the drives, and then creating one large unformated partition that took up the whole drive.

The following command created the file system and joined the two drives into a RAID1 configuration using the Btrfs file system.

	sudo mkfs.btrfs -m raid1 -d raid1 /dev/sdb1 /dev/sdc1

## 2. Mounting Your New Btrfs RAID1 Array

I struggled with this part, because I wanted to have this RAID1 array accessable by my normal user so it could be used to hold all of my user's data files like documents, pictures, music, and videos. I found plenty of tutorials mentioning the importance of creating a mount point in `/mnt` but they all failed to mention that you needed to change the permissions on the folder that you create. The following commands created the folder that I would use for the RAID1 array.

	sudo mkdir /mnt/butter
	sudo chmod -R 777 /mnt/butter

Next you need to add an entry into your `/etc/fstab` file, but you first need to grab the **UUID** which can be easily found by running the following command.

	sudo btrfs fi show
	
Now armed with the **UUID** we can add a line to the `/etc/fstab` file by editing the file with the following command.

	sudo nano /etc/fstab
	
You will want to add a line to the file that looks something like this.

	UUID=99910bf7-bcdf-429e-a5b2-f36b5d5ebcfc /mnt/butter btrfs defaults 0 0

Finally, to mount your array run the following command which will remount all of the mount points that are specified in your `/etc/fstab` file.

	sudo mount -a

> **Additional Note:** In the end, I decided to use this new btrfs RAID1 array as my /HOME folder. After I had copied all of my /HOME files to the btrfs RAID1 array, I changed the `/etc/fstab` file to mount the btrfs RAID1 array as /HOME instead of /mnt/butter. At first I hesitated putting all of /HOME on the array, because I thought I would loose some speed in the starting of applications if their configuration files were on the array. This has not been an issue. I'm enjoying this setup and the peace of mind of knowing that my root folder gets the whole of the 120GB SSD while my data files in /HOME have plenty of room to multiply on the 1TB RAID1 array.

## 3. Checking the Available Space on your Btrfs RAID1 Array

At this point you should have your newly formated btrfs drives mounted as as a RAID1 array which means that your total available drive space will be exactly half of the total amount of diskspace you have available on the physical drives. You can check on how much of that space you are using by running the following command again.

	sudo btrfs fi show


The original pictures used in the header graphic for this article are the following:

The butter squares on flour was from [Pixabay](https://pixabay.com) taken by [Hans Braxmeier](https://pixabay.com/users/hans-2/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=4753498)

The picture of the Western Digital hard drive also came from [Pixabay](https://pixabay.com) provided by [Emilian Robert Vicol](https://pixabay.com/users/byrev-23277/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=88004)
