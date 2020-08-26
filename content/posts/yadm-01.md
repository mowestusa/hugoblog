---
title: "Wrangle Dotfiles with Yadm"
date: 2020-08-23T16:50:48-04:00
draft: false
categories:
- Tutorials
tags:
- MX-Linux
- fluxbox
- dotfiles
- yadm
---

![Wrangling dotfiles header graphic](/img/yadm-wrangle.png)

Running a Linux distribution as your computer's operating system opens up a world of tweaks, configurations, and personalizations. FOSS offers choices in desktop environments, window managers, and favorite programs. All these choices enable you to set up a computer environment that serves your unique needs. What happens when you want to recreate that same experience on a 2nd or 3rd computer that is also running a Linux distribution? You can manually copy each of your configuration files from one computer to another using a folder connected to [syncthing](https://syncthing.net/) or a USB flash drive transferred with [sneakernet](https://en.wikipedia.org/wiki/Sneakernet). You can also manually edit for a second or third time the configuration files which contain your tweaks. These methods will frustrate you when you accidentally write over one of your configuration files with an earlier version that lacks your latest tweaks or when you go to use your favorite keyboard shortcut and realize that you haven't added that one to the system in front of you. I lived in this self imposed frustration until a few weeks ago.

As you can tell from my posts, I have enjoyed fluxbox on MX-Linux. In the past two months, I have edited the files in `$HOME/.fluxbox`. When I decided to switch my spare work computer to MX-Fluxbox, I knew that I needed a solution to keep my configuration files synced between my work and home computers. My previous solution used four simple bash scripts that executed simple rsync commands to either move files from a USB flash drive or copy files to the same thumb drive. More than once I ran the wrong rsync script or failed to run the correct script when I booted the computer and started making changes. This ended up deleting my preferred configuration files. Version control systems by design keep your files synced between different computers, and have tools to merge conflicts when they occur. I had failed to look for solutions that would help me wrangle my configuration files or as they are commonly called "dotfiles."

Also by design Linux distributions and the software that run on top of them use simple text files to store their configuration tweaks. Often these files are prefaced with a `.` or live in a directory that is a dot-directory like the example I gave above
`$HOME/.fluxbox`. Here are common dotfiles and dot directories found in your $HOME directory.

	.bashrc
	.profile
	.vimrc
	$HOME/.config/
	$HOME/.ssh/
	$HOME/.gitconfig/

