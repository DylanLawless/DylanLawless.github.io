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
With the popularisation of commercial genetics services, more and more people are now able to "decode" their genetic data.
Questions that might arise from this information include "do I have potentially disease-causing variants that can be treated with a drug?", or "am I taking a drug that will be affected by my genetics?".
To tackle such questions with an example, we use public data in combination with pharmacogenomics.
Outside of genotype data (offered by [23andMe](https://www.23andme.com) for example), the most common file type will be VCF:
[What is a vcf and how should I interpret it?](https://gatkforums.broadinstitute.org/gatk/discussion/1268/what-is-a-vcf-and-how-should-i-interpret-it).

Here is a data source with different genetic data files.
[https://my.pgp-hms.org/public_genetic_data](https://my.pgp-hms.org/public_genetic_data).
To check that it works OK, I tried a quick version of this challenge.
I picked the first whole genome VCF file that I saw (hu24385B 2019-04-07.vcf.g_z)
[https://my.pgp-hms.org/profile/hu24385B](https://my.pgp-hms.org/profile/hu24385B). 
The VCF has 3,461,639 variants.
VCF files can contain a large range of information for each variant, however only the first 7 column are strictly neccessary; Chromosome, position, ID, Reference, Alternate, Qulaity, Filter, info. 
[The details are explained on this GATK forum post.](https://gatkforums.broadinstitute.org/gatk/discussion/1268/what-is-a-vcf-and-how-should-i-interpret-it).
Annotation information about the gene name (or related diseases) is often not present when the VCF is generated and only added later.
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
<br/>
[http://grch37.ensembl.org/Homo_sapiens/Tools/VEP/Results?db=core;tl=jNYYW5ONeVFYnaMM-5265700](http://grch37.ensembl.org/Homo_sapiens/Tools/VEP/Results?db=core;tl=jNYYW5ONeVFYnaMM-5265700)   
<br/>
<img src="https://dylanlawlessblog.files.wordpress.com/2019/05/screenshot-2019-05-07-at-17.01.10.png" width="80%">  
<br/>
Make certain that you use the same reference genome as used on the input data.
The VCF file was made using reference genome GRCh37.
Therefore the Ensembl/VEP website URL should be for that genome build (grch37, not the default GRCh38).

# Running a real example
If you would like to try this using a whole genome using the Ensembl web interface you will need to split your VCF into smaller block first.
For routine usage the command-line version of VEP and it's databases should be installed on run locally.
There are several bioinformatics tools that are commonly used for manipulating genetic file formats such as VCFtools. 
To get a real understanding of the data type, I inlcude here a method using command line bash to split a VCF file into smaller blocks. 
A bash script is printed below where I use very mainstream traditional command-line tools to wrangle data, including 
[gunzip](https://en.wikipedia.org/wiki/Gzip)
to unzip compressed files, 
[wc](https://en.wikipedia.org/wiki/wc_(Unix))
to could lines, 
[cat](https://en.wikipedia.org/wiki/Cat_(Unix))
to print a file, 
[head](https://en.wikipedia.org/wiki/Head_(Unix))
to read the top of a file, 
[sed](https://en.wikipedia.org/wiki/Sed)
to edit lines, 
[awk](https://en.wikipedia.org/wiki/AWK)
for data extraction, and
[grep](https://en.wikipedia.org/wiki/Grep)
which is not used here but it fits well with these other tools - for text search.
Creating a file containing the code below and ending with the filename extension with ".sh" will allow it to be run by your terminal, in this case using the bash language.
I encourage you to read each line and figure out what should happen. If it makes sense then it is reasonable to swap such a manual method with a more efficient specialised tool. 

```
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

# Comparing annotated genetic data to drug lists
Uploading either a small example or your split-whole-genome example, VEP will process the data and annotate it will whatever features you require, including gene names, variant consequence, pahtnogenicy prediction, etc.
The next aim will be to see if any of your output genes are also present in your drug-gene database.
The method will require merging both dataset (gene and drug datasets) based on shared features. 
A simple sanity test would be useful first:

## Small example check of gene list versus drug-gene list
From the VEP output I extracted the gene symbols column and compared against a list of druggable target genes from 
[DrugBank](https://www.drugbank.ca)
(because I happen to have their data on hand, FDA may be more reliable).
I used another command-line method to do this efficienctly:
```bash
cut -f1 -d "," vep_output_file.csv | uniq > unique.genes.txt
```  
- Cut column 1 (f1) 
- with a delimiter comma (,) 
- from the vep output csv file (or tsv, or text file)
- then pipe (\|) that result into another program (sort) to sort the result in alphabetic order
- pipe (\|) again this result into(uniq) 
- so that only one unique gene name is output
- then (>) write the output into the new file "unique.genes.txt".  
<br/>
Repeat the same type of method on the DrugBank dataset to get a list of the gene names contained in DrugBank into a file called "unique.druggable.txt"
The next command will then compare both lists.
<br/>
``` bash
sort unique.genes.txt unique.druggable.txt | uniq -c -i | grep -v '1 '
```  
This command also used "uniq -c" to count how many times each gen name occurs and then "grep -v '1 '" meaning ignore genes that are only present 1 time. 
We want the genes that are present twice, once in each list.
The genes which were in present in both the variant list and DrugBank list are:  
From a 2,000 line VCF file = 
[GABRD](https://www.drugbank.ca/bio_entities/BE0003599),
[PRKCZ](https://www.drugbank.ca/bio_entities/BE0004895),
[SCNN1D](https://www.drugbank.ca/bio_entities/BE0000495)  
From a 10,000 VCF line file = 
[GABRD](https://www.drugbank.ca/bio_entities/BE0003599),
[PRKCZ](https://www.drugbank.ca/bio_entities/BE0004895),
[SCNN1D](https://www.drugbank.ca/bio_entities/BE0000495),
[TP73](https://www.drugbank.ca/bio_entities/BE0008994).

# A real example of merging genetic and pharmacogenomic data
Now that a small example has shown us the logic of the process, we can try a more complex real-world example. 
The following R language script is used to merge the VEP annotated VCF file with a DrugBank database based on the gene names that are common to both datasets.
Read each line and try to understand the process. 
The are many alternative ways to do the same thing in different programming languages. 
This example is done using R. 
I recommending installing R and then installing R studio to edit and run your commands.

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
  file="all.txt",
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
So in this simple example it takes just 5 minutes to get from a real genome VCF to possibly druggable target genes (see further note on _drug indication_ below).
The difficulty lies downstream in interpreting which variants can have an effect that would justify the use of the drug.
Anyone implementing a usable version of this method will incur several obstacles;
e.g. are non-coding or synonymous variants worth reporting?, genes have multiple transcripts which means one variant can be both coding and non-coding depending on transcript splicing, etc.
Other sources of sequence data, including the sequences of Watson and Venter;  
[http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/)  
23andMe open snp data; [https://opensnp.org/genotypes](https://opensnp.org/genotypes).
There are many layers to a this problem to create a usable product.
For example, how to integrate pharmacodynamics, covariats to drug response, contraindications, variant pathogenicity, etc.
However, this is a good start as a learning experience.

# Annotation
[Variant Effect Predictor](http://grch37.ensembl.org/Homo_sapiens/Tools/VEP/) is very useful.
Note: For a real product, the code can run offline (a perl program with a few local library dependencies).
The databases/cache that it uses are a bit too large to include on in a user software.
In the real world you would have to send _anonymised_ packets from the user via an API for accessing the genomic databases hosted on your servers.
Make sure to check their license to see if you can use oftware and databases in a commercial product.  
[http://www.ensembl.org/info/about/legal/code_licence.html](http://www.ensembl.org/info/about/legal/code_licence.html) 

# Drug indication
My example used [DrugBank](https://www.drugbank.ca) for pharmacogenomic information.
However, it may be safest to use the [FDA information](https://www.fda.gov/drugs/science-research-drugs/table-pharmacogenomic-biomarkers-drug-labeling) as the primary source, but including [DrugBank](https://www.drugbank.ca) info is no problem.
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

# Optimising VCF annotation
The slowest part of the method is VCF annotation.
You can significantly increase the speed by first reducing the input to contain only regions of interst.
That is, prepare a list of coordinates for each gene, and select for those regions in your input VCF or genotype data before annotation (VEP).

# How to get coordinates for a gene list
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
To set the output type: Attributes -> Gene -> select “gene start”, “gene stop”, “gene name”, or anything extra.
Select the “Results” button at the top and export.
The results can be tsv or csv.
You would have to figure out how to extract the regions from the vcf (sed, grep, awk, R code, etc.).
When I needed this, I used my own tools which required converting to format like this "X:1-2000", and ordered by number and alphabetic (some positions in the reference genome were patches added later and have an alphanumeric instead of the normal chromosome).
If you use this list to extract regions from a VCF, remember to include all the original VCF header information.

# Extracting regions from a VCF using a bed file
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
```bash
$:~/tools/vcftools_0.1.13/bin \
./vcftools \
--vcf ~/input.vcf \
--bed ~/ref.bed \
--out output_prefix \
--recode --keep-INFO-all
```   
This new VCF will now only contain gene regions that are potentially "druggable", or at least included on the FDA list.
VCF annotation will be _much faster_ than annotation of the whole genome.

# Unknown variants
In the majority of situations you will be stuck with _variants of unknown significance_.
In the absence of tailored analysis and interpretation of each invidual variant, one must often rank unknown variants based on a predicted pathogenicity.
Carefully consider that predictions can be completed wrong and address how such an annotation should be presented. 
One can rank unknown variants based on PHRED-scaled CADD score, highest being more predicted pathogenic.
https://cadd.gs.washington.edu/info  
[Polyphen](http://genetics.bwh.harvard.edu/pph2/) gives a predicted outcome label and a probability score 0-1 from benign to probably damaging.
See what other pathogenicity prediction tools you can find and estimate how widespread/accepted their usage is.

# Gene dosage
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


# Drug indication
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

# A large scale example summary
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

# More questions

Q: Do we have to infer that in the future everybody will have his genome sequenced ?  
You do not have to assume this. It may become true. There could be privacy concerns or social problems arising from genetic prejudice, etc.

Q: Before using our algorithm, patient will have to sequence a part of their genome and thus this is a weakness of our algorithm?  
Your tool will provide a service based on genetics.  
Option [1] One has their genetics already and will use it for personal medicine.  
Option [2] they are prescribed a drug and want to only sequence the genes of interest that could affect this drug.  
Option [3] they do not want any genetic info and therefor your product is irrelevant.  
Option [4] they do not want their personal genetics, but are willing to estimate their relatedness to others in a genetic database and therefore calculate a probability of accuracy for this drug-gene information. e.g. both parents are Swiss and therefore based on the population they have probability of X that their genotype is Y.  

Q: Is it realistic to assume that it will be feasible based on the fact that the sequencing cost is decreasing ?  
Irrelevant in this case, but yes, whole genome seq is sometimes < 200CHF will likely be common soon.

Q:  We plan to use polyphen and/or sift in order to discriminate between those types of variants. Is that a good idea?  
That is a good start. CADD score is also pretty well known among physicians.
In my opinion, I do not trust the scores often.
However, it is common that for processing a large amount of data, such prediction tools are useful in general.
For example, I might [1] rank first on VEP variant "consequences"; stop mutations with most importance.
[2] Then rank secondly with these values since you cannot interpret most with consequence = missense variant. 

# References
- [https://www.fda.gov/drugs/science-research-drugs/](https://www.fda.gov/drugs/science-research-drugs/table-pharmacogenomic-biomarkers-drug-labeling)
- [https://www.pharmgkb.org/view/drug-labels.do](https://www.pharmgkb.org/view/drug-labels.do)
- Mary V. Relling & William E. Evans. Pharmacogenomics in the clinic. _Nature_ 2015; 526, 343–350\. doi: 10.1038/nature15817
- Yip VL, Hawcutt DB, Pirmohamed M. Pharmacogenetic Markers of Drug Efficacy and Toxicity. _Clin Pharmacol Ther._ 2015;98(1):61-70\. doi: 10.1002/cpt.135.
- David R. Adams, M.D., Ph.D.,  and Christine M. Eng, M.D. Next-Generation Sequencing to Diagnose Suspected Genetic Disorders N Engl J Med Oct 2018 doi: 10.1056/NEJMra1711801

