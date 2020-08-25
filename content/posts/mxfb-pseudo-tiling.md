---
title: "MX-Fluxbox Pseudo Tiling"
date: 2020-08-18T18:24:44-04:00
draft: false
categories:
- Tutorials
tags:
- MX-Linux
- fluxbox
---

![MX-Fluxbox Pseudo Tiling Header Graphic](/mxfb-pseudo-header.png)

Eventually the experienced FOSS user will discover tiling window managers. Similar to fluxbox, tiling window managers are light weight on resources, but they might need additional customization to enable features that come turned on automatically in desktop environments like [Gnome](https://www.gnome.org/), [Plasma](https://kde.org/plasma-desktop), [Mate](https://mate-desktop.org/), and [XFCE](https://www.xfce.org/). Tiling window managers include FOSS like [Awesome](https://awesomewm.org/), [Xmonad](https://xmonad.org/), [i3](https://i3wm.org/), and [herbstluftwm](https://herbstluftwm.org/) just to name a few. Tiling window managers use keyboard shortcuts to quickly arrange your program windows into tiled layouts to make the most of your screen real estate. Fluxbox is considered a floating window manager. This means that your program windows will not rearrange as you open new programs to fill up the space on your screen, but instead new program windows layer on top of one another concealing portions of the program window below it.

I have used tiling window managers in the past. I can see their appeal especially if you often work with multiple programs open where you would like to see what they are displaying at all times. I can also see their appeal in enabling workflows that help users work quickly and efficiently while keeping their hands on the keyboard and decreasing the need to use a mouse or touch pad. Personally, my brain seems to work better with floating window managers which have a similar behavior when compared to Gnome, Plasma, Mate, and XFCE. [Ubuntu Mate](https://ubuntu-mate.org/) introduced me to the concept of pseudo tiling in a floating window manager. You will notice this behavior in other operating systems or in some desktop environments. Often with the mouse you can "snap" your window to the left or right side of the screen so that it takes up 50% of the screen. Ubuntu Mate took this concept a step further. They had window snapping, but through keyboard shortcuts they enabled you to quickly tile your windows to cover either half of the screen or a quarter of the screen. In a matter of seconds you could move four program windows into the four corners of the screen. Sometimes this behavior is mapped to keyboard shortcuts that use the keys in a 10 keypad on the right side of a full keyboard. Ubuntu Mate had this behavior mapped to sensible keyboard shortcuts that work with smaller laptop keyboards that lack a 10 keypad.

Let's see how you can add pseudo tiling to fluxbox using most of the keyboard shortcuts from Ubuntu Mate. Open the keys file in your .fluxbox folder in your home directory. Then add the lines below. After saving the keys file you will need to restart fluxbox in order to use the new keyboard shortcuts.

	### PSEUDO TILING WINDOWS ###

	# Make active window 1/2 of the screen
	Mod4 Left :MacroCmd {ResizeTo 50% 100%} {MoveTo 00 00 Left}
	Mod4 Right :MacroCmd {ResizeTo 50% 100%} {MoveTo 00 00 Right}
	Mod4 Up :MacroCmd {ResizeTo 100% 50%} {MoveTo 00 00 Up}
	Mod4 Down :MacroCmd {ResizeTo 100% 50%} {MoveTo 00 00 Bottom}

	# Make active window 1/4 of the screen on the upper left
	Alt Mod4 Left :MacroCmd {ResizeTo 50% 50%} {MoveTo 00 00 Up}
	Alt Mod4 Right :MacroCmd {ResizeTo 50% 50%} {MoveTo 00 00 TopRight}
	Control Mod4 Left :MacroCmd {ResizeTo 50% 50%} {MoveTo 00 00 BottomLeft}
	Control Mod4 Right :MacroCmd {ResizeTo 50% 50%} {MoveTo 00 00 BottomRight}

	# toggle active window: Maximized/ last size
	Mod4 End :ToggleCmd {Maximize} {Restore}

Thanks to the power of MacroCmd in the fluxbox keys file, you can resize the active window and move it anywhere with a keyboard shortcut. The first set resizes the window either to 50% wide and 100% high or 100% wide and 50% high. The command then moves the window either to the left, right, top, or bottom of the screen. The second set resizes the windows to a quarter of the size of the screen and moves them into one of the four corners. I like the final keyboard shortcut which quickly maximizes the window to fill the whole screen.

*For those who have used Ubuntu Mate's pseudo tiling, you will notice that two of the keyboard shortcuts are different. In Ubuntu Mate the keyboard shortcuts that enable you to put a quarter sized window into the lower corners use the key combinations: "Shift Alt Mod4 Left" and "Shift Alt Mod4 Right." Although, fluxbox allows the use of "Shift" as a modifier key in keyboard shortcuts, there seems to be a bug in fluxbox that prevents "Shift" from working when it is paired with arrow keys. So an easy fix was to use the "Control" key as a modifier key instead.*

### 08/25/2020 CORRECTION to the paragraph above

> What I thought was a bug in fluxbox, was caused by a default setting found in MX-Linux in the `/etc/default/keyboard` file. In that file you will find the following line.

	XKBOPTIONS="grp:alt_shift_toggle,terminate:ctrl_alt_bksp,grp_led:scroll"

> Removing "grp:alt_shift_toggle" as shown below, will cause "Shift" to work as expected in your fluxbox keyboard shortcuts.

	XKBOPTIONS="terminate:ctrl_alt_bksp,grp_led:scroll"
	
> Now I have my fluxbox 1/4 pseudo tiling shortcuts matched to Ubuntu Mate.

	# Make active window 1/4 of the screen on the upper left
	Alt Mod4 Left :MacroCmd {ResizeTo 50% 50%} {MoveTo 00 00 Up}
	Alt Mod4 Right :MacroCmd {ResizeTo 50% 50%} {MoveTo 00 00 TopRight}
	Alt Shift Mod4 Left :MacroCmd {ResizeTo 50% 50%} {MoveTo 00 00 BottomLeft}
	Alt Shift Mod4 Right :MacroCmd {ResizeTo 50% 50%} {MoveTo 00 00 BottomRight}

Personally, these keyboard shortcuts give me all of the tiling options that I need in my workflow. Of course, you can tweak these shortcuts to set up some of the default layouts used in a true tiling window manager. I wanted to share this fluxbox trick to show you all that fluxbox can do. If you would like other ideas for keyboard shortcuts that you can use to set up pseudo tiling, I would like to encourage you to head over to this [forum post](https://forum.mxlinux.org/viewtopic.php?f=143&t=55779) in the MX-Linux forum where I got the inspiration for my take on pseudo tiling.

*Original images used in the article header are by [analogicus](https://pixabay.com/users/analogicus-8164369/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=4243189) from [Pixabay](https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=4243189) and [herbstluftwm-tiling-window-manager](https://www.flickr.com/photos/133825397@N08/39830472585) by [laboratoriolinux](https://www.flickr.com/photos/133825397@N08) is licensed under [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/?ref=ccsearch&atype=html) and a screenshot by me of my lovely MX-Fluxbox desktop.*