FOSS programmers have given us amazing choices to use when wrangling our dotfiles. You can try [rcm](https://github.com/thoughtbot/rcm) from the amazing coders at [Thoughtbot](https://thoughtbot.com/). [Homesick](https://github.com/technicalpickles/homesick) seems to have its fans. Besides being a french word that I probably shouldn't attempt to say out load [Chezmoi](https://www.chezmoi.io/) can take your dotfile management to a whole new level. This tutorial by Ryan Walter will get you started with this powerful tool ["Take back your dotfiles with Chezmoi"](https://fedoramagazine.org/take-back-your-dotfiles-with-chezmoi/). You can find others that I failed to mention, but I like [yadm](https://yadm.io/) as my dotfile wrangler.

Each of the above mentioned tools use *git* for version control, but wrangle dotfiles differently. I decided to avoid tools that depend on symlinks. This took rcm and homesick out of the running. I recognized the power in Chezmoi, but tapping into that power would require adapting to a new workflow for editing my dotfiles. I like to edit my dotfiles by using whatever text editor I feel like using in the moment. Chezmoi requires you to edit your config files using the chezmoi command or at least use an alias or a shortcut. Yadm doesn't get involved while editing dotfiles. Instead if just keeps track of when you edit a dotfile and if it has been synced to the remote repository. Basically, *yadm* is a wrapper for *git* that enables you to use your $HOME directory as your git repo, which it manages for you. Yadm won't automatically add all of the files in your $HOME directory, that would be disastrous. You can add specific dotfiles and dot directories that live in your $HOME directory. To get started, go to the [yadm site](https://yadm.io/). Read their documentation, and while you are there admire their beautifully executed modern web page. You can run through the [basics](https://yadm.io/docs/overview#).

Besides the excellent docs above, I would like to highlight a few things that tripped me up after installing yadm. I would also like to note that some of these issues may not occur if you are using the latest version of yadm. Yadm 2.5 was released recently on their GitHub page, but the version I used from the Debian stable repo is yadm 1.12. There have been significant changes to yadm 2.0 and above. Some features mentioned in their documentation may need a more recent version.

1. Install git and configure git before using yadm to avoid issues. You set up git with the following commands.

```
	$ git config --global user.name "John Doe"
	$ git config --global user.email johndoe@example.com
```

2. Because yadm is a wrapper for git, error messages will contain *git* commands and flags.

This confused me when I first started using yadm. I would see those error messages, and I would copy the suggested solution exactly into the terminal and run the command, but often it returned the error `fatal: not a git repository (or any of the parent directories): .git`. I would get that error message because I was trying to run a git command inside my `$HOME` directory which is not a git repository. However, it is an easy fix to replace *git* with *yadm* and the command would run as expected.

3. Yadm documentation mentions the step of connecting your local yadm managed dotfiles with a remote git repository on [Github](https://github.com/) or [Gitlab](https://about.gitlab.com/) or your own self hosted git server solution. After I connected my local git repo created with yadm to my GitHub repo, new issues arose.

I will be the first to admit that my *git foo* is not strong. You might find a different solution that avoids this issue completely. My normal workflow with git repositories is to create a new repository on Github, clone the repository to my local machine, and then add files and push those files up to the Github hosted repository. Because you are using yadm to manage dotfiles in your home directory, I had to use a different workflow. Using yadm I initialized the git repository on my local machine. I created a "dotfiles" repository on Github that I intended to use with yadm. After I added my Github dotfiles repository as the *origin master*  I wanted to start pushing my files up to Github, but the following command failed.


	$ yadm push -u origin master
	To github.com:mowestusa/dotfiles.git
 	! [rejected]        master -> master (non-fast-forward)
	error: failed to push some refs to 'git@github.com:mowestusa/dotfiles.git'
	hint: Updates were rejected because the tip of your current branch is behind
	hint: its remote counterpart. Integrate the remote changes (e.g.
	hint: 'git pull ...') before pushing again.
	hint: See the 'Note about fast-forwards' in 'git push --help' for details.


Okay, no problem, I will just run `yadm pull` and everything will be okay, but it wasn't.

	$ yadm pull origin master
	From github.com:mowestusa/dotfiles
	 * branch            master     -> FETCH_HEAD
	fatal: refusing to merge unrelated histories
	
Now I'm stuck. I can't *push* or *pull* to or from the Github hosted repository. If you have sharper *git foo*, you will recognize the problem immediately. In my normal workflow this never happens, because I start by creating an empty repository on Github, I clone that empty repository to my local computer, and then I begin filling that empty directory with files that I want to manage with git. In my normal workflow I never run into an unrelated histories issue because I'm not trying to connect two git repositories that have different initialization times. Because I created the local git repository using yadm and the remote git repository using GitHub's interface, I created two different repos with two different histories. Thankfully, the fix was simple.

	$ yadm pull origin master --allow-unrelated-histories
	From github.com:mowestusa/dotfiles
	 * branch            master     -> FETCH_HEAD
	Merge made by the 'recursive' strategy.
 	README.md | 2 ++
 	1 file changed, 2 insertions(+)
 	create mode 100644 README.md

	$ yadm push -u origin master
	Enumerating objects: 741, done.
	Counting objects: 100% (741/741), done.
	Delta compression using up to 2 threads
	Compressing objects: 100% (694/694), done.
	Writing objects: 100% (740/740), 9.49 MiB | 216.00 KiB/s, done.
	Total 740 (delta 36), reused 0 (delta 0)
	remote: Resolving deltas: 100% (36/36), done.
	To github.com:mowestusa/dotfiles.git
   	master -> master
	Branch 'master' set up to track remote branch 'master' from 'origin'.
	
The first command allowed those unrelated histories and merged the README.md file into the local repository. My `yadm push` command was successful too. If you want to learn more about unrelated histories of git repositories you can start here with [Github Documentation](https://docs.github.com/en/github/using-git/dealing-with-non-fast-forward-errors) or this [Stackoverflow Question](https://stackoverflow.com/questions/37937984/git-refusing-to-merge-unrelated-histories-on-rebase). Now that I understand what is happening, I recognize the value of this git feature that protects against accidentally overwriting an important file. In this case the *README.md* really wasn't very important.

*Yadm* has plenty of features that I am not using. The other dotfile managers that I mention above provide similar functionality. Take a look at them, you might find that one of them works better with the way you work or the way your brain works. I believe *yadm* works best for situations where you plan to run the same Linux Distribution, the same window manager or desktop environment, and the same FOSS programs on a regular basis between two different systems. Since I have been spending more time in MX-Linux and *yadm* is in the Debian stable repos that also helped to sway my decision towards *yadm*. What will you discover that works best for wrangling your dotfiles? Trust me. Skip the USB flash drive, cobbled-together rsync scripts, and sneakernet. There are better options.

*Original header image by [VViktor](https://pixabay.com/users/VViktor-5823236/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2826195) from [Pixabay](https://pixabay.com/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2826195). Image effects were created using the FOSS [Krita](https://krita.org/en/), [figlet](http://www.figlet.org/), and [lolcat](https://github.com/busyloop/lolcat).*
