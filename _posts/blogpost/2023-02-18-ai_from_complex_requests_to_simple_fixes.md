---
layout: post
title: AI - From Complex Requests to Simple Fixes
date: 2023-01-18 00:00:01
tags: genomics ai chatgpt
status: finished
---

{{ page.title }}
================
<p class="meta">18 Jan 2022</p>

I see a lot of people giving their opinions about chat AI without much examples of real-world application. 
So here is my concrete experience. 
In two weeks I have rewritten, from scratch, one of my genomics pipelines which can analyse 1000 clinical exomes is a few hours. 

It included:
* 42 scripts/programs.
* 3694 lines of code.
* Several languages.

It works to:
* Process raw fastq up to germline variant calling.
* Using high-performance computing cluster. 
* Process vcf into clinical variant interpretation.
* Options for custom filtering strategies.
* Statistical analysis and logs.
* Replaced several mainstream tools that are difficult to manage.

**Final results:**
1. My work was ~6-10x times faster.
2. I probably would not have rewritten this better version as it would have taken too long. 
3. Instead of getting stuck at any difficult impasse I can get context-specific alternatives and testable example code. 

I use chatGPT plus as a paid member for access without restriction. 
Instead of googling for keywords that match, I either post a code example and ask for specific fixes or simply describe the request. 
Here is a very simple example, but I have done some very complex request with great success. 

**Example:**

> * I have an R dataframe "df" with columns "genotype" "variant" "gene" "sample" "inheritance_model".
> * Add a new column "flag".
> * Group by "gene" and "sample", 
> * then add the value 1 to "flag" for rows where "genotype" > 1 and "inheritance_model" == AR.


**Result:**

```R
library(dplyr)

df <- df %>%
  group_by(gene, sample) %>%
  mutate(flag = ifelse(genotype > 1 & inheritance_model == "AR", 1, 0))
```

My real-world use is usually far more complex than this and uses relatively large sets of code.
However, my queries are broken up or pre-empted with an introductory discussion such that, in context, the final request is as simple as the one above.

**Final thought**

Whatever sales reps or armchair philosophers say about the rapidly approaching era of AI, 
if you start using these tools now you will rapidly understand how powerful they will become in many aspects of life.  

(ChatGPT also picked this nice blogpost title for me when I fed it this blogpost and asked for a suggestion). 
