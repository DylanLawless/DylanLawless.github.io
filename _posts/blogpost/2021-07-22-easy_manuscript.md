---
layout: post
title: Easy manuscript
created: 22 July 2021
tags: 
status: finished
---

{{ page.title }}
================

<p class="meta">22 July 2021</p>
## Introduction
Academic writing can be faster using _.md_ instead of _.tex_.
Here is an example of how I write an academic paper.
I use four main files (and a directory of images if required).
* references\.bib
* pre-print\.md
* pre-print\.Rmd
* build\.sh

## references\.bib
These are kept as normal in "references.bib".
I keep a cloud "master_refereces.bib", from which I then pull the project references into a local "references.bib".

## pre-print\.md
This is the main content.
There is no title since this will come in the R markdown Rscript (pre-print.Rmd).
Heading 1s can use "##". 
For citations I use "@citekey"
You can also use "\cite{key}" if you think you might convert to tex format later, e.g. you know your document will require complex formatting once the content is written.
However, LaTeX math notation can be used with "\$\$". 
For example

$$\frac{ \sum{ m_i \bar{x}_i } }{ \sum{ m_i } }$$.

In-line math works with single "\$", for example $$f(k) = {n \choose k} p^{k} (1-p)^{n-k}$$.
(Although, in this webpage's source I actually still use double "\$" without a line-break to print in-line math since I use different setting on this site. I am changing the website setting soon to use single and double "\$" for zero editing).

The document "pre-print.md" looks like this:

``` bash 
# Introduction 
Bla bla bla

# Methods
## Genome sequencing 
Bla bla bla
```

## pre-print\.Rmd
This is the Rscript file that runs to produce the output PDF.
It contains all of the settings and the last line shown is the link to the main contents. 

``` R
---
title: "Title"

header-includes: # Allow landscape page for table
- \usepackage{pdflscape}
- \newcommand{\blandscape}{\begin{landscape}}
- \newcommand{\elandscape}{\end{landscape}}
author:
- Dylan Lawless
output:
# PDF via xelatex
  pdf_document:
    latex_engine: xelatex
    #citation_package: natbib
    number_sections: true
    toc: yes
    toc_depth: 2
link-citations: yes
linkcolor: blue
subparagraph: yes
citecolor: blue
urlcolor: blue

# Output MS word if you really need it
#  word_document: default
#   bookdown::word_document2: default  # for cross-references

# Output as html
# output:
#  bookdown::html_document2:
#    toc: true
#    toc_depth: 2

# pdf, html, or word citations can use: [@key]
# pdf citations only can use: \cite{key}

bibliography: ./references.bib
---

```{r child = './pre-print_v1.md'}```

```

# build\.sh
The document can be built either by using R studio to knit "pre-print.Rmd" or by using a script to do the same without having to open the R studio GUI.

The shell script "build.sh" only neeeds one line to run the build:

``` bash
#!/bin.bash

Rscript -e "rmarkdown::render('pre-print.Rmd')"
```

This will output "pre-print.pdf".

## Conclusion 
While LaTeX-style is the king of academic or technical writing,
using this simple markdown substitute covers ~90% of my needs and 99% of the content-writing process. 
It avoids the time-consuming requirements of wring LaTeX formatting and produces almost the same result. 
In most cases, we require only
* section headers
* plain text
* italic or emph text
* inserted figures
* math notation
* .bib citations

Everything else is usually superfluous formatting that is a time-consuming distraction and often ends up being redone in the final manuscript version anyway. 

Using a markdown files for nearly everything that I write (academic, personal, web publishing, zettelkasten notes, etc.) means that atomic notes can be very easily shuttled around any possible project. 
Citations in my master_references.bib also means that I will always have them available for any project, whether it is a large project or simply small literature note that is cross-posted between projects. 
