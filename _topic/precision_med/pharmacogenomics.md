---
layout: topic
title: Pharmacogenomics for personal medicine 
date: 2019-01-01 00:00:01
tags: genomics
subject: Precision medicine
---
{{ page.title }}
================
<p class="meta">06 Mar 2024</p>

* TOC
{:toc}

## Introduction
With the popularisation of commercial genetics services, more and more people are now able to "decode" their genetic data.
Questions that might arise from this information include "do I have potentially disease-causing variants that can be treated with a drug?", or "am I taking a drug that will be affected by my genetics?".
To tackle such questions with an example, we use public data in combination with pharmacogenomics.

<!-- Outside of genotype data (offered by [23andMe](https://www.23andme.com) for example), --> 
The most common file type for storing DNA variant data is the VCF format:
[What is a vcf and how should I interpret it?](https://gatk.broadinstitute.org/hc/en-us/articles/360035531692-VCF-Variant-Call-Format).

## Download VCF data
Example VCF from [https://my.pgp-hms.org/public_genetic_data](https://my.pgp-hms.org/public_genetic_data):
* A randomly selected whole genome VCF file:
    * [https://my.pgp-hms.org/profile/hu24385B](https://my.pgp-hms.org/profile/hu24385B): 
    * filename: hu24385B 2019-04-07.vcf.gz
    * sequence provider: Dante Labs Whole Genome
    * size: 147 MB

* Additional examples - not tested:
    * [1] VCF from Dante Labs vs GRCh37 (246 MB) [https://my.pgp-hms.org/profile/hu1D5A29](https://my.pgp-hms.org/profile/hu1D5A29)
    * [2] WGS 30x filtered SNP VCF (325 MB) [https://my.pgp-hms.org/profile/hu1C1368](https://my.pgp-hms.org/profile/hu1C1368)
    * [3] 60820188474283.snp.vcf.gz (222 MB) [https://my.pgp-hms.org/profile/hu6ABACE](https://my.pgp-hms.org/profile/hu6ABACE)

The "hu24385B" VCF has 3,461,639 variants.
VCF files can contain a large range of information for each variant, however only the first 7 column are strictly neccessary; Chromosome, position, ID, Reference, Alternate, Qulaity, Filter, info. 
[The details are explained on this GATK forum post](https://gatkforums.broadinstitute.org/gatk/discussion/1268/what-is-a-vcf-and-how-should-i-interpret-it).

<img src="{{ site.baseurl }}{% link images/vcf_header.png %}" width="100%">

<img src="{{ site.baseurl }}{% link images/vcf_body.png %}" width="100%">

## Annotate VCF data
Annotation information about the gene name (or related diseases) is often not present when the VCF is generated and only added later.
To get the gene names, the simplest way was is to upload a VCF (or a part of it) to [Variant Effect Predictor](http://grch37.ensembl.org/Homo_sapiens/Tools/VEP/).
This will supply the gene symbol (and any other information about each DNA variant).

To reduce the time and output you can limit the options:
* Split the file and run in batches to save time.
* Test the first ~1800 variants:
<br/>
`head -2000 56001801068861_WGZ.snp.vcf > test.vcf`
<br/>
* Then annotate with [Variant Effect Predictor.](http://grch37.ensembl.org/Homo_sapiens/Tools/VEP/)
<img src="{{ site.baseurl }}{% link images/vcf_vep.png %}" width="100%">

* Make certain that you use the same reference genome as used on the input data.
* The VCF file was made using reference genome GRCh37.
* Therefore, the Ensembl/VEP website URL should be for that genome build (grch37, not the default GRCh38).

## Annotating a full VCF
* One _could_ annotate a whole genome using the Ensembl web interface.
* However, one would need to split your VCF into smaller block first.
* For routine usage the command-line version of VEP and it's databases should be installed on run locally.
* **I will provide a completed annotated VCF for you.**

There are several bioinformatics tools that are commonly used for manipulating  genetic file formats such as VCFtools. 
However, to get a real understanding of the data type, here is a method using command line bash to split a VCF file into smaller blocks. 
A bash script is printed below where I use very mainstream traditional command-line tools to wrangle data, including 
[gunzip](https://en.wikipedia.org/wiki/Gzip)
to unzip compressed files, 
[wc](https://en.wikipedia.org/wiki/wc_(Unix))
to count lines, 
[cat](https://en.wikipedia.org/wiki/Cat_(Unix))
to print a file, 
[head](https://en.wikipedia.org/wiki/Head_(Unix))
to read the top of a file, 
[sed](https://en.wikipedia.org/wiki/Sed)
to edit lines, 
[awk](https://en.wikipedia.org/wiki/AWK)
for data extraction, and
[grep](https://en.wikipedia.org/wiki/Grep) for text search (not used).

Putting the code below into a file with the filename extension with ".sh" will allow it to be run by your terminal, in this case using the bash language.
I encourage you to read each line and figure out what should happen. If it makes sense then it is reasonable to swap such a manual method with a more efficient specialised tool. 

``` bash
#!/bin/bash
# VEP accept files of <50MB size.
# We will split our large VCF into smaller files.
# Each file requires the same original 
# headers and file extension ".vcf"

# Unzip the VCF.gz
gunzip 56001801068861_WGZ.snp.vcf.gz

# Count the number of lines in vcf
wc -l 56001801068861_WGZ.snp.vcf

# How should a vcf file look?
# See the links posted in this tutorial above

# Take a look at the header
# This VCF has 140 lines of header metadata (beginning with "#")
# Line 141 shows the column headers: CHROM	POS	ID	REF	ALT...
# Line 142 starts with the first variant
head -142 56001801068861_WGZ.snp.vcf

# Print the header to a new file for later
head -141 56001801068861_WGZ.snp.vcf > header
# Print everything else (the body) to 
# a new file that we will then split.
sed '1,141d' 56001801068861_WGZ.snp.vcf > body.vcf

# Make a new directory for the next step
mkdir split_files
# Move the large file inside
mv body.vcf split_files/
cd split_files
# Now split the body.vcf into smaller 
# files of 200,000 lines each
split -l 150000 body.vcf

# You will now how ~10 files "xaa, xab, etc."
# Add the header back onto all of these files to make them VCFs again.
# This "for loop" will do the following for each file:
# Print the header and the vcf body to 
# a file with the same name, 
# adding a file extension ".vcf".
# Then remove the vcf body file that 
# does not have the ".vcf" extension
# leaving you with the original whole genome VCF split
# into smaller files, each with the same headers.

for file in ./x* ; 
    do cat ../header $file >> $file.vcf && rm $file ;
done

# These should be small enough to run on VEP online.
# You could edit the split command to make a 
# reasonable number of files, 
# uploading >10 is not efficient.

```

## Comparing annotated genetic data to drug lists
* We now assume that we have a VCF where VEP annotated each variant.
* The features can include gene names, variant consequence, pahtnogenicy prediction, etc.
* The next aim is to see if any output genes are also present in your drug-gene database.
* The method will require merging both dataset (gene and drug datasets) based on shared features. 
* A simple sanity test would be useful first.

### Drug-gene list
Here is a drug-gene list "similar" to the private version from DrugBank:
* [notdrugbank_all_interaction.txt](https://lawlessgenomics.com/pages/drugbank_all_interaction.txt)

Drugbank has changed their access policy and now requires access applications. 
If you want the up-to-date DrugBank data I believe you can apply for non-commercial use (and wait a few days). 
The data can then be found at:
[https://go.drugbank.com/releases/latest#protein-identifiers](https://go.drugbank.com/releases/latest#protein-identifiers), 
"protein-identifiers" tab, "Drug Target Identifiers" section, "All" file.

### Example of how to check gene list versus drug-gene list
* Extract the gene symbols column from VEP output
* Compare gene symbols to a list of druggable target genes from 
[DrugBank](https://www.drugbank.ca).

``` bash
# Get a list of unique gene symbols
cut -f1 -d "," vep_output_file.csv - uniq > unique.genes.txt

# - Cut column 1 (f1) 
# - with a delimiter comma (,) 
# - from the vep output csv file (or tsv, or text file)
# - then pipe (\|) that result into another program (sort) to sort the result in alphabetic order
# - pipe (\|) again this result into(uniq) 
# - so that only one unique gene name is output
# - then (>) write the output into the new file "unique.genes.txt".  
```
<br/>

* Repeat the same method on the DrugBank dataset 
* Output the gene names from DrugBank to "unique.druggable.txt"
<br/>

``` bash
# Get a list of gene symbols which are present in both datasets
sort unique.genes.txt unique.druggable.txt - uniq -c -i | grep -v '1 '
```

This command also used "uniq -c" to count how many times each gen name occurs and then "grep -v '1 '" meaning ignore genes that are only present 1 time. 
We want the genes that are present twice, once in each list.

* The genes which were in present in both the variant list and DrugBank list are:
* From a 2,000 line VCF file:
    * [GABRD](https://www.drugbank.ca/bio_entities/BE0003599),
    * [PRKCZ](https://www.drugbank.ca/bio_entities/BE0004895),
    * [SCNN1D](https://www.drugbank.ca/bio_entities/BE0000495)  
* From a 10,000 VCF line file:
    * [GABRD](https://www.drugbank.ca/bio_entities/BE0003599),
    * [PRKCZ](https://www.drugbank.ca/bio_entities/BE0004895),
    * [SCNN1D](https://www.drugbank.ca/bio_entities/BE0000495),
    * [TP73](https://www.drugbank.ca/bio_entities/BE0008994).

## Full-scale merging genetic and pharmacogenomic data
<!-- The previos section showed a small example the logic of the process, we can try a more complex real-world example. --> 
The following R language script is used to merge the VEP annotated VCF file with a DrugBank database based on the gene names that are common to both datasets.
Read each line and try to understand the process. 
<!-- The are many alternative ways to do the same thing in different programming languages. --> 
I recommending installing R and then installing R studio to edit and run your commands.

<!-- * If you need a copy of the data and code used in the following example, email me and ask for: "r_merge.zip" -->

``` R
# Comment lines are ignored because of "#" symbol.
# Command lines are run by clicking "Run" or "command+enter" on Mac

# csv = comma sep file
# tsv = tab spaced
# txt = white space

#///////////////////////////////
# To do
#///////////////////////////////
# Files: vepfile, drugs
# merge based on Gene symbol

#///////////////////////////////
# import the VEP file
#///////////////////////////////

# Important note:
# The VEP file will start with a header line 
# that begins with "#" symbol. But this is being ignored by R.
# Open the file with text edit and remove that symbol.
# Maybe there is an R command to do this on import, whatever is faster.

# Split vcf into ~ 10 files. 
# file 1 "xaa" was anylised on VEP, 
# download the TXT version, 
# or unzip my provided example one - cfKJCLRm0eKXsaEG.txt.zip
# https://grch37.ensembl.org/Homo_sapiens/Tools/VEP/

# Import the VEP output
vepfile <- read.table(
  file="cfKJCLRm0eKXsaEG.txt",
  na.strings=c("", "NA"),
  sep="\t",
  header=TRUE)

# Import drugbank table
# the "fill=TRUE" is needed because not all 
# file lines have the same number of elements.
drugs <- read.table(
  file="drugbank_all_interaction.txt",
  na.strings=c("", "NA"),
  sep="\t",
  header=TRUE,
  fill = TRUE )


# We can merge these two files based on 1 common column.
# However, the gene name column does not have the same name.
# One of them needs to be renamed:
# vepfile="SYMBOL"
# drugs="Gene.Name"

# colnames(df)[colnames(df) == 'oldName'] <- 'newName'
colnames(vepfile)[colnames(vepfile) == "SYMBOL"] <- "Gene.Name"

# Merge keeping only matches
merged <- merge(x = vepfile,
                y = drugs,
                by = "Gene.Name", all = FALSE)

# Remove empty data "NA"
# Install packeges once (comment out then)
# Load library each time to use "%>%" (command join) and filtering
install.packages("tidyr")
library(tidyr)
install.packages("dplyr")
library(dplyr)
df1 <- merged %>% drop_na(Drug.IDs)

# Make a list of benign variant types that should be removed
filter_out <- 
    'synonymous_variant|UTR|NMD_transcript\
	|non_coding|downstream|upstream\
	|intron|mature_miRNA_variant'

# Then filter out anything matching these terms.
df2 <- df1 %>% filter_all(all_vars(!grepl(filter_out,.)))

# Save an output tsv file for Excel, etc.
write.table((df2), file='./output.tsv', sep="\t", \
quote=FALSE, row.names=FALSE)
```

If you complete this process the output will contain a perfectly merged dataset.
<!-- So in this simple example it takes just 5 minutes to get from a real genome VCF to possibly druggable target genes (see further note on _drug indication_ below). -->

## Downstream interpretation
The next challenge lies downstream in interpreting which variants can have an effect that would justify the use of the drug.

* Are non-coding or synonymous variants worth reporting?
* Genes have multiple transcripts which means one variant can be both coding and non-coding depending on transcript splicing, etc.
* How can we integrate pharmacodynamics, covariates to drug response, contraindications, variant pathogenicity, etc.
<!-- Other sources of sequence data, including the sequences of Watson and Venter; -->  
<!-- [http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/) -->  
<!-- 23andMe open snp data; [https://opensnp.org/genotypes](https://opensnp.org/genotypes). -->
<!-- There are many layers to a this problem to create a usable product. -->

## Drug indication
My example used [DrugBank](https://www.drugbank.ca) for pharmacogenomic information. 
Another option is to use the [FDA information](https://www.fda.gov/drugs/science-research-drugs/table-pharmacogenomic-biomarkers-drug-labeling) as the primary source.

### Is the gene-drug interaction good or bad?
Drugs might be either a treatment for a genetic determinant, or a warning for drug usage in someone who also has a genetic variation that might effect their treatment.
The "Labelling Section" listed by FDA might offer the best information.

[https://www.fda.gov/drugs/](https://www.fda.gov/drugs/science-research-drugs/table-pharmacogenomic-biomarkers-drug-labeling)
For example, if we go and check the Prescribing Information PDF to compare two drugs we see that

<br/>
**(1)** One is used to directly block a gene product,  
**(2)** The second warns about use with certain genetic complications.  

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

## Understanding variant annotation
[Variant Effect Predictor (VEP)](http://grch37.ensembl.org/Homo_sapiens/Tools/VEP/) is very useful.
During variant annotation, VEP supplies a "consequence" column.
Consequences are general and based on translation of genetic code in humans. 
The Loss-of-function (LoF) consequence is the simplest example (splice, stop mutations).
The variant consequence may be one of the defining criteria by which variants can 
be included in analysis since they are _interpretable_ or of ostensibly _known significance_.
_Note: Using this alone could introduce spurious results so it is  best to have a solid criteria 
for selecting consequences of interest_.
The consequences provided by VEP are too long to discuss in detail here.
The table from the ensembl website is worth reading; the HIGH impact variants 
might be a simple method for selecting candidates:
[Ensembl Variation - Calculated variant consequences](https://grch37.ensembl.org/info/genome/variation/prediction/predicted_data.html#consequences).\
<img src="{{ site.baseurl }}{% link images/VEP_consequences.jpg %}" width="100%">

_Note: For a real product, the code should be run offline (a perl program with a few local library dependencies). The databases/cache that it uses are a bit too large to include on in a user software. In the real world you would have to send anonymised packets from the user via an API for accessing the genomic databases hosted on your servers. Make sure to check their license to see if you can use oftware and databases in a commercial product_.
[http://www.ensembl.org/info/about/legal/code_licence.html](http://www.ensembl.org/info/about/legal/code_licence.html) 

Running the software:

* Using VEP is a vital part of converting the DNA variant information (genome position and nucleotide change) into annotated variant effects (protein coding change, gene name, predicted pathogenicity).
* It requires the VEP code to run and requires a copy of the database files (reference genome, gene information, etc.).
* You can upload a small number of variants to the online VEP web server to do this, or you can download the database and code to run on your own computer/server.

So to process your customer/patient data, you have to choose one of these methods:

1. Customer must upload their entire file to your server that runs VEP (1GB - 30GB per individual genome data).
2. Customer must download the database and VEP code to run on their own computer (complex and large download for them, not recommended).

Number 1 is better. But sending one large file often has problems.
If they have a VCF file, you could:

* Break it into small equal sized blocks to upload the data to you. Anonymisation is normal for all internet connections now, but you could just mention that some method of anonymising these blocks is important since someone "hacker" might try to steal information if most of the network data being sent to you contains small VCF format files.
* You could also run a very small piece of code on the cusotmers software application that could extract just the main parts of the VCF file that you need, instead of sending everything. This is explained in sections 7-9. You could say this, but don't need to actually have working. i.e. the drugbank information only includes a certain number of human genes so perhaps you could just extract these using a list of genome coordinates before processing with VEP.

For the license:

* Anyone is free to download and use VEP code.
* However, if you modify or reuse the code commercially it might affect the possibility of getting a patent for your product.
* Your product uses VEP as an intermediate step, so you probably only need to include credit, or other legal info to say you have used it.
* If there were a reason to prevent you using the software commercially, you might be able to make a simple replacement that could give the minimum outputs that you need - gene name and mutation type. If the topic happens to interest you, you can read about [reverse engineering software](https://en.wikipedia.org/wiki/Reverse_engineering#Software).
* As an aside, you could also decide that you don't want to commercialise and offer this tool for free which would prevent bigger companies (like Google) from offering this service in return for harvesting the public's genetic data.

### Optimising VCF annotation
The slowest part of the method is VCF annotation.
You can significantly increase the speed by first reducing the input to contain only regions of interst.
That is, prepare a list of coordinates for each gene, and select for those regions in your input VCF or genotype data before annotation (VEP).

### How to get coordinates for a gene list
Use Biomart.
Their main server was down when I tried, so I went via Ensembl, data access section:  
[http://www.ensembl.org/info/data/biomart/index.html](http://www.ensembl.org/info/data/biomart/index.html)  
Then to use the BioMart data mining tool  
[http://www.ensembl.org/biomart/martview/](http://www.ensembl.org/biomart/martview/28fdaf82da6c02dc5892f99b757e2c44)  
I actually needed the positions using GRCh37 (rather than 38), so I switched to the old Ensembl using  
[http://www.ensembl.org/info/website/tutorials/grch37.html](http://www.ensembl.org/info/website/tutorials/grch37.html)  
to get to [http://grch37.ensembl.org/index.html](http://grch37.ensembl.org/index.html) 
then the Biomart section  
[http://grch37.ensembl.org/biomart/martview/](http://grch37.ensembl.org/biomart/martview/04f009257dadbafbe595155ba910eb5e)

Choose DataBase: Genes 93 Dataset: Human Filter -> Gene -> Input external ref ID list -> (change dropdown) Gene
Name paste your list.
e.g. VPS45 PSMB8 BLNK NEFL NLRP7 SMAD4 PSMB9  
To set the output type: Attributes -> Gene -> select "gene start", "gene stop", "gene name", or anything extra.
Select the "Results" button at the top and export.
The results can be tsv or csv.
You would have to figure out how to extract the regions from the vcf (sed, grep, awk, R code, etc.).
When I needed this, I used my own tools which required converting to format like this "X:1-2000", and ordered by number and alphabetic (some positions in the reference genome were patches added later and have an alphanumeric instead of the normal chromosome).
If you use this list to extract regions from a VCF, remember to include all the original VCF header information.

### Extracting regions from a VCF using a bed file
The early part of this tutorial shows how old-school command line tools can be used to extract data. 
Indeed, this may be computationally most efficient but there are some specialised tools that make the process easier in general.
You can use VCFtools to extract specified regions.  
[https://vcftools.github.io/man_latest.html](https://vcftools.github.io/man_latest.html)  
You could use a list of defined genome position to reduce the size of your dataset. 
The defined genomic coordinates are generally supplied in a file format called the (BED file](https://en.wikipedia.org/wiki/BED_(file_format))
Note that sometimes the bed file "chrom" ID - the name of the chromosome (e.g. chr3) does not match if the VCF file uses "3" instead of "chr3".
You might need to edit the bed.
My bed file was like this:  
(tab spaced), ref.bed  
<br/>
chrom    chromStart    chromEnd  
1    3549    13555  
<br/>
And this command ran OK for me to give "output_prefix.recode.vcf"<br/>
``` bash
$:~/tools/vcftools_0.1.13/bin \
./vcftools \
--vcf ~/input.vcf \
--bed ~/ref.bed \
--out output_prefix \
--recode --keep-INFO-all
```

This new VCF will now only contain gene regions that are potentially "druggable", or at least included on the FDA list.
VCF annotation will be _much faster_ than annotation of the whole genome.

## Unknown variants
In the majority of situations you will be stuck with _variants of unknown significance_.
In the absence of tailored analysis and interpretation of each invidual variant, one must often rank unknown variants based on a predicted pathogenicity.
Carefully consider that predictions can be completed wrong and address how such an annotation should be presented. 
One can rank unknown variants based on PHRED-scaled CADD score, highest being more predicted pathogenic.
https://cadd.gs.washington.edu/info  
[Polyphen](http://genetics.bwh.harvard.edu/pph2/) gives a predicted outcome label and a probability score 0-1 from benign to probably damaging.
See what other pathogenicity prediction tools you can find and estimate how widespread/accepted their usage is.

## Gene dosage
An important cosideration of variant effect depends on gene dosage.
A [dominant gene](https://en.wikipedia.org/wiki/Dominance_(genetics)) may be affected by a single heterozgous variant while a recessive gene may be able to compensate against the negative effect of a heterozyous variant due the presence of a second functional gene copy.
Therefore, the presence of heterozygous or homozygous allele is an important consideration.
Some genes may be sensitive to a [hemizygous](https://en.wikipedia.org/wiki/Zygosity) effect, low frequency [somatic variants](https://en.wikipedia.org/wiki/Somatic_(biology)),
[mosaisism](https://en.wikipedia.org/wiki/Mosaic_(genetics)), etc.
[SNV calling in NGS](https://en.wikipedia.org/wiki/SNV_calling_from_NGS_data) is a broad topic, but it is safe to say that at least the allele dosage (generally heterozygous or homozygous) should be included in result summary.
If possible, when a gene is linked to a specific disease then the [inheritance type](https://en.wikipedia.org/wiki/Heredity) associated with that gene-disease should also be included. 
For example, [https://www.omim.org](https://www.omim.org) is a good place to see examles.
The genetic disease [cystic fibrosis](https://www.omim.org/entry/219700?search=cystic%20fibrosis&highlight=cystic%20fibrosi) is shown with an inheritance type AR (autosomal recessive) meaning that damaging variants on both gene alleles are required to cause disease. 
The gene _cftr_, which is the genetic determinant of cystic fibrosis, also has an [OMIM page _cftr_](https://www.omim.org/entry/602421?search=cftr&highlight=cftr) that also lists AR inheritance.
An excellent resource for matching gene to disease is the [https://panelapp.genomicsengland.co.uk](https://panelapp.genomicsengland.co.uk).
Individual genes can be explored, or "panels" of disease-specific gene lists can be explored. For example, here is the "[Bleeding and platelet disorders](https://panelapp.genomicsengland.co.uk/panels/545/)" panel. 
This shows the "Mode of inheritance" and colour-coded confidence in the disease-gene relationship.
Integrating this type of expert-curated open datasets can be extremely useful.


## Drug indication
The indication or warning can be difficult to automate.
For the example drug  
[https://www.drugbank.ca/drugs/DB11595](https://www.drugbank.ca/drugs/DB11595)  
the section "Pharmacology" "Indication" has the Indication info.  
The FDA label is contained as a PDF attachment in the section "REFERENCES" FDA label Download (245 KB).
If I had to automate the process I would add a URL link for each drug:  
for gene name CD274  
the drugbank column Drug IDs has these:  
DB11595; DB11714; DB11945  
and for each ID you could append the ID onto the drugbank URL to link to the webpage
[https://www.drugbank.ca/drugs/](https://www.drugbank.ca/drugs/).
You can do this in R with some technical how-to reading, or do it manually for a quick example like this and removing space to create a web URL.  
URL				Drug IDs  
https://www.drugbank.ca/drugs/	DB00303  
https://www.drugbank.ca/drugs/	DB00114  
https://www.drugbank.ca/drugs/	DB00142  
https://www.drugbank.ca/drugs/	DB01839  
https://www.drugbank.ca/drugs/	DB00125  

## A large scale example summary
I do not suggest this for a small project, but if I was to automate subsection requests for real:  
- [1] Download the whole database (probably a big table sized >100MB) and  
- [2] For every query (the Drug ID) extract the sections of interest (indication,  Biologic Classification, Description,  FDA label, etc.)  
- [3] Display each section as additional columns in candidate genes table.  
<br/>
- [1] Would be here: [https://www.drugbank.ca/releases/latest](https://www.drugbank.ca/releases/latest)  
- [2] Would be like this: [https://www.w3schools.com/xml/default.asp](https://www.w3schools.com/xml/default.asp)  
Look at example 2, your database request might be something like:
[get food name = Belgian Waffles, description] or
[get drug ID = DB11595, indication,  Biologic Classification, Description,  FDA label.]
The database request problem can be tricky to optimise but not especially difficult with some experience in SQL-type management. 
- [3] For every line in the gene candidate table, do this query request and output the result into the same row.  
The final table would be something that includes colunm headers like:  
Gene, consequence, variant, amino acid, genome position, CADD, DrugBank ID, Description, Indication, FDA label PDF link, etc.
This table could be ranked based on consequence, CADD score.
The top couple of rows then might be converted into a more readable format like a PDF.

## Funding strategy
University-based start-ups ususally follow a plan with three or four funding stages before coming to market. 
It is also possible to get investors from day 1, but it is more usual to follow 
the steps outlined here.
It is also possible to partner with early investors for their guidance rather 
than for financial investment.

#### Example funding stages:

* A - Fundamental research (e.g. SNSF)
* B - Tech development (gap between the basic research and usable product)
* C - Product development (e.g. industry, Innosuisse funding)

#### Example funding sources per stage:

1. [A] Ignite grant
	- <https://www.epfl.ch/innovation/startup/grants/ignition-grants/>
	- 30K - 6 month, salary/consumables

2. [A] Innogrant
	- <https://www.epfl.ch/innovation/startup/grants/innogrants/
	- 100K - 1 year, salary for startup founder.

3. [B] BRIDGE Proof of concept
	- <https://www.bridge.ch/en/proof-of-concept/>
	- 130K - 1 year

4. [B] BRIDGE Discovery 
	- <https://www.bridge.ch/en/discovery/>
	- (alternative to Proof of concept, more for experienced researchers).

5. [C] Innosuisse 
	- Federal funding for startups of social benefit, etc. 
	- <https://www.innosuisse.ch/inno/en/home/start-and-grow-your-business/startup-coaching.html>

6. [C] Other investors, venture capital, or investing from big companies like J&J, Pfizer, &c. For example, in a recent J&J meeting the start-up-related experts discussed how they work with startups. 
<https://advancesindrugdiscovery.splashthat.com>
Basically, the "innovation" department experts help you to figure out what stage you are at. You can contact them as soon as you can disclose your tech non-confidentially (either you have patent protection or do not need it). If you were taking this path you would probably have competed steps 1-4. 

## Legal requirements
#### Swiss law
I include both the English and French translations here as the original source does not always include full English translation. 
Swiss law contains specific provisions on genetic testing in humans.
The Federal Council is divided into [7 departments](https://www.admin.ch/gov/fr/accueil.html) and one chancellory. 
Each department contains their relevant offices (usually fewer than 10). 
For our interests, the governing hierarchy order is as follows:

* Le Conseil fédéral
* The Federal Council
	-  Département fédéral de l'intérieur (DFI), 
	- Federal Department of Home Affair (FDHI),
		- Office fédéral de la santé publique (OFSP).
		- Federal Office of Public Health (FOPH).

This office is then responsible for their relevant ordinances as organised under internal law: 
<https://www.fedlex.admin.ch/en/cc/internal-law/8>.
A direct weblink to our area of interest is available on [Législation Analyses génétiques](https://www.bag.admin.ch/bag/fr/home/gesetze-und-bewilligungen/gesetzgebung/gesetzgebung-mensch-gesundheit/gesetzgebung-genetische-untersuchungen.html), 
but it is useful to view the legal framework in context instead of abstractly.

* Internal law (1-9 sec)
* Droite interne (1-9 sec)
* Sec 8..: (81-86 subsections) Health - Employment - Social security 
* Sec 8..: (81-86 subsections) Santé - Travail - Sécurité sociale
* Sec 81.: Health: (810-819 subsubsections)
* Sec 81.: Santé: (810-819 subsubsections)
* Sec 810: Medicine and human dignity
* Sec 810: Médecine et dignité humaine
* Sec 810.1: Medically assisted reproduction and genetic engineering in the human field
* Sec 810.1: Procréation médicalement assistée et génie génétique dans le domaine humain
* Sec 810.12: Federal Act of 8 October 2004 on Human Genetic Testing (HGTA)
* Sec 810.12: Loi fédérale du 8 octobre 2004 sur l'analyse génétique humaine (LAGH)\
This contains section (810.12) contains 10 sections with 44 articles covering the initial regulations.

Three ordinance then include further details (with several sections, articles, or annexes each):

* Sec 810.122.1: Ordinance of 14 February 2007 on Human Genetic Analysis (OAGH)
* Sec 810.122.1: Ordonnance du 14 février 2007 sur l'analyse génétique humaine (OAGH)
* Sec 810.122.122: Ordinance of the Federal Department of Home Affairs of February 14, 2007 on Human Genetic Analysis (OAGH-DFI)
* Sec 810.122.122: Ordonnance du DFI du 14 février 2007 sur l'analyse génétique humaine (OAGH-DFI)
* Sec 810.122.2: Ordinance of February 14, 2007 on DNA profiling in civil and administrative matters (OACA)
* Sec 810.122.2: Ordonnance du 14 février 2007 sur l'établissement de profils d'ADN en matière civile et administrative (OACA)

The details are then listed individually at:
<https://www.fedlex.admin.ch/fr/cc/internal-law/81#810.12>
and as stated, includes authorisation of "Pharmacogenetic tests performed to determine the effects of a planned therapy", 
"analyses pharmacogénétiques effectuées dans le but de déterminer les effets d’une thérapie prévue".

#### Accreditation
[ISO 15189](https://www.iso.org/standard/56115.html) is a commonly sought standard accreditation for genetic analysis labs, 
which is carried out by recognized accreditation services like [FINAS](https://www.finas.fi/Sivut/default.aspx).
Here it is mentioned for the Geneva health 2030 genome center for clinical grade sequencing:
<https://www.health2030genome.ch/dna-sequencing-platform/>.
Other additional ISO accreditation standard concern 
[Genomic information representation](https://www.iso.org/search.html?q=Genomic%20information%20representation&hPP=10&idx=all_en&p=0&hFR%5Bcategory%5D%5B0%5D=standard),
including
[23092-4 Reference software](https://www.iso.org/standard/75859.html) or 
[23092 Transport and storage of genomic information](https://www.iso.org/standard/79882.html).

GA4GH provides other information about many [legal and ethic topics](https://www.ga4gh.org/genomic-data-toolkit/regulatory-ethics-toolkit/).
BlueprintGenomics is a good example company for comparison:
<https://blueprintgenetics.com/certifications/>.

## Cytochrome P450 (CYP) genes for known PGx
[Cytochrome P450](https://en.wikipedia.org/wiki/Cytochrome_P450) monooxygenases are a group of genes encoding proteins that catalyze the oxidation and metabolism of a large number of xenobiotics and endogenous compounds. 
Therefore these genes/proteins are important for drug metabolism. 
Furthermore, common genetic variants are known for many of these genes which affect how the protein interacts with drugs.
The [Pharmacogene Variation (PharmVar)](https://www.pharmvar.org) consortium repository is used to label human cytochrome P450 (CYP) genes for known PGx variation.
The major focus of PharmVar is to catalogue allelic variation of genes impacting drug metabolism, disposition and response and provide a unifying designation system (nomenclature) for the global pharmacogenetic/genomic community. 
Similar resource include the [Pharmacogenomic KnowledgeBase](https://www.pharmgkb.org), 
and the [Clinical Pharmacogenetic Implementation Consortium](https://cpicpgx.org).
You can [read more in this post](https://lawlessgenomics.com/topic/stargazing) on one example of pharmacogenomic analysis using these resources.

<!-- ## DNA regulation and the 3D genome -->
<!-- There is a collection of reviews on [the 3D genome Nature Reviews 2019](https://www.nature.com/collections/rsxlmsyslk). --> 
<!-- From this, I have collected some illustrations to remind us about the combination of biochemical and physical structure that DNA takes inside each cell. -->

<!-- ### 3D genome variation -->
<!-- DNA is not only a simple string of nucleotides. --> 
<!-- It is constantly wrapped up around proteins which affect its shape and accessibility. -->
<!-- This means that genes encoded on the DNA may take different lengths of time to be expressed and produce proteins. -->
<!-- Some DNA regions may physically cluster together and are labelled as topologically associating domains (TADs). -->
<!-- <!-1- {% cite spielmann2018structural %} -1-> -->
<!-- [https://doi.org/10.1038/s41576-018-0007-0](https://www.nature.com/articles/s41576-018-0007-0) -->

<!-- <img src="{{ site.baseurl }}{% link images/3d_genome/spielmann2018structural_Box1.webp %}" width="50%"> -->
<!-- <!-1- > {% cite spielmann2018structural %} -1-> --> 
<!-- > _Box 1 Chromatin organization  from the 3D nucleus to the linear genome._ -->

<!-- In coding regions, a "damaging" DNA variant will affect the function of a protein, or cause complete loss of that protein. -->
<!-- In some cases, a single gene defect can cause a specific disease. -->
<!-- Similarly, changing the expression of DNA (even if the gene has no damaging coding variants) could cause the same outcome. -->
<!-- Therefore, regions of DNA that control the expression of surrounding genes are just as important as coding variants. --> 
<!-- Historically, effects due to DNA accessibility and expression have been very difficult to understand biologically, but the methods and evidence is improving. --> 

<!-- <img src="{{ site.baseurl }}{% link images/3d_genome/spielmann2018structural_Fig2.webp %}" width="50%"> -->
<!-- <!-1- > {% cite spielmann2018structural %} -1-> --> 
<!-- > _Fig. 2: Clinical examples of structural variations in the 3D genome. a - Duplications of enhancer elements at the IHH locus that occur within topologically associating domains (intra-TAD) cause tissue-specific misregulation and are associated with synpolydactyly of the feet89. For examples see REFS97,104,107,137,138. b - Duplication of a TAD boundary at the SOX9 locus causes neo-TAD formation and is associated with Cooks syndrome, short digits and nail aplasia63. For examples see REFS117,121. c - Deletion of a TAD boundary at the LMNB1 locus causes enhancer adoption and adult-onset demyelinating leukodystrophy139. For examples see REFS117,121,140. d - Inversions of an enhancer cluster at the EPHA4 locus cause enhancer adoption and misregulation of WNT6 and are associated with F-syndrome, syndactyly of thumb and index finger76. For examples see REFS102,114,141. e - Balanced translocations at the MEF2C locus cause a regulator loss of function and are associated with anomalies of the brain (including callosum hypoplasia142) and developmental delay116. For examples see REFS99,104,143. PRS, element associated with Pierre Robin sequence; RevSex, element associated with disorders of sex development. Part c is adapted with permission from REF.113, Elsevier. Part e is adapted with permission from Shimojima, K. et al. De novo microdeletion of 5q14.3 excluding MEF2C in a patient with infantile spasms, microcephaly, and agenesis of the corpus callosum. Am. J. Med. Genet. Part A, REF.142, Copyright 2011 Wiley Periodicals, Inc._ -->

<!-- There are a huge number of methods to quantify 3D genome structure, DNA regulation and expression, mutation within 3D regions, large rearrangements in DNA, etc. -->
<!-- The following figure illustrates one technique. --> 
<!-- We will not discuss all the possibilities here as the technologies are rapidly increasing. -->
<!-- Each large biotech company offers dozens/hundreds of options. --> 
<!-- {% cite de2017capturing %} -->
<!-- [https://doi.org/10.1038/nsmb.3404](https://www.nature.com/articles/nsmb.3404) -->

<!-- <img src="{{ site.baseurl }}{% link images/3d_genome/de2017capturing_fig1.webp %}" width="50%"> -->
<!-- <!-1- > {% cite de2017capturing %} -1-> --> 
<!-- > _Figure 1: Single-cell models of chromosomes reveal principle characteristics of nuclear organization. (a) Single-cell Hi-C is performed to identify contacts between chromosomal regions (1). The contacts are sequenced using Illumina paired-end sequencing (2) and used as restraints in performing computational modeling of 3D genome structures (3). (b) Genome structures recapitulate known features of nuclear organization. Images of genome structures are adapted from ref. 13. (c) Structures of TADs show that they can exist in both compacted and elongated conformations. (d) Schematic representation of the loop-extrusion model. A chromatin region is captured by an extrusion complex forming a tiny loop (2), which is actively extended, leading to the formation of larger loops (3). Ultimately, the extrusion complex releases the chromatin, leading to the dissolving of the loop (4)._ -->

<!-- ### Noncoding DNA regulation -->
<!-- It is useful to understand the mechanisms causing DNA regulation more specifically. -->
<!-- If you want a good understanding of the topic, one of the best resources today is the --> 
<!-- The Genotype-Tissue Expression (GTEx) project -->
<!-- <!-1- {% cite gtex2020gtex %} -1-> -->
<!-- [https://doi.org/10.1126/science.aaz1776](https://www.science.org/doi/10.1126/science.aaz1776). -->
<!-- GTEx include WGS, WES, and RNA-Seq data. -->
<!-- This paper has an excellent overview, and their web interface is informative -->
<!-- [https://www.gtexportal.org/home/](https://www.gtexportal.org/home/). -->

<!-- One of the most common uses of GTEx is as follows: -->

<!-- * When an association between genetic variant and a phenotype is found (e.g. a common DNA variant and heart disease), it is often not due to a coding variant but instead due to a non-coding variant. --> 
<!-- * To understand how this can cause disease, we match DNA and RNA from the same individuals to see how this variant affects the expression level of downstream genes. --> 
<!-- * If the DNA variant is correlated with a change in RNA expression (and subsequently protein level) we can determine its regulatory effect. -->
<!-- * We quantify the RNA expression and its affect on trait (phenotype) within this DNA loci (gene or group of genes): expression quantitative trait loci (eQTL). -->
<!-- * There are other types of QTL, but eQTL are a fine example. --> 

<!-- The following two figures from -->
<!-- <!-1- {% cite elkon2017characterization %} -1-> -->
<!-- [https://doi.org/10.1038/nbt.3863](https://www.nature.com/articles/nbt.3863) -->
<!-- can help to visualise an example of the process. -->

<!-- * In the second figure (labelled Figure 4b) we consider one gene with a certain nucleotide position, having either G or A (2 chromosomes gives possibilites of GG, GA, or AA). -->
<!-- * We can see how one genotype may have lower RNA expression (and less protein produced) for people with two copies of the gene with nucleotide G. -->
<!-- * However, people with one or two copies of this gene with an A nucleotide at the same position may have higher RNA expression levels (and more protein). -->
<!-- * If this gene is used in drug metabolism, then perhaps they should receive a personalised drug dosage. -->

<!-- <img src="{{ site.baseurl }}{% link images/3d_genome/elkon2017characterization_Fig1.webp %}" width="50%"> -->
<!-- <!-1- > {% cite elkon2017characterization %} -1-> --> 
<!-- > _Figure 1: Genome-wide identification of candidate regulatory regions. (a) The conditions in which each gene is expressed are determined by a complex interplay between cis-regulatory DNA elements embedded near the gene's transcription start site (TSS) (the gene's promoter region, typically taken as 1,000 bp upstream to 200 bp downstream of the TSS) and distal enhancer elements located far (along the linear genomic DNA) from the gene's TSS. These DNA elements are bound by TFs that modulated the efficiency by which RNA polymerase is recruited to the gene's TSS to initiate transcription. Image adapted with permission from Figure 1, ref. 21, Springer Nature. (b) Distinct chromatin marks correlate with different regulatory states. Thus, epigenomic profiling of chromatin accessibility, histone modifications and TF binding in large panels of cell lines and tissues predicts comprehensive maps of putative regulatory elements across the genome and indicates the conditions under which each element is active. Reprinted from Figure 2, ref. 157, Mol. Cell., 55, Plank, J.L. & Dean, A., Enhancer function: mechanistic and genome-wide insights come together. 5–14 (2014), with permission from Elsevier. (c) Bidirectional production of eRNAs emerges as an effective mark of active enhancers. Thus, expression profiling of eRNAs is used on top of the epigenomic layers to improve the identification of enhancers and delineate the conditions in which they are activated. This cartoon shows tracks for epigenetic hallmarks of enhancers (DHS, histone marks and TF binding sites (TF BS) in addition to bidirectional production of eRNAs (as detected by GRO-seq))._ -->

<!-- <img src="{{ site.baseurl }}{% link images/3d_genome/elkon2017characterization_Fig4.webp %}" width="50%"> -->
<!-- <!-1- > {% cite elkon2017characterization %} -1-> --> 
<!-- > _Figure 4: Inference of enhancer-promoter links. (a) Enhancer-promoter (E-P) interactions are predicted based on their correlated activation pattern measured over a large panel of cells and tissues. Activation pattern could be measured by epigenetic marks, DHS or transcriptional activity (e.g., mRNA and eRNA levels). (b) Top: eQTL analysis detects associations between SNP genotypes and expression level of target genes. In this example, individuals who are homozygous for the reference allele (GG) show significantly lower expression of the target gene than individuals who are homozygous for the alternative allele (AA). Heterozygous individuals show an intermediate expression level. If either the eQTL SNP itself or any other SNP that is in strong linkage disequilibrium with it is located within a regulatory element, then a putative functional link between that enhancer and the promoter of the associated gene is predicted. Bottom: allele-specific expression analysis requires the presence of a heterozygous SNP within the target RNA (in the figure, the SNP with the T/C alleles), and tests for imbalanced expression from the two copies (maternal and paternal copies) of the gene. Imbalanced expression of the two copies implies that the individual is also heterozygous for another SNP that modulates the activity of a cis-regulatory element that controls the expression of the target gene. The A allele of the SNP located within the enhancer increases the enhancer activity and thus causes elevated expression of the copy of the gene encoded on the same chromosome (the copy of the gene that carries the C allele)._ -->

<!-- ### Chromatin regulation -->
<!-- This paper is not very important to read in detail. However, thee figure is nice for our discussion -->
<!-- <!-1- {% cite keung2015chromatin %} -1-> -->
<!-- [https://doi.org/10.1038/nrg3900](https://www.nature.com/articles/nrg3900#citeas) -->

<!-- <img src="{{ site.baseurl }}{% link images/3d_genome/keung2015chromatin_fig1.webp %}" width="50%"> -->
<!-- > {% cite keung2015chromatin %} _Figure 1: Regulatory features of chromatin at multiple length scales. a - The amino termini of histone proteins have numerous amino acid residues that can be biochemically modified, such as by the addition of methyl (Me), acetyl (Ac), ubiquitin (Ub) and phosphate (P) groups. These modifications influence the binding of DNA and regulatory proteins26. b - Genomic DNA, which itself can be methylated on cytosine residues, is wound around 4 pairs of histone proteins, which collectively comprise a nucleosome15. c - The positioning of nucleosomes on DNA influences the accessibility of transcription factors to regions such as the promoter. Regulatory proteins (orange, blue, red and purple) bind to nucleosomes, DNA and transcribed non-coding RNA (ncRNA). Histone marks (red circles) often appear in large spatial domains; their occupancy as a function of genomic position (red histogram) can be quantified using chromatin immunoprecipitation followed by DNA sequencing (ChIP–seq)19,21. d - Chromosomes exist in spatial territories in the nucleus. There are interactions within and between chromosomes, as well as between chromosomes and nuclear structures such as the nuclear pore, inner nuclear membrane and nuclear lamina18._ -->

<!-- ### Chromatin regulation and mutation -->
<!-- Briefly, we might also consider how to improve our methods over time. -->
<!-- The 3D genome structure also affects how likely mutation is to occur due to the probability of physical biochemical events occurring. -->
<!-- Very simply, "random" mutations occur frequently in DNA. They are either "repaired" or passed on and subject to natural selection. -->

<!-- * Consider the variable frequency of variants across the genome throughout the human population. --> 
<!-- * Also consider that progression towards old age can lead to an increase in such random mutation within a single person (leaving out many citations here). -->

<!-- The paper by {% cite makova2015effects %} --> 
<!-- [https://doi.org/10.1038/nrg3890](https://www.nature.com/articles/nrg3890) -->
<!-- is not important to read - however, their figure is a nice illustration for our discussion. -->

<!-- <img src="{{ site.baseurl }}{% link images/3d_genome/makova2015effects_fig2.webp %}" width="50%"> -->
<!-- <!-1- > {% cite makova2015effects %} -1-> --> 
<!-- > _Figure 2: Aspects of chromatin organization that can affect evolutionary rates. A portion of a chromatin fibre is shown to illustrate closed versus open chromatin and the different types of mutations that occur at higher or lower rates in each case. The closed state can represent quiescent chromatin with little dynamic histone modification or with the repressive modifications histone H3 lysine 9 trimethylation (H3K9me3; associated with heterochromatin) or H3K27me3. Actively transcribed and regulated DNA tends to be in open chromatin marked by DNase-hypersensitive sites, transcription factor occupancy and activating histone modifications such as H3K4me1 (associated with enhancers), H3K4me3 (associated with promoters), H3K36me3 (associated with transcribed chromatin), H3K27 acetylation (H3K27ac) and H4ac (both associated with enhancers and promoters). D, deletion; I, insertion; indel, insertion and deletion; Pol II, RNA polymerase II; S, substitution._ -->

<!-- ## PCA and LD -->
<!-- The following paper is relatively old now. --> 
<!-- However, it illustrates population structure nicely. -->
<!-- As parent pass one their DNA down to children, rearrangements occur. --> 
<!-- However, the DNA rearrangements occur as relatively large stretches of DNA. -->
<!-- Therefore, within a related population most people will have very similar blocks of DNA (including common variants) and only small numbers of novel (rare) variants. -->

<!-- 1. Common variants might be most useful for pharmacogenomics in general since so many people share the same sets of variants / affected gene-drug interactions. -->
<!-- 2. Each individual rare variant only affect a minority. However, they might be rare because they may cause an unusual phenotype which is not as likely to survive natural selection. This unique gene-phenotype might lead to a new discovery in biological mechanism. --> 
<!-- 3. If we share large stretches of DNA in a population, having one common variant means that you are likely to also have the second common variant on the same stretch of DNA. The nature of DNA [linkage disequilibrium](https://en.wikipedia.org/wiki/Linkage_disequilibrium) (LD) allows us to make statistical inferences that are very powerful for genetic analysis. For example, only sequencing a small number of SNPs across the genome which represent each DNA LD block allows us define genetic ancestry (23andMe, forensic genetics, GWAS, etc). -->

<!-- <!-1- {% cite novembre2008genes %} -1-> -->
<!-- [https://doi.org/10.1038/nature07331](https://www.nature.com/articles/nature07331) illustrates how analysis DNA in this way, using principal component analysis (PCA), shows that geographic location and genetic ancestry strongly overlap. --> 
<!-- It also illustrates how tailored medical treatments would generally apply to different people based on their genetic ancestry. -->
<!-- Very few people are likely to require a treatment that is unique only to them. --> 
<!-- Although treatment with a combination of drugs and different gene-drug interactions will increase the level of unique tailoring. -->

<!-- <img src="{{ site.baseurl }}{% link images/3d_genome/novembre2008genes_fig1.webp %}" width="50%"> -->

<!-- <!-1- > {% cite novembre2008genes %} -1-> --> 
<!-- > _Figure 1: Population structure within Europe. a, A statistical summary of genetic data from 1,387 Europeans based on principal component axis one (PC1) and axis two (PC2). Small coloured labels represent individuals and large coloured points represent median PC1 and PC2 values for each country. The inset map provides a key to the labels. The PC axes are rotated to emphasize the similarity to the geographic map of Europe. AL, Albania; AT, Austria; BA, Bosnia-Herzegovina; BE, Belgium; BG, Bulgaria; CH, Switzerland; CY, Cyprus; CZ, Czech Republic; DE, Germany; DK, Denmark; ES, Spain; FI, Finland; FR, France; GB, United Kingdom; GR, Greece; HR, Croatia; HU, Hungary; IE, Ireland; IT, Italy; KS, Kosovo; LV, Latvia; MK, Macedonia; NO, Norway; NL, Netherlands; PL, Poland; PT, Portugal; RO, Romania; RS, Serbia and Montenegro; RU, Russia, Sct, Scotland; SE, Sweden; SI, Slovenia; SK, Slovakia; TR, Turkey; UA, Ukraine; YG, Yugoslavia. b, A magnification of the area around Switzerland from a showing differentiation within Switzerland by language. c, Genetic similarity versus geographic distance. Median genetic correlation between pairs of individuals as a function of geographic distance between their respective populations._ -->

<!-- ## More questions -->

<!-- Q: Do we have to infer that in the future everybody will have his genome sequenced ? -->  
<!-- You do not have to assume this. It may become true. There could be privacy concerns or social problems arising from genetic prejudice, etc. -->

<!-- Q: Before using our algorithm, patient will have to sequence a part of their genome and thus this is a weakness of our algorithm? -->  
<!-- Your tool will provide a service based on genetics. -->  
<!-- Option [1] One has their genetics already and will use it for personal medicine. -->  
<!-- Option [2] they are prescribed a drug and want to only sequence the genes of interest that could affect this drug. -->  
<!-- Option [3] they do not want any genetic info and therefor your product is irrelevant. -->  
<!-- Option [4] they do not want their personal genetics, but are willing to estimate their relatedness to others in a genetic database and therefore calculate a probability of accuracy for this drug-gene information. e.g. both parents are Swiss and therefore based on the population they have probability of X that their genotype is Y. -->  

<!-- Q: Is it realistic to assume that it will be feasible based on the fact that the sequencing cost is decreasing ? -->  
<!-- Irrelevant in this case, but yes, whole genome seq is sometimes below 200CHF will likely be common soon. -->

<!-- Q:  We plan to use polyphen and/or sift in order to discriminate between those types of variants. Is that a good idea? -->  
<!-- That is a good start. CADD score is also pretty well known among physicians. -->
<!-- In my opinion, I do not trust the scores often. -->
<!-- However, it is common that for processing a large amount of data, such prediction tools are useful in general. -->
<!-- For example, I might [1] rank first on VEP variant "consequences"; stop mutations with most importance. -->
<!-- [2] Then rank secondly with these values since you cannot interpret most with consequence = missense variant. --> 

## References
- [https://www.fda.gov/drugs/science-research-drugs/](https://www.fda.gov/drugs/science-research-drugs/table-pharmacogenomic-biomarkers-drug-labeling)
- [https://www.pharmgkb.org/view/drug-labels.do](https://www.pharmgkb.org/view/drug-labels.do)
- Mary V. Relling & William E. Evans. Pharmacogenomics in the clinic. _Nature_ 2015; 526, 343–350\. doi: 10.1038/nature15817
- Yip VL, Hawcutt DB, Pirmohamed M. Pharmacogenetic Markers of Drug Efficacy and Toxicity. _Clin Pharmacol Ther._ 2015;98(1):61-70\. doi: 10.1002/cpt.135.
- David R. Adams, M.D., Ph.D.,  and Christine M. Eng, M.D. Next-Generation Sequencing to Diagnose Suspected Genetic Disorders N Engl J Med Oct 2018 doi: 10.1056/NEJMra1711801

<!-- {% bibliography --cited %} -->


