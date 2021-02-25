---
layout: post
title: The devil is in the detail
created: 19 Aug 2019
tags: statistics
status: finished
---

{{ page.title }}
================

<p class="meta">19 Aug 2019</p>
I was learning some <span style="text-decoration: underline;"><span style="color: #800080;">[steganography](https://en.wikipedia.org/wiki/Steganography)</span></span> methods for a security project. 
At the same time, I was writing up a paper with some friends ([https://link.springer.com/content/pdf/10.1007%2Fs10875-019-00670-z.pdf](https://link.springer.com/content/pdf/10.1007%2Fs10875-019-00670-z.pdf)) and decided to hide a little message in one of the figures.
The goal was to encode some hidden data and see could we get it back out the other side, after publication. 

It would be a lot of trouble for a master of espionage to have to publish a paper every time a secret message needed to be encoded for public transmission, but maybe it could be done! 

<img src="{{ site.baseurl }}{% link images/posts/editor_paper_rag.png %}" width="100%">

The secret message was imported into [R](https://www.r-project.org) from plain text. 
It was encoded it into a png file that was a supplemental figure in our paper (from experience, supplemental figures usually get uploaded to a repository that can be downloaded after publication, while main-text figures are often converted in one way or another by the copy editors). 
Once the figure was released, anyone with the correct decoding algorithm could get back the secret message. 

In this case I used the 
[richfitz/stegasaur](https://github.com/richfitz/stegasaur) package, 
innocently offered with "The aim is to be able to encode arbitrary R objects in cat pictures." 
The inforation was hidden within the data that makes up the image, and is imperceivable to the naked eye. 
Even better, the file size was slightly SMALLER than the original (1.9MB to 1.7MB) without noticeable difference in quality. 
The secret message decoded from the protein structure figure "F_E4_Structure.png" and is printed to the console: 

<img src="{{ site.baseurl }}{% link images/posts/r_steg_decode.png %}" width="100%">

Here's an idea, [steganographic message blocks](https://patents.google.com/patent/US8527779) seperated across a career worth of publications, 
that can only be deciphered once all blocks are collected! 
Who would go to that trouble? 
Go see what you can find in one Supplementary material png file. 
[https://link.springer.com/article/10.1007%2Fs10875-019-00670-z](https://link.springer.com/article/10.1007%2Fs10875-019-00670-z)

# R script 
Try it yourself.
Find the paper and get Figure E4.
Download
[10875_2019_670_MOESM5_ESM](https://link.springer.com/article/10.1007%2Fs10875-019-00670-z#SupplementaryMaterial)
```
> install.packages("devtools")
> install_github("richfitz/stegasaur")
> library("devtools")
> library(ggplot2) 
> Decode message <- 
>		stegasaur::decode("~/10875_2019_670_MOESM5_ESM.png")
```
