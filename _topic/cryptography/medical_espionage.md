---
layout: topic
title: Medical espionage
created: 13 Feb 2021
tags: statistics
status: finished
subject: cryptography
---
{{ page.title }}
================
<p class="meta">13 Feb 2021</p>

<!--
* TOC
{:toc}
-->

<!--
cross link and label
1. [Introduction](#introduction)
<a name="introduction"></a>
-->

# The prospect of genomic medical espionage
In the hayday of human source intelligence - think late Cold War - international espionage was realtively easy to understand.
This consisted of finding people willing to gather information from the enemy and deliver it to you.
The recruited individuals could be sympathetic to your cause and volunteer, or they could be coerced and remain secret in fear of punishment by the enemy.
Any reader of Le Carre will immediately envision the tangled web that this can ultimately produce; 
running agents, dead drops, double agents proving chicken-feed information to handlers to gain their trust! 
All very dramatic and palpable.
The other examples of intelligence data collection may be less tangibile without experience; 
geospatial,
measurement and signature,
open-source,
signals,
technical,
cyber,
or financial.
The information gathered can be powerful but each is a "one-hit". 
If the target changes, then the old data may not be useful again.
Now think of genetic data. 
Once gathered, it never chages. 
It only becomes more powerful when metadata is added. 

Consider another distinction from the era of Cold War espionage.
It was essentially one side versus the other.
In the year 2021, most nations don't have a direct enemy.
Therefore, today it is difficult to even summarise data collection in terms of "from whom" or "against what".
Between 2013 and today, the revelation of global communications interception has shown that the easiest approach for intellegence data collection is just to gather everything and then figure out who the enemy is later.
I don't have a clear example of how this relates to medical or genomic data, but I do keep in mind that the data holder can decide at any time in the future what genotypes they determine are of interest.
Policy makers will be very slow to recognise that an _a priori_ usage plan is paramount to genomic data protection. 

I heard about a meeting between two national intellegence groups (e.g. nation A and nation B).
Nation A wanted to discuss corporate espionage.
Nation B put it off as long as possible until finally explaing that in nation A, yes, national espionage is commendable to protect their country while corporate espionage is frowned upon.
However, for nation B any kind of intellegence that benefits the country is heroic.
Nation B freely acknowledges that anything worth stealing from A, will be stolen.
One cannot complain about the rules defined in the game, however those rules should not be forgotten just because nation A does not recognise them as readily.
We should keep in mind that our genomic data handlers may unexpectedly decide to share the data with others outside of our control.
GDPR won't be of much use.
This anecdote illustrates a pertinent fact for human genomic medicine.
Unlike most personal data (email address, phone number, physical address, interests, EMEI),
you only have one genome sequence.
Once the online medical database gets leaked, you cannot requrest a new genome seuqnce via email.
Once it is out, it is out.

In a lecture by NSA technical director of the [information assurance directorate](https://www.nsa.gov/what-we-do/cybersecurity/), Richard George stated that credit card data is worth very little today on _"the market"_; 
health information is the new target of interest, 
because with that information comes an indivduals' identity and the potential to order drugs in their name.
With a little more imagination, one can envision the potential for genomic data. 
Some of the most powerful analysis techniques are still being developed today and we may see a big leap in genomic interpretation in the next decade. 
Once the analysis protocols are complete, whoever has the biggest database will be the most powerful (and for entrepreneurs, the most profitable, if their focus is on the correct questions in human health, etc).

Genomic data is most readily applicable to health. 
However, it could stretch much further.
Everyone knows about Google and Facebook - 
our daily activities categorise us into advertisement groups: 
Male age 25-30, interests, dislikes, how much are we willing to spend, etc.
It boils down do "how much advertisement costs are required to sell one unit of product?".
In genomics and health this equates to effect size - what are the odds of disease given the genotype?
How about "given the genotype, how risk aversion are we, how impulsive, will we travel abroad or should we see ads for local entertainment"?
With greater and greater complexity, subtlety, and granularity, this may be possible as long as we can quantify the heritability of complex traits at very low effect sizes. 
Advertising and insurance risk calculations depend on relatively simple statistical formulas that just need enough data to remain profitable.
It is almost certain that much more esoteric applications are on the way.
It is extremely unlikely that legal protections on genomic data will be available before the open market dictates the trajectory.

Will there even be a need for medical espionage when Illunima, Google, BGI, etc. start offering free genome sequencing?
Will it be good or bad once every child gets genome sequncing along with their birth certificate?
Predicting the balance of world order is folly, but as they say "history repeats iteslef".
We can detach from our virtual identities; online presence, daily routines, but we cannot detach from our genetic identidy.
Unlike fingerprinting, or retinal scan, are we prepared to provide a biometric identity with so much information?

# In the media
There have been several ransomware attacks on the health industry in recent years.
These have included public and private research and innovation institutions.
However, the worst examples of this type of crime were seen during the 2017 WannaCry attack;
"One of the largest agencies struck by the attack was the National Health Service hospitals in England and Scotland, 
and up to 70,000 devices – 
including computers, MRI scanners, blood-storage refrigerators and theatre equipment – 
may have been affected." [1].
With the major risks to life caused by attacks on medical institutions, 
the COVID-19 crisis has prompted a clear messages via
_the Oxford Statement on the International Law Protections Against Cyber Operations Targeting the Health Care Sector_, 
and a second statement on _Safeguarding Vaccine Research_ during May and August 2020, respectively [2, 3].

International humanitarian law requires that medical care is respected and protected. 
COVID-19 illustrates that primary reasearch is just as critical and should have the same protections.
In general, publically funded research should be open and freely accessable to all (while respecting the privacy of human health data and personal data).
However, the long and complex process of primary research means that publication or open-sourcing can take a long time. 
Furthermore, the researchers depend on recognition of their work and are unlikely to publish intermediate results.

It is understandable then that nations who might be more interested in privately succeeding will be interested in stealing any information available.
Or more likely, this could be seen from private companies that are willing to steal intellectual property (IP).
For example, for a specific pathogen like SARS-CoV-2 just knowing what amino acid residues your compeditor is most interested in can give you immediate insight that might have taken months to produce. 
Research project datasets tend to start out broad and move linearly towards a final result. 
If the actual documentation and code can be read then these critical results will be obvious. 
However, even just metadata like filenames can provide the key information.
It is not unreasonable to assume that the researchers will simply name datasets incrementally with the key process used. 
As an example, in a database you might see files with assending date stamps:
* data_group1.csv
* data_group1_pruned.csv
* data_group1_pruned_significant_hits.csv
* data_group1_pruned_significant_hits_pR127L.csv

Anyone working on the same problem will understand the routine protocols and know that focusing their research on amino acid p.R127L will give them an advantage. 
Tackling this problem is one for IP law.
If it was for something like vaccine research then one might argue about applied ethics - 
"is it wrong to steal that which should be free ifnormation?" - 
but that weak arguement is quickly disarmed by the fact that we would want our vaccine to come from the primary rearcher, 
not the theif who is willing to cut corners. 

It is obvious that protection should be impleted to prevent theft of _public IP_.
Forthermore, publically funded health research results usally reside alongside private health information that deserves to have strong protections. 


I notice that reports of medical espionage in public media are not alway accurately defined. 
The newstory of a former University Of Florida researcher 
indicted for scheme to defraud has, 
in other places, 
been framed more like someone working under cover for China 
rather than the more accurate description of 
someone committing fraud for failing to report overseas funding sources [4].
There are examples of stolden research IP for personal gain, 
such as the "hospital researcher sentenced to prison for conspiring to steal trade secrets, sell them in China" [5].
In this case, after ten years in the field the researcher was accused of 
"stealing exosome-related trade secrets concerning the research, 
identification and treatment of a range of pediatric medical conditions" 
and then "creating and selling exosome isolation kits" for sale via her company in China [5].
Unlike these examples of personal gain, there have been reports of national medical espionage during to the COVD-19 crisis.

Remaining discussion to be added...

# References
----------

[1] WannaCry ransomware attack, wikipedia.org\
[https://en.wikipedia.org/wiki/WannaCry_ransomware_attack#Impact](https://en.wikipedia.org/wiki/WannaCry_ransomware_attack#Impact)\
\
[2] The Oxford Statement on the International Law Protections Against Cyber Operations Targeting the Health Care Sector\
[https://www.elac.ox.ac.uk/the-oxford-statement-on-the-international-law-protections-against-cyber-operations-targeting-the-hea](https://www.elac.ox.ac.uk/the-oxford-statement-on-the-international-law-protections-against-cyber-operations-targeting-the-hea)\
\
[3] The Second Oxford Statement on International Law Protections of the Healthcare Sector During Covid-19: Safeguarding Vaccine Research\
[https://www.elac.ox.ac.uk/article/the-second-oxford-statement](https://www.elac.ox.ac.uk/article/the-second-oxford-statement)\
\
[4] Former University Of Florida Researcher Indicted For Scheme To Defraud National Institutes Of Health And University Of Florida\
[http://crweworld.com/fl/trendingnow/news/1871206/former-university-of-florida-researcher-indicted-for-scheme-to-defraud-national-institutes-of-health-and-university-of-florida](http://crweworld.com/fl/trendingnow/news/1871206/former-university-of-florida-researcher-indicted-for-scheme-to-defraud-national-institutes-of-health-and-university-of-florida)\
\
[5] Hospital researcher sentenced to prison for conspiring to steal trade secrets, sell them in China\
[http://crweworld.com/oh/trendingnow/news/1867620/hospital-researcher-sentenced-to-prison-for-conspiring-to-steal-trade-secrets-sell-them-in-china](http://crweworld.com/oh/trendingnow/news/1867620/hospital-researcher-sentenced-to-prison-for-conspiring-to-steal-trade-secrets-sell-them-in-china)\
\
Coronavirus: Cyber-spies hunt Covid-19 research, US and UK warn\
[https://www.bbc.com/news/technology-52551023](https://www.bbc.com/news/technology-52551023)\
\
The Cyber Side of Vaccine Nationalism\
[https://www.cfr.org/blog/cyber-side-vaccine-nationalism](https://www.cfr.org/blog/cyber-side-vaccine-nationalism)\
\
Race for Coronavirus Vaccine Pits Spy Against Spy\
[https://www.nytimes.com/2020/09/05/us/politics/coronavirus-vaccine-espionage.html?referringSource=articleShare](https://www.nytimes.com/2020/09/05/us/politics/coronavirus-vaccine-espionage.html?referringSource=articleShare)
