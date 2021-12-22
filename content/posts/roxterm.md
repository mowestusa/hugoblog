---
title: "ROXterm a Full Featured Terminal"
date: 2021-12-21T15:30:48-04:00
draft: false
categories:
- Articles
tags:
- MX-Linux
- Fedora
- fluxbox
- terminal
---

![ROXterm header graphic](/img/roxterm-header.png)

[MX Linux](https://mxlinux.org/) often introduces me to new FOSS (Free and Open Source Software). My preferred flavor of MX Linux is [MX-Fluxbox](https://mxlinux.org/mx-fluxbox/). This MX Linux flavor used to be bundled with the flagship version of MX Linux that installed the [XFCE Desktop](https://xfce.org/). Since the ISO already had all of the XFCE tools, MX-Fluxbox often used XFCE tools as its defaults too. With the latest release of MX-21 the development team decided that there would be three separate ISO's for the three main flavors plus an additional ISO of XFCE offering Advanced Hardware Support for computers with the latest hardware and graphics cards. MX-Fluxbox took advantage of having their own separate ISO by revising their default tool set. This change brought [ROXterm](https://github.com/realh/roxterm) to my attention. I wanted to share ROXterm with you as a little Christmas gift just before you head out with your Linux powered laptop to visit family and friends.

Originally, ROXterm was part of the tool set created for the [ROX Desktop Environment](http://rox.sourceforge.net/desktop/), a project that is not actively maintained, but you can find parts of the ROX tool set in your distribution repositories. The ROX desktop embraced the UNIX idea of everything being a file, and created an interface the made use of "drag-and-drop" and built itself around the ROX-Filer, their version of a graphical file manager. If you enjoyed RISC OS or AmigaOS in the past, the ROX Desktop might bring back some of those pleasant memories. This [article](https://opensource.com/article/19/12/linux-rox-desktop) gives you a nice overview of the ROX Desktop. My exposure to the ROX Desktop came from my use of the ROX-Filer in both Puppy Linux years ago, and more recently in AntiX. I enjoyed the simplicity and power of ROX-Filer in those distributions of Linux.

ROXterm's main developer, realh, renewed his development of ROXterm when he moved from its old home on [Sourceforge](http://roxterm.sourceforge.net/) to [Github](https://github.com/realh/roxterm). The [User Guide](https://realh.github.io/roxterm/en/guide.html) provides a nice overview of all of ROXterm's features. Although ROXterm has a long history, the developer has provided the FOSS community with a modern, full featured terminal. I have been running ROXterm on both MX-21 and Fedora 35 without issues. Having a feature rich, highly configurable, and rock solid stable terminal as a Linux user is a delight. Is ROXterm way better than XFCE terminal or Gnome terminal? In my testing, those terminals are also stable and highly configurable. ROXterm doesn't seem to save me large portions of RAM. Because of the amazing [Gogh Script](https://github.com/Mayccoll/Gogh), which offers an easy way to switch between over a 100 colour schemes, XFCE and Gnome terminals are easier to dress up with new color schemes. Yet, I'm enjoying how ROXterm presents its features and its customization options. Here are some of my favorites.

### Tabs

I'm not a fan of computer use being tied so intimately to an Internet connection. I'm sure you have noticed that most of your work that you do on your computer takes place inside a web browser. The apps of your phone are often just mobile versions of web apps that won't work unless you have your mobile data on. The benefit comes in the form of making it easier to collaborate with a co-worker and making remote work even easier. The disadvantages that I have found include being easily distracted by "non-work" related sites and content, and a disruption of my work when suddenly the Internet connection is lost because the Cable Internet provider's modem is not as dependable as I would like or my wireless card in my aging computer has become more temperamental with age. Yes, I could work on a document "off line" but the collaborative planning document that I was using to pull information from is online.

Even though, I'm not a fan of being tied to an Internet connection to get my work done during the day, the Internet has influenced my workflow. I'm used to thinking in "tabs". This is the first ROXterm feature that I appreciate, "tabs." Instead, of trying to tile my terminals in nice columns and rows as a tiling window manager achieves with ease, I find that my brain likes full screen terminals in different tabs. ROXterm comes with a full set of commands that I can use to create, move through and rearrange tabs of terminals, just like I do with tabs in a web browser. ROXterm gives you the power to customize your keyboard shortcuts or add shortcuts for commands that don't have one already. Here are a couple of hints to make your use of **Tabs** more enjoyable.

1. In web browsers the common shortcut `Ctrl+Tab` to cycle through your web browser tabs won't work in ROXterm. This actually impacts Gnome Terminal as well because it is a limitation of the GTK stack. There is a complicated work around that you can implement for Gnome Terminal, but since ROXterm doesn't use `dconf` to edit its keyboard shortcuts the work around won't work for ROXterm. However, I have found a satisfactory workaround. Just use the defaults that come with ROXterm which are `Ctrl+Page_Down` for **Next Tab** and `Ctrl+Page_Up` for **Previous Tab**. These keyboard shortcuts also work in Firefox and Vivaldi the two browsers that I tend to use on Linux. This simple retraining of my brain didn't hurt too much.

![ROXterm Preferences Dialog](/img/roxtermConfigureProfile.png)

2. Under **Preferences - Edit Current Profile** go to the section **Tabs** and turn on the option **Wrap when switching tabs**. This is handy and will enable you to cycle through all of your tabs by just using `Ctrl+Page_Down` or `Ctrl+Page_Up`.

3. Finally in that same **Preferences** dialog mentioned in *#2* notice that you can move your tabs to the left, right, or bottom. I have moved my tabs in to the bottom, since most of the time my eyes are looking at the bottom of a terminal window.

### Custom Colo**u**r Schemes

I mentioned above the [Gogh Script](https://github.com/Mayccoll/Gogh). That script is not compatible with ROXterm, but you can create custom colour schemes for ROXterm. I have collected the ones that I could find on Github in this [Repository](https://github.com/mowestusa/ROXterm_Colours). I do have one original in that collection that I created myself called **Mountain** which is inspired by the **mountain.vim** theme which you can find [here](https://github.com/TheNiteCoder/mountaineer.vim). It is a dark theme that I find pleasant to work with in vim and in ROXterm. To add colour schemes to ROXterm drop those configuration files in `~/.config/roxterm.sourceforge.net/Colours`, and they will show up the next time you open ROXterm as optional colour schemes.

I have been enjoying my last month in ROXterm. No crashes, no weird glitches, and easy to customize, what's not to love! Give it a try, or just explore your terminal emulator of choice. Most of them in Linux are rock solid and offer plenty of configuration to make you feel at home. My extra time in the CLI that you will hear about in my next blog article has been pleasant thanks to ROXterm in my daily workflow on Fedora 35 and in MX-21.

*Original photo used in the article header comes from [Ben White](https://unsplash.com/@benwhitephotography?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText") on [Unsplash](https://unsplash.com/s/photos/christmas-gift?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText). All other graphics were screenshots taken by me.*
  
