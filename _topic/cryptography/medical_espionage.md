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

* TOC
{:toc}

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

# Ransomware
There have been several ransomware attacks on the health industry in recent years.
These have included public and private research and innovation institutions.
However, the worst examples of this type of crime were seen during the 2017 WannaCry attack;
> "One of the largest agencies struck by the attack was the National Health Service hospitals in England and Scotland, 
> and up to 70,000 devices – 
> including computers, MRI scanners, blood-storage refrigerators and theatre equipment – 
> may have been affected." [1].

# Legal safegard
With the major risks to life caused by attacks on medical institutions, 
the COVID-19 crisis has prompted a clear messages via
_the Oxford Statement on the International Law Protections Against Cyber Operations Targeting the Health Care Sector_, 
and a second statement on _Safeguarding Vaccine Research_ during May and August 2020, respectively [2, 3].

International humanitarian law requires that medical care is respected and protected. 
COVID-19 illustrates that primary reasearch is just as critical and should have the same protections.
In general, publically funded research should be open and freely accessable to all (while respecting the privacy of human health data and personal data).
However, the long and complex process of primary research means that publication or open-sourcing can take a long time. 
Furthermore, the researchers depend on recognition of their work and are unlikely to publish intermediate results.

# Metadata
It is understandable that nations who might be more interested 
in privately succeeding will be interested in stealing any information available.
Or more likely, this could be seen from private companies 
that are willing to steal intellectual property (IP).
For example, for a specific pathogen like SARS-CoV-2 just knowing what 
amino acid residues your compeditor is most interested in can give you immediate 
insight that might have taken months to produce. 
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

# Disinformation
Disinformation, _dezinformatsiya_, includes the leaking of information that 
seems valuable but is either a dead-end, or worse, intentionally harmful.
It is critical to ban the use of disinformation in any research affecting 
human health or publically funded research.
It would be better to have instances of valid IP theft than risk any harm.

# Data pollution
Conversely, data pollution is another potential risk factor.
Large scale genomics relies on careful curation. 
Importing incorrect data will pollute analysis and 
potentially mask true positive results from being found. 
In the last few years, some commercial genomic services have allowed users to 
upload their own genomic and personal phenotypic information.
While most users are just interested in their own results, this has a reasonable large potential for risk - 
a targetted data submission, randomly shuffling input phenotypic information 
would weaken the database for assocciation analysis.

# In the media
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

> In November 2020, "Microsoft said at least nine health organisations including Pfizer had been targeted by state-backed organisations in North Korea and Russia" 
> [as reported by the BBC.](https://www.bbc.com/news/technology-54936886).
In Feb 2021, 
a [claim without source and repeated by the BBC](https://en.yna.co.kr/view/AEN20210216008451315) 
says that the
> "National Intelligence Service (NIS) unveiled information during a closed-door 
> session of the National Assembly's intelligence committee stating that
> North Korea has attempted to hack the servers of a local drug manufacturer 
> to obtain technology information on the company's coronavirus vaccine and treatment."

Reports like this rarely have published evidence
and may be nothing but fantansy deamed up by _The Tailor of Panama_ type reporters.
Regardless, tageted theft is very liekly and one would assume it to be happening
even when specific reports are unsubstantiated. 

Remaining discussion to be added...

# Protecting data and promoting open-source access
## Projects focused on safe access
The Global Alliance for Genomics and Health (GA4GH) is leading the effort in
safe data access. 
> "GA4GH is a policy-framing and technical standards-setting organization, 
> seeking to enable responsible genomic data sharing within a human rights framework.
> Enabling responsible genomic data sharing for the benefit of human health. "

The [driver projects promoted by GA4GH](https://www.ga4gh.org/how-we-work/driver-projects/) 
are the some of the best real world examples
today.
These include projects such as 
* [Matchmaker Exchange](https://www.matchmakerexchange.org) 
	+ as a tool to find genetic causes for patients with rare disease.
* [TOPMed program](https://www.nhlbiwgs.org) 
	+ very lage scale genome sequence data.
* [Genomics England](https://www.genomicsengland.co.uk)
	+ very lage scale genome sequencing for patients in the UK.

All of the projects play an extremely important role in human health and research.
There are also many other similar initiatives outside of GA4GH which are promoting 
science collaboration.

## Obstacles to data privacy
Attending the GA4GH meetings and working as part of some of these projects,
I am struck by the fact that genomic privacy generally depends on a user trust system,
and data protection is focused on the end-user stage. 
I can exemplify the problem with the following simple example:

Every subject relying on genomic analysis must submit a DNA sample along with 
genetic consent, and the data is prepared in several stages;
1. Sample collection
2. Sample preperation
3. Sequencing
4. Data processing
5. Data submission
6. Data access
7. Reporting

_Problem level [1]_\
The best systems today use a tracking system where the sample collection will
produce an anonymised ID in step 1.
All subsequent steps will therefore be detached from the subject's personal information.
However, the personal information is not necessarily the valuable info, 
the genome sequence is (even if anonymised).
Anyone who has access to the DNA sample can easily sequence the genome for less than 
$500 US.

_Problem level [2-3]_\
The sample preperation and sequencing has identical risk as step 1. 
However, the sample is now likely out of the hands of the primary person responsible.
It will most likely be in a large scale sequence facility. 

_Problem level [4]_\
Data processing will become more routine over time.
The large scale sequencing projects all follow a strict analysis pipeline,
but since a large majority of proccessing today is for clinical diagnosis, 
it means that at some stage a researcher will be required to do custom analysis
on an individual sample. 
This person is likely to have unrestricted access to all database samples.

_Problem level [5]_\
The data submission level will consist of anonymous subject IDs again, 
however it will contain whole genome seuqnces (or processed variant called datasets).

_Problem level [6]_\
Data access is the step in which nearly every genomic data protection process is
focused. 
It is a logical starting position since this is the stage in which researchers 
will require permissions for accessing large amounts of data for research purposes.
It has the addition risk in that other medical data is usually also present, 
typically clinical phenotype data. 

_Problem level [7]_\
Once a candidate genomic determinant for clinical diagnosis is established,
the researcher is going to complete a reporting procedure.
One would imagine that this is a clean, automated, process. 
However, it is very common for researchers and clinicians to simply email back and
forth about very sensitive information.
This is uderstandable and often a patient's life could be saved with a rapid diagnosis.

However, the facts should be clearly stated. 
Plain text emails, SMS, and other types of communications are collected routinely 
via national surveillance.
[Not to be dismissed as conspiracy theory](https://en.wikipedia.org/wiki/List_of_government_mass_surveillance_projects), 
it is a fact that your private information may be collected without your consent,
_but_ you _will_ get more expertise in your medical treatment when physicians can communicate with their colleagues via email, etc.

_Problem summary:_\
Nearly all privacy protocols today are focused on step 6.
Anyone interested in large scale medical espionage will focus on any of the 
other, much more readily available, steps 1-5.
Furthermore, data access at step 6 can be restricted to trusted researchers, 
but there should be no confusion - humans can always find methods for 
exporting data from protected access portals [^foot].
While the privilege of data access is restricted, 
it is essentially based on trust and 
recruited patient participants should not be lead to believe otherwise.
Some very sophisticated methods allow for data analysis of encrypted data, 
but these are not widely used today and will not be able to replace all of the 
required methods in the near future.

## Future methods
In addition to the highly commendable initiatives for genomic data sharing today,
there are several options that can be implemented in the future.

To be finished..

[^foot]: [A trivial example of data export by hiding data within a "results figure"]({{ site.baseurl }}{% link _posts/2019-08-19-devil_in_detail.md %}).

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
