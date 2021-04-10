---
title: "Docsify a Different Animal"
date: 2021-04-09T20:10:00-05:00
draft: false
categories:
- Articles
tags:
- markdown
- docsify
- SSG
---

![Docsify Icon on a Spotted Cow](/img/docsify-animal.png)

I thought I would break the silence on this [Hugo Powered](https://gohugo.io) blog with a post about another SSG [Static Site Generator](https://jamstack.org/generators). [Docsify](https://docsify.js.org) is a SSG that is truly a different kind of animal. To illustrate the difference, let me start by mapping my current workflow to make a post using Hugo as my SSG.

1. Make sure I have the latest version of Hugo on my local machine. Admittedly, because it is written in Golang and comes as a single binary this is pretty easy. On my Debian workstations, I download the released deb package and install using the simple command replacing the deb package name with the latest released version of Hugo.

```
sudo apt install ./hugo_0.82.0_Linux-64bit.deb
```

* On Fedora, I have installed a COPR repo that has the latest version of Hugo, so every time there is an update, I pull down the latest Hugo version.

2. At this stage if you don't already have a Hugo site, you will need to use the Hugo tools to create the skeleton of directories and files that you need to begin authoring your site. You will also need to install a Hugo theme that will create the look of your site. Once you have installed your theme into the proper directory and edited your config.toml file you can begin creating posts and content for your site.

3. Since [discoverfoss.com](https://discoverfoss.com) has step 2 done, I can jump into creating content. For me this begins with the creation of a Markdown file in the **posts** directory.

4. After the post is ready to be posted on the blog, the fun begins with Hugo. I run a `bash` script that does the following steps:
    * Runs `hugo` to create the static html pages in a separate `git` repository.
    * Runs `git add .` in that repository
    * Runs `git commit -m "Blog Updated on $(date)"`
    * Runs `git push` which pushes the newly created static HTML pages up to the repo on *github.com* that hosts the site through *Github Pages*.

All of the steps of 4 take mere seconds. First, because Hugo is fast when it builds a static site, and second, because I have my SSH keys saved in Github enabling me to `git push` using SSH which saves me the step of having to enter my password.

In general, SSG's typically follow above workflow where you use a local install of the SSG to create the static site from your Markdown documents, and then you will SFTP, Rsync, or git push your static files to your web server or hosting provider. There appear to be hosted solutions or continuous integration pipelines that will remove the need for a local install of the SSG, but I haven't looked into those options for [discoverfoss.com](https://discoverfoss.com) at this time.

Docsify is a different animal in the SSG world. You can install a local CLI (command line interface) version of Docsify on Linux, but I have not seen the need to do so. You may want to consider that if you want to see a local instance of Docsify on your workstation where you are authoring the Markdown documents for Docsify. Additionally, Docsify shows you how you can with just a few lines of Python spin up a web server to see your local content in a browser. Since Python is usually installed in the major distributions, I feel this is an easier solution than setting up a local CLI of Docsify with all of its dependencies.

Docsify caught my attention months ago, when I looked into options for creation webpages of documentation for a FOSS project that is near and dear to my heart. At first, I considered just using Hugo and one of its templates which are geared towards documentation projects. Hugo would be an excellent solution, but since Docsify focuses on displaying project documentation, and is designed to work well with *Github Pages* I felt Docsify was a better solution.

Yet, what pushed me into trying Docsify was my desire to have a personal, searchable, organized, wiki written in Markdown or ASCIIDOC files. Although, I enjoy writing my FOSS adventures in this blog, there are notes and documentation that I use everyday that I don't need in a blog post. As an example, while I continue to learn [vim]({{< ref "/sharpentools" >}} "Sharpening Your Tools") I have a notes file that has keyboard shortcuts that I have not committed to memory, but still find useful a few times a week. I also like to lay out the steps that I performed to get something installed and working in the homelab. Sometimes those turn into tutorials for this blog, but other times there are steps that I'm copying down from a variety of sources for my unique setup which would be of little value for the wider FOSS community. I have used a variety of tools for this in the past. When I lived in Windows and used more proprietary software, I used *Evernote* until their "free" option became too limited, then I switched to *Onenote*. In Linux, I have used something as simple as a directory filled with text files that was synced with [Syncthing](https://syncthing.net) between all my machines to a more robust tool like [Zim](https://zim-wiki.org). Docsify let me check the following boxes which caused it to win in the contest of what will serve as my personal wiki.

* I can do all of my documentation in Markdown. Since I'm already writing in Markdown for this blog, and using Markdown to the creation of printable PDF's, adding another use for my Markdown skills was a plus.
* I can easily host a Docsify site on a Raspberry Pi 1 Model B. Yes, I still have a 1st generation Raspberry Pi, actually two of them, and I wanted to find ways to keep these little SBC serving a useful purpose. Since Docsify uses static HTML and client side JavaScript the old Raspberry Pi just needs to serve up the files, for which I am using [Lighttpd](https://www.lighttpd.net).
* It is easy to add search to Docsify.
* It is easy to add a dark theme to Docsify.
* It is easy to have a full featured sidebar.
* The active community have coded amazing plugins for Docsify that you can use too.
* I believe Docsify would be a great solution for a FOSS project that hosts its files on Github because of the excellent support Docsify has for Github Pages. This opens Docsify up for future uses as I contribute to other FOSS projects.

Now, what makes Docsify a different animal? Docsify is an SSG, but it skips the build step of most SSG's. Instead of reading in the Markdown files and converting a series of HTML files from those, Docsify converts the Markdown files on the fly. Docsify is up and running by creating a single `index.html` file which references remotely served JavaScript files. The main JavaScript file finds the Markdown files in the root directory where `index.html` is found along with subdirectories if used, and converts those Markdown files on the fly into HTML and includes their content in the resulting index.html file that is generated for the browser. This means your server is not being stressed. With my personal wiki that I'm serving on my Raspberry Pi 1 Model B I haven't noticed a lag in loading pages or when searching the collection of files. I will have to see if an increase in files and content slows down Docsify's performance as time goes on. If you follow their instructions you would be linking to a series of remotely hosted JavaScript files and at least one CSS file for the theming. This means you are putting some trust in the makers of Docsify that nothing malicious is being done in those JavaScript files. Of course, it should work to source those files, review their code, and then host them locally on your server as well, but you would miss out on minor version bumps and bug fixes.

Just one look at the [Jamstack list](https://jamstack.org/generators) that I referenced above proves that there are plenty of possible solutions in this world of SSG's. For me, Hugo and Docsify, have become personal favorites. What SSG do you use and love? How do you use SSG's in your homelab to serve up information that you want access to?

*The header image for this article was assembled in [Krita](https://krita.org/) using a cow image provided by [Matias Tapia](https://unsplash.com/@photomatic_s?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com) and the Docsify logo.*

