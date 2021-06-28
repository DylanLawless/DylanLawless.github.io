---
layout: topic
title: Genomic analysis code examples
created: 8 Aug 2018
bibliography:
- '../tail/bibliography.bib'
tags: genomics
subject: Genomic analysis
---
{{ page.title }}
================

# Command line example code
**Whole exome analysis**

```bash
#!/bin/bash 
############################################ 
#### The basic protocol for analysis. 
#### It is best to set up a loop that 
#### can run the protocol on all samples. 
############################################ 
# Make project organisation folders 
mkdir ~/1.fastq/ && \
mkdir ~/2.trim/ && \
mkdir ~/3.sort/ && \
mkdir ~/4.dedup/ && \
mkdir ~/5.realtar/ && \
mkdir ~/6.indelrealn/ && \
mkdir ~/7.baserecal/ && \
mkdir ~/9.printbam/ && \
mkdir ~/10.gvcf/ && \
mkdir ~/geno/ && \

############################################ 
#### Typical workflow 
############################################ 

############################################ 
#### [command_cut] 
############################################ 
trim_galore -q 20 -fastqc_args \
-outdir ~/2.trim/QC_reports -illumina -gzip \
-o ~/2.trim/ -length 20 -paired \
~/1.fastq/Sequencing_ID_L001_R1_001.fastq.gz \
~/1.fastq/Sequencing_ID_L001_R2_001.fastq.gz && \

############################################ 
#### [command_align] 
############################################ 
bwa mem -t 12 -M ~/ref/human_g1k_v37.fasta \
~/2.trim/Sequencing_ID_L001_R1_001_val_1.fq.gz \
~/2.trim/Sequencing_ID_L001_R2_001_val_2.fq.gz \
-v 1 -R '@RG\tID:Sample_ID\tSM:Sample_ID \
tPL:ILLUMINA\tLB:Sample_ID' \
-M | samtools view -Sb - > ~/2.trim/Sample_ID.bam && \

############################################ 
#### [command_sort] 
############################################ 
java -Xmx8g -jar ~/picard/picard-tools-2.5.0/picard.jar \
SortSam \
I= ~/2.trim/Sample_ID.bam \
O= ~/3.sort/Sample_ID.sort.bam \
SO=coordinate CREATE_INDEX=TRUE && \

############################################ 
#### [command_dedup] 
############################################ 
java -Xmx8g -jar ~/picard/picard-tools-2.5.0/picard.jar \
MarkDuplicates \
I= ~/3.sort/Sample_ID.sort.bam \
O= ~/4.dedup/Sample_ID.sort.dedup.bam \
M= ~/4.dedup/Sample_ID.sort.dedup.metrics \
CREATE_INDEX=TRUE && \

############################################ 
#### [command_realtar] 
############################################ 
java -Xmx6g -jar ~/GATK/GenomeAnalysisTK.jar \
-T RealignerTargetCreator \
-R ~/ref/human_g1k_v37.fasta \
-known ~/ref/1000G_phase1.indels.b37.vcf \
-known ~/ref/Mills_and_1000G_gold_standard.\ indels.b37.sites.vcf \
-I ~/4.dedup/Sample_ID.sort.dedup.bam \
-o ~/5.realtar/Sample_ID.sort.dedup.bam.intervals && \

############################################ 
#### [command_indelrealign]
############################################ 
java -Xmx6g -jar ~/GATK/GenomeAnalysisTK.jar \
-T IndelRealigner \
-R ~/ref/human_g1k_v37.fasta \
-known ~/ref/1000G_phase1.indels.b37.vcf \
-known ~/ref/Mills_and_1000G_gold_standard.\ indels.b37.sites.vcf \
-I ~/4.dedup/Sample_ID.sort.dedup.bam \
-targetIntervals \
~/5.realtar/Sample_ID.sort.dedup.bam.intervals \
-o ~/6.indelrealn/Sample_ID.sort.dedup.indelrealn.bam && \

############################################ 
#### [command_bsqr] 
############################################ 
java -Xmx8g -jar ~/GATK/GenomeAnalysisTK.jar \
-T BaseRecalibrator \
-R ~/ref/human_g1k_v37.fasta \
-knownSites ~/ref/dbSnp146.b37.vcf.gz \
-knownSites ~/ref/1000G_phase1.indels.b37.vcf \
-knownSites ~/ref/Mills_and_1000G_gold_standard.\ indels.b37.sites.vcf \
-o ~/7.baserecal/Sample_ID.sort.dedup.indelrealn.recal.grp \
-I ~/6.indelrealn/Sample_ID.sort.dedup.indelrealn.bam \
-nct 6 && \

############################################ 
#### Optional check for base recalibration 
############################################ 
####  Print reads
############################################ 
java -Xmx12g -jar ~/GATK/GenomeAnalysisTK.jar \
-T PrintReads \
-R ~/ref/human_g1k_v37.fasta \
-I ~/6.indelrealn/Sample_ID.sort.dedup.indelrealn.bam \
-BQSR ~/7.baserecal/Sample_ID.sort.dedup.indelrealn.recal.grp \
-o ~/9.printbam/Sample_ID.sort.dedup.indelrealn.recal.bam \
-disable_indel_quals && \

############################################ 
#### [command_hc] 
############################################ 
java -Xmx8g -jar ~/GATK/GenomeAnalysisTK.jar \
-T HaplotypeCaller -emitRefConfidence GVCF \
-R ~/ref/human_g1k_v37.fasta \
-D ~/ref/dbSnp146.b37.vcf.gz \
-stand_call_conf 30 \
-stand_emit_conf 10 \
-o ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-L ~/ref/SureSelectAllExonV6/S07604514_Regions_b37.bed \
-ip 30 && \
# deprecated -I ~/9.printbam/Sample_ID.sort.dedup.indelrealn.recal.bam

############################################ 
#### [command_joint] 
############################################ 
java -Xmx12g -jar ~/GATK/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R ~/ref/human_g1k_v37.fasta \
-D ~/ref/dbSnp146.b37.vcf.gz -stand_call_conf 30 \
-stand_emit_conf 10 \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-o ~/geno/genotype.vcf -nda -showFullBamList -nt 12 && \

############################################ 
#### Hard filter selecting SNVs 
############################################ 
java -Xmx12g -jar ~/GATK/GenomeAnalysisTK.jar \
-T SelectVariants \
-R ~/ref/human_g1k_v37.fasta \
-selectType SNP \
-variant ~/geno/genotype.vcf \
-o ~/geno/genotype.raw-snps.vcf && \

############################################ 
#### Hard filter selecting INDELs 
############################################ 
java -Xmx12g -jar ~/GATK/GenomeAnalysisTK.jar \
-T SelectVariants \
-R ~/ref/human_g1k_v37.fasta \
-variant ~/geno/genotype.vcf \
-selectType INDEL -selectType MNP \
-o ~/geno/genotype.raw-indels.vcf && \

############################################ 
#### Applying hard filter for SNVs 
############################################ 
java -Xmx8g -jar ~/GATK/GenomeAnalysisTK.jar \
-T VariantFiltration \
-R ~/ref/human_g1k_v37.fasta \
-V ~/geno/genotype.raw-snps.vcf \
-filterExpression QD < 2.0 || FS > 60.0 || MQ < 40.0 ||\
MappingQualityRankSum < -12.5 || ReadPosRankSum < -8.0 \
-filterName snp_hard_filter \
-o ~/geno/genotype.raw-snps.filtered.snvs.vcf && \

############################################ 
#### Applying hard filter for INDELs 
############################################ 
java -Xmx8g -jar ~/GATK/GenomeAnalysisTK.jar \
-T VariantFiltration \
-R ~/ref/human_g1k_v37.fasta \
-V ~/geno/genotype.raw-indels.vcf \
-filterExpression QD < 2.0 || FS > 200.0 ||\
ReadPosRankSum < -20.0 \
-filterName indel_hard_filter \
-o ~/geno/genotype.raw-indels.filtered.indels.vcf && \

############################################ 
#### Combine filtered results 
############################################ 
java -Xmx8g -jar ~/GATK/GenomeAnalysisTK.jar \
-T CombineVariants -R ~/ref/human_g1k_v37.fasta \
-variant ~/geno/genotype.raw-snps.filtered.snvs.vcf \
-variant ~/geno/genotype.raw-indels.filtered.indels.vcf \
-o ~/geno/genotype.fltd-combinedvars.vcf \
-genotypemergeoption UNSORTED && \

############################################ 
#### Filter variants in EdbSNP >/= 1% \
#### and not listed as pathogenic by ClinVar 
############################################ 
perl ~/vcfhacks-v0.2.0/annotateSnps.pl \
-d ~/ref/dbSnp146.b37.vcf.gz ~/ref/clinvar_20160531.vcf.gz \
-f 1 -pathogenic \
-i ~/geno/genotype.fltd-combinedvars.vcf \
-o ~/geno/genotype.fltd-combinedvars.1pcdbsnp.vcf \
-t 12 && \

############################################ 
#### Filter variants in EVS greater >/= 1% 
############################################ 
perl ~/vcfhacks-v0.2.0/filterOnEvsMaf.pl -d ~/ref/evs/ \
-f 1 -progress \
-i ~/geno/genotype.fltd-combinedvars.1pcdbsnp.vcf \
-o ~/geno/genotype.fltd-combinedvars.1pcdbsnp.1pcEVS.vcf \
-t 12 && \

############################################ 
#### Exac filter for population frequency 
############################################ 
perl ~/vcfhacks-v0.2.0/filterVcfOnVcf.pl \
-i ~/geno/genotype.fltd-combinedvars.1pcdbsnp.1pcEVS.vcf \
-f ~/ref/ExAC/ExAC.r0.3.sites.vep.vcf.gz \
-o ~/geno/genotype.fltd-combinedvars.1pcdbsnp.1pcEVS.exac.vcf \
-w -y 0.01 \
-b \
# progress bar \
-t  && \
# number of threads

############################################ 
#### Annotate with variant effect predictor 
############################################ 
perl ~/variant_effect_predictor/variant_effect_predictor.pl \
-offline -vcf -everything \
-dir_cache ~/variant_effect_predictor/vep_cache \
-dir_plugins ~/variant_effect_predictor/vep_cache/Plugins \
-plugin Condel,\
~/variant_effect_predictor/vep_cache/Plugins/config/Condel/config/ \
-plugin ExAC,~/ref/ExAC/ExAC.r0.3.sites.vep.vcf.gz \
-plugin SpliceConsensus \
-fasta \
~/variant_effect_predictor/fasta/\
Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz \
-i ~/geno/genotype.fltd-combinedvars.1pcdbsnp.1pcEVS.exac.vcf \
-o ~/geno/genotype.fltd-combinedvars.1pcdbsnp.1pcEVS.exac.vep.vcf \
-fork 12 && \

############################################ 
#### Confirm samples names 
############################################ 
perl ~/vcfhacks-v0.2.0/getSampleNames.pl \
-i ~/geno/genotype.fltd-combinedvars.1pcdbsnp.1pcEVS.exac.vep.vcf && \


############################################ 
## Data extraction 
############################################ 
#### Extract columns 
############################################ 
#### A list of files for
#### where the data from
#### one column is compiled into
#### a master table 
############################################ 

############################################ 
#### This takes column 3 from every file
#### and appends to the output file.
#### Space delimited. 
############################################ 
awk FNR==1{f++}{a[f,FNR]=$3}END{for(x=1;x<=FNR;x++)\ 
{for(y=1;y<ARGC;y++)printf(%s ,a[y,x]);print }} \
./../*/pheno.txt > master.txt

############################################ 
#### The spacer method can be changed; tab, space, comma, etc.
#### Another way to convert later is with the following command.
#### [The tab character (after s/) must be removed
#### and printed to the command line using ctrl+v then tab.] 
############################################ 
sed 's/ /,/g' input.tsv > output.csv

############################################ 
#### Candidate filter
############################################ 
#### Filter a VCF on a candidate gene list. 
############################################ 
#### List format as X:1-2000,
#### or -b for a bed file or
#### a list file with 1 per line. 
############################################ 
for f in ~/immune.panel/vep/*.vcf do 
perl ~/vcfhacks-v0.2.0/filterVcfOnLocation.pl \
-i ~/immune.panel/vep/$f \
-b ~/deep.panel.bed \
-o ~/immune.panel/filter/$( basename -s .vcf $f ).panel.vcf \
done

############################################ 
#### Post-routine analysis candidate filtering.
#### Similar filtering can be done without going back
#### to analysis stages to create a virtual panel. 
############################################ 
#### Export all gene names and give the count.
sort list.txt | \
uniq -c > InflammatoryDisorderCohortHitCount.txt
#### Format to csv.
#### Cross against a master list of immune genes.

############################################ 
#### In R, import data 
############################################ 
master <- read.csv(./master.csv, stringsAsFactors=FALSE)
InflammatoryDisorderCohortHitCount <- \
read.csv(./ InflammatoryDisorderCohortHitCount.csv, stringsAsFactors=FALSE)

############################################ 
#### Merge the master immune gene list
#### with the Inflammatory disorder cohort hits. 
############################################ 
combine <- merge(master, InflammatoryDisorderCohortHitCount, 
        by = Gene, all = TRUE)

############################################ 
#### Remove the genes that happen to overlap
#### gene of interest and remove anything from
#### the master list that is not in the cohort list. 
############################################ 
clean <- na.omit(combine)

############################################ 
#### Write out the table. 
############################################ 
write.csv(clean, ./GenesOfInterest.csv, row.names = FALSE)

############################################ 
#### The output can be sorted as of interest
#### e.g. autosomal dominant autoinflammatory gene. 
############################################ 

############################################ 
#### Tailored filtering
############################################ 
#### Filter on sample.
#### May need use a -freq option
#### to account for index hopping.
#### Filter on sample removes anything shared
#### with cases (-s) that are not listed but not others (-x). 
############################################ 
perl /home/vcfhacks-v0.2.0/filterOnSample.pl \
-i ~/samples.vep.vcf \
-s case.1 case.2 case.3 -x \
-o ~/samples.getFunctionalVariantsVep.vcf

############################################ 
#### Get variants. 
############################################ 
#### Getting functional variants. The -n flag allows
#### selections only when >2 samples
#### have variants in a shared gene. 
perl /home/vcfhacks-v0.2.0/getFunctionalVariants.pl \
-s case.1 case.2 case.3 \
-i ~/samples.vep.vcf \
-f -n 2 \
-o ~/samples.getFunctionalVariantsVep.SharedGenes.vcf

#### Candidate compound heterozygous.
#### Only variants that are common in ALL -s are considered.
#### Flag -n specifies the number of cases
#### required to return a genotype. 
perl /home/vcfhacks-v0.2.0/findBiallelic.pl \
-i ~/samples.vep.vcf \
-s case.1 case.2 case.3 \
-n 1 \
-o ~/samples.findBiallelic.all.vcf

############################################ 
#### Rank, annontate, and simplify 
############################################ 
perl /home/vcfhacks-v0.2.0/rankOnCaddScore.pl \
-c /data/shared/cadd/v1.3/*.gz \
-i ~/samples.getFunctionalVariantsVep.SharedGenes.vcf \
-o ~/samples.getFunctionalVariantsVep.SharedGenes.cadd.ranked.vcf \
-progress

perl /home/vcfhacks-v0.2.0/geneAnnotator.pl \
-d /home/vcfhacks-v0.2.0/data/geneAnnotatorDb \
-i ~/samples.findBiallelic.all.vcf \
-o ~/samples.findBiallelic.all.gene.anno

perl /home/vcfhacks-v0.2.0/annovcfToSimple.pl \
-i ~/samples.findBiallelic.all.gene.anno \
-vep -gene_anno \
-canonical_only \
-u -contains_variant \
-o ~/samples.findBiallelic.all.gene.anno.simple.xlsx

```
