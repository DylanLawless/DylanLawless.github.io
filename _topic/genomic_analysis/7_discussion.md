---
layout: topic
title: Genomic analysis discussion
created: 8 Aug 2018
bibliography:
- '../tail/bibliography.bib'
tags: genomics
subject: Genomic analysis
---
{{ page.title }}
================

* TOC
{:toc}

# Discussion
Exome sequence data is usually about 4 GB of information per person.
Whole genomes are approximately 50GB of data. The analysis of whole
genome sequencing is almost identical to the exome pipeline outlined
here. While there is much more information (for not much of a higher
cost), a lot of the non-coding sequence contains information that we
can't yet interpret. For Mendelian disease the whole exome often
uncovers the coding variants that explain disease. We may not understand
anything else outside the exome (and the surrounding splice regions) in
relation to a patients' disease. Mutations in the promoters or enhancers
that prevent transcription may not be as readily interpretable as the
majority of coding variant effects. Therefore, whole genome is often not
required. This excuse for performing exome sequencing rather than whole
genome mostly depends on value for money. Performing all the different
kinds of analysis, including non-coding genome analysis, requires many
people with expertise in each topic. Even if whole genome data was
available to smaller research teams, it is often the case that they
cannot carry out all the work required to interpret it. For national
level genomics, there is no question that whole genome sequencing is
preferential. We can retain the data for decades with hundreds of
experts to share the work-load, while the cost is essentially a
political factor. An important question to address is the right for a
person to agree to genetic forfeiture. We are at the brink of
preventative medicine using genome sequencing in newborns. Regardless of
the popular ethical consensus, any preventative non-consenting genomic
analysis can be considered coercion.

**Figure \[fig:immune\_cluster\]** illustrates how not only can very
rare or damaging variants be clustered, but the same network can be
expanded to include peripherally interacting genes. This modification
may be used for downstream functional work such as looking at
pathway-level expression data. An important consideration for protein
network cohort analysis is evident in **Figure
\[fig:network\_size\_nodes\]**. About 50% of genes with a functional
variant are do not get clustered into a PPI network (protein pathway).
However, some of these genes could still harbour a potential
loss-of-function or damaging variant. If we found 3 significantly
enriched protein networks, a potential 4th missed network (false
negative), because of unclustered genes, would not detract from the
significant findings. Therefore, the singleton genes remaining from MCL
clustering should be listed and reassessed based on traditional
interpretations; variant effect, loss-of-function intolerance, etc. The
converse, a false positive because of over clumping weakly related
proteins, would be negative.

The analysis of genomic data is an iterative process. Therefore, access
to raw unprocessed genetic information is often required to utilize
cutting edge methods [@Auwera2013From; @Poplin2018Scaling]. Furthermore,
genetic analysis is a complex, multi-stage procedure. Due to the
inherent complexity, there is a number of output streams which consist
of different data types. To provide seamless integration with current
best practices in precision medicine, it is valuable to adhere to
standard genomic data types, including CRAM, SAM/BAM, FASTQ, and VCF
[@Li2009Sequence; @Hsi2011Efficient; @cock2009sanger; @Danecek2011Variant].
There is benefit to creating new data formats that increase efficiency.
However, by focusing on key data types in genomics, one can enable
integration with most current software
[@pabinger2014survey; @Auwera2013From].

An interesting caveat to genetic data is that at pre-processing stages,
several data types cannot be currently provided with protection through
the use of modern cryptographic methods
[@froelicher2017unlynx; @juvekar2018gazelle]. There is currently a
severe lack of tools that complement current methods required to
interrogate genetic data at different stages while protecting individual
personal genetic records. Furthermore, despite the attempts to promote
data privacy and integrity through global initiatives, such as Global
Aliance 4 Genome Health, little has been done to produce queryable data
that protects the genetic identity of a subject.

The privacy concerns at the early stages of data processing are often
overlooked. Almost every method offered for data security relies on
protecting only fully process data (e.g. already variant called VCF
format data) or summary statistics. In worst cases, privacy concerned
genomics falls back to “trust-based” systems where data generators or
researchers are required to accept responsibility for preventing any
re-anonymisation. Of course, researcher trust is an important factor,
however, relying on this method for protecting subject information is
immoral. Unlike nearly all clinical data, genetic data is inherently
identifiable and is not readily anonymised. The information that makes
up the data is itself the identity or commodity. In nearly every other
type of clinical data, it is only a commodity when there is an identity
to which it is paired or if it is part of a large dataset-of-normals.
The lack of strong methods of genetic data protection is not an apparent
risk generally. Extrapolating the risk which differentiates other types
of data that requires informed consent is a difficult task for many
experts. Relying on patient consent and trust in data protection is not
sufficient for the future of global genomics. Successfully overcoming
these challenges will allow for the use of analysis methods that
otherwise provide vulnerabilities against the protection of private data
[@Li2009Fast], \[GA4GH (https://www.ga4gh.org)\].

# Conclusion
A pipeline of routine exome analysis was outlined. Important points on
tailored analysis are demonstrated. A new method was developed for the
unbiased detection of a protein network, driving disease, based on
potential loss of function variants.

# Command line example code
