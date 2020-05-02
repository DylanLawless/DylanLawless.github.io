---
layout: topic
title: Pharmacogenomics for personal medicine 
created: 01 Jan 2019
tags: genomics
subject: Precision medicine
---
{{ page.title }}
================
<p class="meta">26 Apr 2020</p>

* TOC
{:toc}

# Introduction
With the popularisation of commercial genetics services, more and more people are able to "decode" their genetic data.
One question that might arise from this information is "Do I have potentially disease-causing variants that can be treated with a drug?".
To tackle this question with an example, we use public data in combination with pharmacogenomics.
Outside of genotype data (offered by [23andMe](https://www.23andme.com) for example), the most common file type will be VCF: [What is a vcf and how should I interpret it?](https://gatkforums.broadinstitute.org/gatk/discussion/1268/what-is-a-vcf-and-how-should-i-interpret-it).

Here is a data source with different genetic data files.
[https://my.pgp-hms.org/public_genetic_data](https://my.pgp-hms.org/public_genetic_data).
To check that it works OK, I tried a quick version of this challenge.
I picked the first whole genome VCF file that I saw (hu24385B 2019-04-07.vcf.g_z)
[https://my.pgp-hms.org/profile/hu24385B](https://my.pgp-hms.org/profile/hu24385B). 
The VCF has 3,461,639 variants.
VCF files basically only need to have the reference genome position and variant.
Annotation information about the gene name (or related diseases) is only added later.
Therefore the most common input source may be lacking gene symbols.
To get the gene names of a single file, the simplest way was is to upload a VCF (or a part of it) to [Variant Effect Predictor](http://grch37.ensembl.org/Homo_sapiens/Tools/VEP/) to get the gene symbol (and any other information that you wish).
<img src="https://dylanlawlessblog.files.wordpress.com/2019/05/screenshot-2019-05-07-at-17.01.45.png" width="80%">  
<img src="https://dylanlawlessblog.files.wordpress.com/2019/05/screenshot-2019-05-07-at-17.01.58.png" width="80%">

To reduce the time and output you can limit the options.
Split the file and run in batches to save time.
Here I tried the first ~1800 variants.

<br/>
`head -2000 56001801068861_WGZ.snp.vcf > test.vcf`

<br/>
And then annotated that extract with [Variant Effect Predictor.](http://grch37.ensembl.org/Homo_sapiens/Tools/VEP/)
The results would be retained by a URL address such as this, for a few days, but will be deleted by the time your read this.  
[http://grch37.ensembl.org/Homo_sapiens/Tools/VEP/Results?db=core;tl=jNYYW5ONeVFYnaMM-5265700](http://grch37.ensembl.org/Homo_sapiens/Tools/VEP/Results?db=core;tl=jNYYW5ONeVFYnaMM-5265700)


<img src="https://dylanlawlessblog.files.wordpress.com/2019/05/screenshot-2019-05-07-at-17.01.10.png" width="80%">

(Make certain you use the same reference genome as used on the input data).
The VCF file was made using reference genome GRCh37.
Therefore the Ensembl/VEP website URL should be for that genome build (grch37, not the default GRCh38).
From the output I extracted the gene symbols and compared against a list of druggable target genes from 
[DrugBank](https://www.drugbank.ca)
(because I happen to have their data on hand, FDA may be more reliable).
A quick list of the unique genes based on the first 2000 variants gives 3 genes:  

<br/>
`sort unique.genes.txt unique.druggable.txt | uniq -c -i | grep -v '1 '`  
<br/>
The genes which were in present in both the variant list and DrugBank list are:  
2,000 vcf lines = 
[GABRD](https://www.drugbank.ca/bio_entities/BE0003599),
[PRKCZ](https://www.drugbank.ca/bio_entities/BE0004895),
[SCNN1D](https://www.drugbank.ca/bio_entities/BE0000495)  
10,000 vcf lines = 
[GABRD](https://www.drugbank.ca/bio_entities/BE0003599),
[PRKCZ](https://www.drugbank.ca/bio_entities/BE0004895),
[SCNN1D](https://www.drugbank.ca/bio_entities/BE0000495),
[TP73](https://www.drugbank.ca/bio_entities/BE0008994).

So in this simple example it takes just 5 minutes to get from a real genome VCF to possibly druggable target genes (see further note on _drug indication_ below).
The difficulty lies downstream in interpreting which variants can have an effect that would justify the use of the drug. Anyone implementing a usable version of this method will incur several obstacles; e.g. are non-coding or synonymous variants worth reporting?, genes have multiple transcripts which means one variant can be both coding and non-coding depending on transcript splicing, etc.
Other sources of sequence data, including the sequences of Watson and Venter;  
[http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/)  
23andMe open snp data; [https://opensnp.org/genotypes](https://opensnp.org/genotypes).
There are many layers to a this problem to create a usable product.
For example, how to integrate pharmacodynamics, covariats to drug response, contraindications, variant pathogenicity, etc.
However, this is a good start as a learning experience.

# Annotation
[Variant Effect Predictor](http://grch37.ensembl.org/Homo_sapiens/Tools/VEP/) is very useful.
Note: For a real product, the code can run offline (a perl program with a few local library dependencies).
However, the databases/cache that it uses are a bit large to include on in a user software.
It is not important for your project.
But incase anyone asks, you could send _anonymised_ packets from the user via an API for accessing the genomic databases.
Make sure to check their license to see if you can use it in a product.  
[http://www.ensembl.org/info/about/legal/code_licence.html](http://www.ensembl.org/info/about/legal/code_licence.html) 

# Drug indication
My example used [DrugBank](https://www.drugbank.ca) for pharmacogenomic information.
However, it may be safest to use the [FDA information](https://www.fda.gov/drugs/science-research-drugs/table-pharmacogenomic-biomarkers-drug-labeling) as the primary source, but including [DrugBank](https://www.drugbank.ca) info is no problem.
Drugs might be either a treatment for a genetic determinant, or a warning for drug usage in someone who also has a genetic variation that might effect their treatment.
The "Labelling Section" listed by FDA might offer the best information.
[https://www.fda.gov/drugs/science-research-drugs/table-pharmacogenomic-biomarkers-drug-labeling ](https://www.fda.gov/drugs/science-research-drugs/table-pharmacogenomic-biomarkers-drug-labeling)
For example, if we go and check the Prescribing Information PDF to compare two drugs we see that

<br/>
**(1)** one is used to directly block a gene product,  
**(2)** the second warns about use with certain genetic complications.  

<br/>
**Drug 1**: [Atezolizumab](https://www.accessdata.fda.gov/scripts/cder/daf/index.cfm?event=overview.process&varApplNo=761034) (1),  
**Gene**: [_CD274_](https://www.fda.gov/drugs/science-research-drugs/table-pharmacogenomic-biomarkers-drug-labeling) [(PD-L1)](https://www.fda.gov/drugs/science-research-drugs/table-pharmacogenomic-biomarkers-drug-labeling)  
**Labeling**: Indications and Usage  
**PRESCRIBING** **INFORMATION**: TECENTRIQ (Atezolizumab) is a programmed death-ligand 1 (PD-L1) blocking antibody indicated for the treatment of patients with...
[linked PDF](https://www.accessdata.fda.gov/drugsatfda_docs/label/2016/761034Orig1s000lbl.pdf).  
**Explained**: Genetic disorder and the drug to treat it, exactly what you want.  

<br/>
**Drug 2**: Avatrombopag (3)  
**Gene**: [_PROC_](https://www.fda.gov/drugs/science-research-drugs/table-pharmacogenomic-biomarkers-drug-labeling)  
**Labeling**: Warnings and Precautions  
**PRESCRIBING INFORMATION**: Thrombotic/Thromboembolic Complications: DOPTELET is a thrombopoietin (TPO) receptor agonist... Monitor platelet counts and for thromboembolic events
[linked PDF](https://www.accessdata.fda.gov/drugsatfda_docs/label/2019/210238s002lbl.pdf).  
**Explained**: Atezolizumab is used to treat thrombocytopenia (low levels of thrombocytes).  
You _do not want to give_ this to someone who has [_PROC_](https://omim.org/entry/176860?search=proc&highlight=proc)[ deficiency](https://omim.org/entry/176860?search=proc&highlight=proc);
their disease is [Thrombophilia](https://en.wikipedia.org/wiki/Thrombophilia) (hypercoagulability, or [thrombosis](https://en.wikipedia.org/wiki/Thrombosis)).
With this in mind, perhaps an application doing this job could work two ways.
(1) If someone has a genetic disorder, the drug, gene, and Indicated usage appears.
(2) If someone is prescribed a drug a suggestion appears to check their genetics, with a link to the gene and Warnings and Precautions.

# Optimising VCF annotation
The slowest part of the method is VCF annotation.
You can significantly increase the speed by first reducing the input to contain only regions of interst.
That is, prepare a list of coordinates for each gene, and select for those regions in your input VCF or genotype data before annotation (VEP).

# How to get coordinates for a gene list
Use Biomart.
Their main server was down when I tried, so I went via Ensembl, data access section:  
[http://www.ensembl.org/info/data/biomart/index.html](http://www.ensembl.org/info/data/biomart/index.html)  
The use the BioMart data mining tool  
[http://www.ensembl.org/biomart/martview/28fdaf82da6c02dc5892f99b757e2c44](http://www.ensembl.org/biomart/martview/28fdaf82da6c02dc5892f99b757e2c44)  
I actually needed the positions using GRCh37 (rather than 38), so I switched to the old Ensembl using  
[http://www.ensembl.org/info/website/tutorials/grch37.html](http://www.ensembl.org/info/website/tutorials/grch37.html)  
to get to [http://grch37.ensembl.org/index.html](http://grch37.ensembl.org/index.html) 
then the Biomart section  
[http://grch37.ensembl.org/biomart/martview/04f009257dadbafbe595155ba910eb5e](http://grch37.ensembl.org/biomart/martview/04f009257dadbafbe595155ba910eb5e)


Choose DataBase: Genes 93 Dataset: Human Filter -> Gene -> Input external ref ID list -> (change dropdown) Gene
Name paste your list.
e.g. VPS45 PSMB8 BLNK NEFL NLRP7 SMAD4 PSMB9  
To set the output type: Attributes -> Gene -> select “gene start”, “gene stop”, “gene name”, or anything extra.
Select the “Results” button at the top and export.
The results can be tsv or csv.
You would have to figure out how to extract the regions from the vcf (sed, grep, awk, R code, etc.).
When I needed this, I used my own tools which required converting to format like this "X:1-2000", and ordered by number and alphabetic* (*some positions in the reference genome were patches added later and have an alphanumeric instead of the normal chromosome).
If you use this list to extract regions from a VCF, remember to include all the original VCF header information.

# Extracting regions from a VCF using a bed file

You can use VCFtools to extract specified regions.  
[https://vcftools.github.io/man_latest.html](https://vcftools.github.io/man_latest.html)  
Note that sometimes the bed file "chrom" ID - the name of the chromosome (e.g. chr3) does not match if the VCF file uses "3" instead of "chr3".
You might need to edit the bed.
My bed file was like this: (tab spaced), ref.bed  
chrom   chromStart  chromStart  
1   13549   13555 class="">  
And this command ran OK for me to give "output_prefix.recode.vcf"<br/>
`$:~/tools/vcftools_0.1.13/bin \`\
`./vcftools \`\
`--vcf ~/input.vcf \`\
`--bed ~/ref.bed \`\
`--out output_prefix \`\
`--recode --keep-INFO-all`

This new VCF will now only contain gene regions that are potentially "druggable", or at least included on the FDA list. VCF annotation will be much faster than when annotation the whole genome.

# References
- [https://www.fda.gov/drugs/science-research-drugs/table-pharmacogenomic-biomarkers-drug-labeling](https://www.fda.gov/drugs/science-research-drugs/table-pharmacogenomic-biomarkers-drug-labeling)
- [https://www.pharmgkb.org/view/drug-labels.do](https://www.pharmgkb.org/view/drug-labels.do)
- Mary V. Relling & William E. Evans. Pharmacogenomics in the clinic. _Nature_ 2015; 526, 343–350\. doi: 10.1038/nature15817
- Yip VL, Hawcutt DB, Pirmohamed M. Pharmacogenetic Markers of Drug Efficacy and Toxicity. _Clin Pharmacol Ther._ 2015;98(1):61-70\. doi: 10.1002/cpt.135.
- David R. Adams, M.D., Ph.D.,  and Christine M. Eng, M.D. Next-Generation Sequencing to Diagnose Suspected Genetic Disorders N Engl J Med Oct 2018 doi: 10.1056/NEJMra1711801



