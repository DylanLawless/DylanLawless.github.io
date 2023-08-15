---
layout: post
title: Cryptography
created: 27 Feb 2012
tags: statistics
status: finished
---

{{ page.title }}
================

<p class="meta">26 Apr 2020</p>

1. [Introduction](#introduction)
2. [Breaking crypto](#breaking)
3. [AES is the most important current encryption method](#aes)
4. [Quantum computing](#quantum)
5. [Some thoughts](#thoughts)
6. [Reading list on more advanced topics](#reading)  

<a name="introduction"></a>

# Introduction

Like most of the posts on this blog, this will be a work in progress. Cryptography is a topic which I stumbled upon and really enjoy.
For the reading list skip to the end of this page.
There is a long interesting history which would appeal to a casual reader.
Most people would be familiar with stories about crypto during WWII, particularly because of movies like
<span style="color: #0000ff;">[The Imitation Game<span id="titleYear">(2014).
</span>](http://www.imdb.com/title/tt2084970/)</span>
Cracking of Enigma falls into the espionage theme along with stories like that of books from  <span class="author notFaded" style="color: #0000ff;"><span class="a-declarative">[Ben Macintyre.](https://www.amazon.co.uk/Ben-Macintyre/e/B001H6WAL8/ref=dp_byline_cont_book_1) </span></span>One of my favorites is: <span id="productTitle" class="a-size-large"><span style="color: #0000ff;">[Operation Mincemeat](https://www.amazon.co.uk/d/Books/Operation-Mincemeat-True-Story-Changed-Course-World/1408809214):</span> The True Spy Story That Changed the Course of World War II. </span>
Reading so much about the non-fiction side of this topic ultimately led me to the <span style="color: #0000ff;">[Ian Flemming novels](https://en.wikipedia.org/wiki/List_of_James_Bond_novels_and_short_stories).</span> Of course I had seen all the movies as a kid, and like most, loved them. Reading the novels in their order of release ended up being much more fun than I have with most fictional book series perhaps because of Flemming's true involvements during WWII.

Gentle brushing against the topic of cryptography with these classical stories  eventually lead me to an interest in modern crypto. Real, crypto! Like most sciences portrayed in popular culture, it really only gets interesting when you get into the technical reading.
Computerphile has several good videos on cryptographic topics. This video describes SHA1 in a way that I find quite interesting. This is just about hashing methods but it is a lovely introduction to crypto.
[www.youtube.com](https://www.youtube.com/watch?v=DMtFhACPnTY)
Another video from the series now gets to actual crypto  in the same entertaining way; [End to End Encryption (E2EE)](
https://www.youtube.com/watch?v=jkV1KEJGKRA).

<a name="breaking"></a>
# Breaking crypto
Learning the basics of crypto and how it's broken is best done at the same time. Of course actually breaking the crypto is difficult. But understanding it doesn't have to be. To learn this you can quickly get the main points about modular arithmetic, exponentiation, and periods in this video.
[Shor’s algorithm](
https://www.youtube.com/watch?v=12Q3Mrh03Gk)

I think getting a clear grasp on the topic relies on getting used to modular arithmetic. For example on a clock we use Mod 12\. If you get up at 12am and the time is now 1pm well then obviously you have been up for 13 hours. **13 mod 12 = 1**.
You know just as well that if you get up at 7am and it is now 8pm you have also been up for 13 hours. We can do this in our head very easily, and can do other examples easily too if you get over the initial confusion. **A/B = Q remainder R**. In some cases we only care about the remainder R. In that case we say: **A modulo B is equal to R**. Where B is referred to as the modulus (or mod for short).
The only difficulty is when the numbers become quite large.
<span style="color: #0000ff;">[Here is a page that describes this very well. ](https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/what-is-modular-arithmetic)</span>

This video is summed up with the 4 steps. The reason that RSA works is because Step 2, finding the period, takes a very long time:

![rsa](https://dylanlawlessblog.files.wordpress.com/2017/02/rsa.png)

Quantum computing is expected to dramatically speed up this step.
Another good intro video that has some interesting discussion on Diffie-Hellman key exchange was given at the Chaos Communication Congress:
J. Alex Halderman, Nadia Heninger: Logjam: Diffie-Hellman, discrete logs, the NSA, and you.

“Earlier this year, we discovered that Diffie-Hellman key exchange – cornerstone of modern cryptography – is less secure in practice than the security community believed. In this talk, we’ll explain how the NSA is likely exploiting this weakness to allow it to decrypt connections to at least 20% of HTTPS websites, 25% of SSH servers, and 66% of IPsec VPNs.”
[www.youtube.com](https://www.youtube.com/watch?v=mS8gm-_rJgM)

Applied Cypto Handbook is a very good technical introduction and probably as far as a general reader will ever want to go.
<span style="color: #0000ff;">[http://cacr.uwaterloo.ca/hac/](http://cacr.uwaterloo.ca/hac/)</span>

<a name="aes"></a>
# AES is the most important current encryption method
This lecture is the perfect intro if you already know what methods are out there.
[www.youtube.com](https://www.youtube.com/watch?v=x1v2tX4_dkQ)
The accompanying book is worth the money if you're looking for a textbook. The table of contents is available on amazon.
<span style="color: #0000ff;"> [http://www.crypto-textbook.com.](http://www.crypto-textbook.com)</span>
Here is a link to <span style="color: #0000ff;">[Galois' wiki.](https://en.wikipedia.org/wiki/Évariste_Galois#Galois_theory)</span>
This might lead you down a wiki rabbit hole learning about interesting maths.

<a name="quantum"></a>
# Quantum computing
Here are simply two videos from PBS that will be more entertaining and succinct at discussing this really interesting topic than I.
[How quantum computing works](https://www.youtube.com/watch?v=IrbJYsep45E)
How might quantum computing destroy computer security?
[By utilising Shor’s algorithm](https://www.youtube.com/watch?v=wUwZZaI5u0c)

A fun little topic brought up in this videos is: that quantum Fourier transform uses resonance to amplify the basic state associated with the correct period.
If you’re reading this site then it’s likely that you are a biologist.
If that is the case you may be more familiar with protein structures than quantum mechanics.
I first became introduced to the practical application of Fourier transformation while learning nuclear magnetic resonance (NMR) spectroscopy for protein structuring.
Of course, you don’t actually have to learn it to do NMR.
It happens automatically during data analysis but most people in the field surely would still like to know the details.
Wiki has a great page: [https://en.wikipedia.org/wiki/Fourier_transform](https://en.wikipedia.org/wiki/Fourier_transform)
![ft](https://dylanlawlessblog.files.wordpress.com/2017/02/ft.png)
“In NMR an exponentially shaped free induction decay (FID) signal is acquired in the time domain and Fourier-transformed to a Lorentzian line-shape in the frequency domain.”

The next main point addressed in this video is: Complex roots of unity.
This is introduced quite well in the video.
If you have never seen anything like this before then I highly recommend the short book by Feynman;
[QED: The Strange Theory of Light and Matter](https://www.amazon.co.uk/dp/B00BR40XJ6?ref_=k4w_oembed_ICZkE7ckZ2ZUfR&tag=kpembed-20&linkCode=kpd)
<!--
(https://www.amazon.com/QED-Strange-Princeton-Science-Library/dp/0691164096/ref=sr_1_1?s=books&ie=UTF8&qid=1494067439&sr=1-1&keywords=qed+the+strange+theory+of+light+and+matter)
-->
In no way does this little book talk about quantum computing.
If fact it is pretty old now and is not the kind of thing that professionals will be using for reference.
Why would I suggest this for someone who is new to the topic? Well it is an extremely fun introduction to the topic of QED and lays the foundation of ideas that have become mainstream over the next 30 years.
Understanding some basic ideas will leave you open to recognise more complex applications, especially important if you want to only look at the basics of quantum computing.

<a name="thoughts"></a>
# Some thoughts
This talk at Google by Peter Warren Singer based on his book,
<span style="color: #0000ff;">[Cybersecurity and Cyberwar](https://www.amazon.com/Cybersecurity-Cyberwar-Everyone-Needs-Know%C2%AE/dp/0199918112)</span>,
may be a pretty interesting watch for anyone into technology security in some way. This is not a technical talk, more of something to get you into the mindset up why this topic may be interesting.
[www.youtube.com](https://www.youtube.com/watch?v=h0SXO5KUZIo)
[<span style="color: #0000ff;">https://www.cl.cam.ac.uk/~rja14/book.html</span>](https://www.cl.cam.ac.uk/~rja14/book.html) Security Engineering — The Book

The cryptopals crypto challenges are a fun way to learn some hands on application of cryptographic techniques. <span style="color: #0000ff;">[http://www.cryptopals.com/](http://www.cryptopals.com/)</span>

Announcing the first SHA1 collision on February 23, 2017.
This was a really big event in the crypto community.
I think many people in the cyber security field assume that experiments and findings in public and academic research are a few years behind government capabilities.
Take from that what you will.
<span style="color: #0000ff;">[https://security.googleblog.com/2017/02/announcing-first-sha1-collision.html](https://security.googleblog.com/2017/02/announcing-first-sha1-collision.html)</span>

There are countless reasons why crypto is interesting.
The applications range from the most mundane day to day requirements in the modern world such as banking, personal communication, the use of medical data (which I post about here <span style="color: #0000ff;">[Pretty good privacy for academic data](https://dylanlawlessblog.wordpress.com/2017/02/21/pretty-good-privacy-for-academic-data/)</span>) all the way out to the most hypothetical academic applications.
An interesting point to think about is the journey that each data packet makes across the mystical _internet_.
Most electronic communications travel across a number of boarders and further distances than most people will travel in their entire life.
Our world would not run very smoothly if all communication was sent in a readable format with no protection.
Here is some basic info on the infrastructure require for modern electronic communication:
[www.youtube.com](https://www.youtube.com/watch?v=DKHZKTRyzeg),
[www.youtube.com](https://www.youtube.com/watch?v=0TZwiUwZwIE)
And the <span style="color: #0000ff;">[Submarine Cable Map](http://www.submarinecablemap.com)</span>.

While we're on the topic, I found this video on the Cornwall cable landing station.
The physical infrastructure and engineering requirements of global communication are sometimes easy to forget if one spends more time on computer programming or mathematics
[www.youtube.com](https://www.youtube.com/watch?v=K_nnUbX7uuQ).

<a name="reading"></a>
# Reading list on more advanced topics
/r/crypto wiki  
<span style="color: #0000ff;">[https://www.reddit.com/r/crypto/wiki/index](https://www.reddit.com/r/crypto/wiki/index)</span>  
Textbook: An Introduction to Mathematical Cryptography  
<span style="color: #0000ff;">[http://citeseerx.ist.psu.edu/viewdoc/download;jsessionid=5F72903FBACA6DF57799612526CC437F?doi=10.1.1.182.9999&rep=rep1&type=pdf](http://citeseerx.ist.psu.edu/viewdoc/download;jsessionid=5F72903FBACA6DF57799612526CC437F?doi=10.1.1.182.9999&rep=rep1&type=pdf)</span>  
Cryptology ePrint Archive  
<span style="color: #0000ff;">[http://eprint.iacr.org](http://eprint.iacr.org)</span>  
Handbook of Applied Cryptography  
<span style="color: #0000ff;">[http://cacr.uwaterloo.ca/hac/](http://cacr.uwaterloo.ca/hac/)</span>
Goldreich: The Foundations of Cryptography  
<span style="color: #0000ff;">[http://www.wisdom.weizmann.ac.il/%7Eoded/foc-drafts.html](http://www.wisdom.weizmann.ac.il/%7Eoded/foc-drafts.html)</span>  
Handbook of Elliptic and Hyperelliptic Curve Cryptography  
<span style="color: #0000ff;">[http://www.hyperelliptic.org/HEHCC/](http://www.hyperelliptic.org/HEHCC/)</span>  
eBACS: ECRYPT Benchmarking of Cryptographic Systems  
<span style="color: #0000ff;">[http://bench.cr.yp.to](http://bench.cr.yp.to)</span>  
Mihir Bellare and Shafi Goldwasser's Lecture Notes  
<span style="color: #0000ff;">[http://cseweb.ucsd.edu/%7Emihir/papers/gb.pdf](http://cseweb.ucsd.edu/%7Emihir/papers/gb.pdf)</span>  
Charm: A tool for rapid cryptographic prototyping  
<span style="color: #0000ff;">[http://www.charm-crypto.com/index.html](http://www.charm-crypto.com/index.html)</span>  
eHash Wiki  
[Hash Function Zoo](http://ehash.iaik.tugraz.at/wiki/The_Hash_Function_Zoo)  
and the [SHA-3 Zoo](http://ehash.iaik.tugraz.at/wiki/The_SHA-3_Zoo)  
<span style="color: #0000ff;">[http://ehash.iaik.tugraz.at/wiki/The_eHash_Main_Page](http://ehash.iaik.tugraz.at/wiki/The_eHash_Main_Page)</span>  
Cryptology ePrint Archive  
<span style="color: #0000ff;">[http://eprint.iacr.org](http://eprint.iacr.org)</span>  
IACR Conferences (Crypto, Eurocrypt, Asiacrypt)  
<span style="color: #0000ff;">[http://www.iacr.org/conferences/](http://www.iacr.org/conferences/)</span>  
IEEE Symposium on Security and Privacy (There are loads of papers and talks on YouTube under Program of past events)  
<span style="color: #0000ff;">[https://www.ieee-security.org/TC/SP2017/past.html](https://www.ieee-security.org/TC/SP2017/past.html)</span>  
Crypto Stack Exchange  
<span style="color: #0000ff;">[https://crypto.stackexchange.com](https://crypto.stackexchange.com)</span>  
Blogpost so-you-want-to-crypto  
<span style="color: #0000ff;">[https://www.seancassidy.me/so-you-want-to-crypto.html](https://www.seancassidy.me/so-you-want-to-crypto.html)</span>  
Authenticated Encryption Zoo  
<span style="color: #0000ff;">[https://aezoo.compute.dtu.dk/doku.php?id=AE%20Zoo](https://aezoo.compute.dtu.dk/doku.php?id=AE%20Zoo)</span>  
Helger Lipmaa Cryptology Pointers  
<span style="color: #0000ff;">[http://kodu.ut.ee/~lipmaa/crypto/](http://kodu.ut.ee/~lipmaa/crypto/)</span>  
Free Course: Applied Cryptography  
<span style="color: #0000ff;">[https://www.udacity.com/course/applied-cryptography--cs387](https://www.udacity.com/course/applied-cryptography--cs387)</span>  
Kerckhoffs's principle  
<span style="color: #0000ff;">[https://en.wikipedia.org/wiki/Kerckhoffs%27s_principle](https://en.wikipedia.org/wiki/Kerckhoffs%27s_principle)</span>  
Schneier's Law  
<span style="color: #0000ff;">[https://www.schneier.com/blog/archives/2011/04/schneiers_law.html](https://www.schneier.com/blog/archives/2011/04/schneiers_law.html)</span>  
crypto blogs from David Wong's github  
<span style="color: #0000ff;">[https://github.com/mimoo/crypto_blogs](https://github.com/mimoo/crypto_blogs)</span>  
Shor in Haskell The Quantum IO Monad  
<span style="color: #0000ff;">[http://www.cs.nott.ac.uk/%7Epsztxa/publ/qio.pdf](http://www.cs.nott.ac.uk/%7Epsztxa/publ/qio.pdf)</span>  
The Quipper Language: programming language for quantum computing  
<span style="color: #0000ff;">[http://www.mathstat.dal.ca/%7Eselinger/quipper/](http://www.mathstat.dal.ca/%7Eselinger/quipper/)</span>  

<!-- 
![encrpytdata](https://i.imgur.com/UubXs0H.gif)
-->
