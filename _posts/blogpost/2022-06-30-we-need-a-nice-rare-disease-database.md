---
layout: post
title: We need a nice rare disease database
date: 2022-06-30 00:00:01
tags: genomics
status: unfinished
---

{{ page.title }}
================
<p class="meta">30 June 2022</p>

<!-- * TOC -->
<!-- {:toc} -->

## What is this?

This short post is to demonstrate a problem and a solution as an example of why I add these things to my public page. 
It is just one of the hundreds of small, modular datasets that I build and cross-link for all my public and private LawlessGenomics work.
For precision medicine we need countless small, efficient, connected, tools in a consisten format. 
This is one example.

## Problem

Diagnosing rare immune disorders is very challenging.
A fast checklist of candidate genes is required.

## One step to the solution

One of the most important resources for clinical immunology genetics is the yearly report of the
Inborn Errors of Immunity (IEI) Committee by the International Union of Immunological Societies (IUIS)
(<a href="https://iuis.org/committees/iei/">https://iuis.org</a>),
{% cite tangye2022iei %}. 
Read the paper here:
<a href="https://link.springer.com/article/10.1007/s10875-022-01289-3">doi.org/10.1007/s10875-022-01289-3</a>
and directly download their original xlsx table from Springer here:
<a href="https://static-content.springer.com/esm/art%3A10.1007%2Fs10875-022-01289-3/MediaObjects/10875_2022_1289_MOESM2_ESM.xlsx">Supplementary file2 (XLSX 93 kb)</a>.

## However

Because of traditional publishing protocols, there is a major problem. 
To use this dataset you must either:
1. Download and save an XLSX table ([download](https://static-content.springer.com/esm/art%3A10.1007%2Fs10875-022-01289-3/MediaObjects/10875_2022_1289_MOESM2_ESM.xlsx)).
2. Bookmark the webpage and [view a png screen-shot of each table](https://link.springer.com/article/10.1007/s10875-022-01289-3/tables/1).
3. Download the pdf version and view an embedded [pdf](https://link.springer.com/content/pdf/10.1007/s10875-022-01289-3.pdf) of each table.

## Better solution 

For years, I have made personal databases of gene lists which I query very often. 
Every bioinformatician also uses large sets of databases for annotation. 

I notice a huge gap for clinicians, etc. who also need this info but have to rely on looking up the paper each time.
One good example of the correct method is the Genomics England PanelApp
<https://panelapp.genomicsengland.co.uk>.

I want a fast, searchable version of the IUIS IEI gene list.
So I made it here:

* [Human Inborn Errors of Immunity]({{ site.baseurl }}{% link _topic/precision_med/iuis_iei_table_page.html %}).

## Why is this better?

I don't just want to confirm that my query gene is an _immune disorder-related gene_, I want to quickly get a lot of facts about it.
Bioinformatically, I would add all this data in one step using my variant effect pipeline. 
However, I usually look this stuff up while on the go, in a meeting, etc.
For a clinician, it is the same. 
They do not have the time to call up and request a bioinformatic query.
We all need a fast, searchable table.

I have added additional hyperlinks to all of the external websites that are most pertinent.
I also did a lot of cleaning and standardisation for filtering "Inheritance" terms, etc. so that it can work seamlessly.

## Thanks

Many thanks to the committee for releasing their invaluable updates every year.

Please do not contact me to complain!
I hope I have modified and cited the original information enough to deter a take-down request. 
I also hope someone adds a version to the IUIS website.

## Anecdote

I was lucky enough to have a paper which accounts for one of these newly added genes, since this list is rapidly approaching its asymptote:
[Credited for a newly added immune gene in IUIS]({{ site.baseurl }}{% link _posts/blogpost/2021-07-08-credited-iuis.md %}).

# References

{% bibliography --cited %}
