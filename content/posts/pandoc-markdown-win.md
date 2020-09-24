---
title: "Pandoc and Markdown for the Win"
date: 2020-09-23T23:18:25-04:00
draft: false
categories:
- Articles
tags:
- markdown
- pandoc
---

![Runner Near Finish Line](/img/pandocandmarkdown.png)

When real life intersects my love of FOSS, I get excited. I've been working with a physical therapist to learn exercises to prevent future lower back injures. My physical therapist opens our session by asking how frequently I did the exercises that he assigned, and how they went. I decided that instead of trying to recall 3-7 days of exercises, I would keep a log. Since I'm a geek, I kept my log in plain text. Since I did my editing in Linux with [Featherpad](https://GitHub.com/tsujan/Featherpad), I ran into an unexpected problem. I had a copy of the text file on my phone, but my physical therapist asked me to email him the log so he could print it out. After I emailed the text file to him, he disappeared into a back office for a while. When he returned he told me that he had to reformat the file so he could read it. When he showed me his computer screen with my text file open in a Windows editor, I immediately realized what happened.

Linux text files use different unseen characters to mark the end of a paragraph from a plain text Windows file. The Windows program used by my physical therapist failed to recognize these ending paragraph characters and smashed the whole log into 3 dense lines of text. The exercise log was a good idea, but I needed a better solution that my physical therapist could print and read easily. I'm still a geek, and I wanted to keep my log in plain text. I have dabbled with [ASCIIDOC](https://asciidoctor.org/) which acts as a plain text markup tool that can be converted into HTML easily. This blog has helped me learn Markdown. If I could find a tool to convert a Markdown text file into a PDF, I would have a solution for my exercise log. A few internet searches pointed me to [Pandoc](https://pandoc.org/) as my "Markdown to PDF" solution.

Pandoc is a super powered tool in Linux enabling you to convert from one text file format to another. It has extensive support for multiple versions of Markdown including adding types of formatting that the original Markdown syntax never had. In order to convert from Markdown into PDF, Pandoc harnesses the power of LaTeX, an advanced plain text markup language. LaTeX enables authors to include codes in their plain text documents that can be transformed into the complex formatting needed in academic and research papers and books. Besides installing Pandoc, you may need to install additional modules for Pandoc and you may have to a large number of the LaTeX tools that Pandoc will leverage to create the PDF document. I would encourage you to read some documentation in our Linux distribution of choice about Pandoc and LaTeX packages.

Once I had all of the necessary packages installed, a simple command in the terminal did all of the magic.

	pandoc PTlog.md -o PTlog.pdf --from=markdown -V geometry:margin.5in
	
The above command took my physical therapy exercise log and turned it into a printable, easy to read PDF. My physical therapist was thrilled when I sent the first PDF a few minutes before our appointment. He could easily read the log on his computer or print out a copy so that he could make hand written notes on it as he reviewed and taught new exercises.

Once I discovered the power of Pandoc, I found another use. Every week I convert a document that I write into a PDF to be emailed to someone. I convert it into a PDF because I don't know what kind of word processor she has installed on her computer so I don't want to risk sending the document in LibreOffice or MSWord. Now instead of authoring that weekly document in LibreOffice, I type it in Markdown and convert it using Pandoc into a well formatted PDF.

As I read the documentation for Pandoc I discovered that Pandoc supports its own version of Markdown. Pandoc's version of Markdown adds formatting options that are not available in other versions of Markdown. I discovered that Pandoc's version of Markdown supports several different kinds of tables. I had to try this out for my exercise log. If I could put all of my exercises into a table than it would be even easier to read. The syntax for creating tables in Markdown files includes lots of dashes, pipes, and other symbol characters to lay out the rows and columns. This could quickly become tedious, but the following website makes this process a breeze, [Tables Generator](https://https://www.tablesgenerator.com/markdown_tables#).

Now with a slight change to my Pandoc command, I can have a PDF with beautiful tables.

	pandoc PTlog.md -o PTlog.pdf --from=markdown+pipes_tables -V geometry:margin.5in
	
Wait a minute! LibreOffice Calc could easily create a table and covert it into a PDF. Yes, LibreOffice could do this same job. However, I find that plain text documents are the most portable file format on computers. I can easily edit a text file on Linux, Windows, or even on my Android phone. A plain text file is tiny so it makes it easy to sync multiple text files to my phone without the worry of filling up my limited storage space on my phone. Using plain text also means that I don't have to worry about having access to the internet to edit the document, because I have a local copy of the document that I can edit even when I'm not connected or when I don't have cell service.

If this article has peaked your interest in the possibilities of converting a Markdown file into a PDF, than I would encourage you to head over to the [Pandoc](https://pandoc.org/) site for more information. Their documentation is great. Now I have another reason to use FOSS on Linux everyday.

The original picture featured in the header graphic to this article is found [here](https://live.staticflickr.com/5567/14724418849_c2b37f6125_b.jpg "Finish Line Approach - Castlepollard 5KM 2014") and was taken by [Peter Mooney](https://www.flickr.com/photos/25874444@N00) and is licensed under [CC BY 2.0](https://creativecommons.org/licenses/by/2.0/?ref=ccsearch&atype=html).
