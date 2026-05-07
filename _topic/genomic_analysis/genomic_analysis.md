---
layout: topic
title: Genomic analysis for precision medicine
description: A clear introduction to DNA sequencing, exome sequencing, whole genome sequencing, variant calling, annotation, interpretation, and precision medicine.
tags: genomics precision-medicine DNA sequencing rare-disease bioinformatics
subject: Genomic analysis
permalink: /topic/genomic-analysis/
---

# Genomic analysis for precision medicine

Genomic analysis turns DNA sequence data into evidence.

The task is not only to find variants. The task is to decide which variants were measured, which were missed, which are common, which are rare, which may change protein function, and which can support a clinical or biological conclusion.

This page gives a practical map of the field. It is written for readers learning genomics, rare disease analysis, bioinformatics, or precision medicine.

## The short version

DNA sequencing produces reads.

Reads are aligned to a reference genome.

Aligned reads are converted into variant calls.

Variant calls are annotated with biological, clinical, and population data.

Interpretation combines variant evidence with phenotype, inheritance, mechanism, and uncertainty.

The main file types are:

| File type | Meaning |
| --- | --- |
| FASTQ | Raw sequencing reads and base quality scores |
| BAM or CRAM | Reads aligned to a reference genome |
| VCF or gVCF | Genetic variants and genotype-level evidence |
| BED | Genomic intervals, often used for gene panels or exome targets |
| TSV, CSV, JSON or HTML | Interpreted results, reports, tables, and machine-readable summaries |

The main reference choice is also critical. A genomic coordinate only has meaning relative to a specific genome build, usually GRCh37, GRCh38, or T2T-CHM13.

## Exome sequencing and genome sequencing

Exome sequencing reads mainly the protein-coding regions of the genome.

Whole genome sequencing reads coding, non-coding, mitochondrial, structural, and regulatory regions more evenly.

Gene panels read selected genes.

Each approach has a different purpose.

| Test | What it measures | Common use |
| --- | --- | --- |
| Gene panel | Selected disease genes | Focused diagnosis, lower cost, easier interpretation |
| Whole exome sequencing | Most protein-coding exons | Rare disease, Mendelian disorders, gene discovery |
| Whole genome sequencing | The full genome | Rare disease, structural variants, non-coding variants, research, long-term data reuse |
| Long-read sequencing | Longer DNA fragments | Repeat expansions, structural variants, phasing, difficult regions |
| Ultra-deep sequencing | Very high depth at selected loci | Low-level mosaicism, somatic variants, cancer, autoinflammatory disease |

Exome sequencing remains useful because coding variants are often easier to interpret. Whole genome sequencing is stronger when the question includes structural variation, non-coding regulation, copy number change, repeat expansions, mitochondrial DNA, phasing, or future reuse.

In precision medicine, whole genome sequencing is often the better long-term data asset. Exome sequencing can still be the better immediate diagnostic test when cost, coverage, and interpretation are the main constraints.

## Sample preparation

Most germline sequencing begins with DNA from blood, saliva, or tissue.

Blood is often preferred because it gives reliable DNA quality and usually represents the inherited genome well. Saliva can work, but bacterial DNA contamination and variable sample quality can affect sequencing. Tumour, skin, buccal, fibroblast, or sorted cell samples may be needed when mosaicism or somatic disease is suspected.

Before sequencing, laboratories usually check:

| Check | Purpose |
| --- | --- |
| DNA quantity | Enough DNA for library preparation |
| DNA purity | Absence of inhibitors or contamination |
| DNA integrity | Fragment size and degradation |
| Sample identity | Avoiding swaps and contamination |
| Consent and metadata | Ensuring lawful and interpretable use |

For exome sequencing and panels, DNA is fragmented, adapted, indexed, captured with probes, and sequenced. Capture systems include products such as Agilent SureSelect, IDT xGen, Twist Bioscience panels, and Roche KAPA or SeqCap designs.

For whole genome sequencing, capture is usually not required. The full library is sequenced after fragmentation, adaptor ligation, indexing, amplification or PCR-free preparation.

PCR-free whole genome sequencing is often preferred when the goal is uniform coverage and fewer amplification artefacts.

## Sequencing platforms

Most clinical and research short-read sequencing still uses Illumina instruments. Common platform families include MiSeq, NextSeq, NovaSeq, and older HiSeq systems.

Other relevant technologies include:

| Technology | Typical use |
| --- | --- |
| Illumina short-read sequencing | Germline SNVs, indels, exomes, genomes, panels |
| Element Biosciences AVITI | Short-read sequencing with alternative chemistry |
| MGI DNBSEQ | Short-read sequencing at scale |
| Oxford Nanopore | Long reads, structural variants, methylation, rapid sequencing |
| PacBio HiFi | Accurate long reads, structural variants, phasing, repeat regions |

Short reads are efficient for SNVs and small indels. Long reads are stronger for structural variants, repeat expansions, phasing, and difficult genomic regions.

A modern precision medicine programme may use both.

## A practical analysis workflow

A typical short-read germline workflow follows this structure.

```text
FASTQ
  ↓
quality control
  ↓
alignment to reference genome
  ↓
BAM or CRAM
  ↓
duplicate marking and quality recalibration
  ↓
variant calling
  ↓
gVCF or VCF
  ↓
joint genotyping or cohort merging
  ↓
variant filtering
  ↓
annotation
  ↓
clinical or research interpretation
```

Useful tools include:

| Step | Common tools |
| --- | --- |
| FASTQ quality control | FastQC, MultiQC, fastp |
| Adapter trimming | fastp, Trim Galore, Cutadapt |
| Alignment | BWA-MEM, BWA-MEM2, DRAGMAP, minimap2 |
| BAM processing | samtools, Picard, Sambamba |
| Germline SNV and indel calling | GATK HaplotypeCaller, DeepVariant, Sentieon DNAscope, DRAGEN |
| Joint genotyping | GATK GenomicsDBImport, GATK GenotypeGVCFs, GLnexus |
| Somatic SNV and indel calling | GATK Mutect2, Strelka2, VarDict, Octopus |
| Structural variant calling | Manta, Delly, Lumpy, GRIDSS, Sniffles, cuteSV |
| Copy number calling | ExomeDepth, XHMM, CNVkit, GATK gCNV, Canvas |
| Variant normalisation | bcftools norm, vt |
| Variant annotation | Ensembl VEP, ANNOVAR, SnpEff, Nirvana |
| Workflow management | Nextflow, Snakemake, WDL, Cromwell |

The exact tools matter less than the traceability of the workflow. A useful analysis records the reference genome, software versions, parameters, input files, output files, and quality metrics.

## Reference genomes

The reference genome is the coordinate system for the analysis.

A variant reported as `chr7:117559593` only means something if the genome build is known. The same biological variant may have different coordinates in GRCh37, GRCh38, and T2T-CHM13.

Common references include:

| Reference | Use |
| --- | --- |
| GRCh37 or hg19 | Older clinical and research databases |
| GRCh38 or hg38 | Current standard for many new analyses |
| T2T-CHM13 | More complete telomere-to-telomere assembly |
| hs37d5 | GRCh37 with decoy sequences, used in many older pipelines |
| GRCh38 with ALT contigs | Improved representation of difficult regions |

Modern analyses should usually use GRCh38 unless there is a clear reason to remain on GRCh37.

The reason many older datasets use GRCh37 is practical. Large historical cohorts, clinical databases, and analysis pipelines were built around it. Reanalysis on GRCh38 improves consistency for new work but requires careful liftOver, remapping, or reprocessing.

## Quality control

Quality control asks whether the data are suitable for interpretation.

Useful checks include:

| Level | Examples |
| --- | --- |
| Sample identity | Sex check, kinship, relatedness, contamination, sample swap detection |
| Sequencing quality | Q30, read depth, duplication rate, insert size, GC bias |
| Alignment quality | Mapping rate, coverage uniformity, off-target rate |
| Variant quality | Ti/Tv ratio, heterozygosity, call rate, allele balance |
| Cohort quality | Batch effects, ancestry, principal components, outlier samples |
| Clinical quality | Coverage over disease genes, reportable regions, medically relevant gaps |

Common tools include FastQC, MultiQC, samtools stats, Picard CollectHsMetrics, Picard CollectWgsMetrics, VerifyBamID, Somalier, PLINK, bcftools, mosdepth, and GATK CollectReadCounts.

For precision medicine, a negative result is only meaningful if the relevant regions were actually measured. A report should distinguish “no variant found” from “the region was not adequately assessed”.

## Variant calling

Variant calling converts aligned reads into genetic differences from the reference.

The main variant classes are:

| Variant type | Meaning |
| --- | --- |
| SNV | Single nucleotide variant |
| Indel | Small insertion or deletion |
| MNV | Multi-nucleotide variant |
| CNV | Copy number variant |
| SV | Structural variant |
| STR or repeat expansion | Variable repeat sequence |
| mtDNA variant | Mitochondrial genome variant |
| Mosaic or somatic variant | Variant present in only some cells |

A single caller rarely captures every class well. SNVs and indels may be handled by GATK HaplotypeCaller or DeepVariant. Structural variants may require Manta, Delly, GRIDSS, Sniffles, or cuteSV. Copy number variants may require ExomeDepth, CNVkit, GATK gCNV, or Canvas.

Long-read sequencing improves variant detection in repetitive and structurally complex regions.

## Annotation

Annotation adds biological and clinical context to variants.

A raw VCF tells us the coordinate, genotype, and quality metrics. It does not explain whether the variant affects a gene, changes a protein, is common in the population, or has been reported in disease.

Common annotation resources include:

| Resource | Use |
| --- | --- |
| Ensembl VEP | Transcript consequence annotation |
| ANNOVAR | Variant annotation framework |
| SnpEff | Variant consequence annotation |
| MANE Select | Preferred matched Ensembl and RefSeq transcripts |
| GENCODE | Gene and transcript models |
| ClinVar | Submitted clinical variant interpretations |
| gnomAD | Population allele frequencies and constraint metrics |
| dbSNP | Variant identifiers |
| OMIM | Mendelian disease genes and phenotypes |
| Orphanet | Rare disease information |
| ClinGen | Gene-disease validity and dosage sensitivity |
| PanelApp | Curated disease-gene panels |
| HGNC | Approved gene symbols |
| HPO | Human phenotype ontology |
| UniProt | Protein function and domains |
| Pfam and InterPro | Protein domains and families |
| AlphaFold DB | Predicted protein structures |
| STRING | Protein interaction networks |

Good annotation depends on transcript choice. For clinical work, MANE Select transcripts are often preferred where available. A variant can appear missense on one transcript and non-coding on another, so transcript reporting must be explicit.

## Population frequency

Population allele frequency is one of the strongest filters in rare disease analysis.

A fully penetrant variant causing a very rare dominant disease should not be common in the general population. A recessive pathogenic variant can be more common because carriers may be unaffected.

The most widely used population resource is gnomAD. It provides allele frequencies across large cohorts and ancestry groups. Other resources may be relevant in specific settings, including TOPMed, UK Biobank, 1000 Genomes, All of Us, and national reference datasets.

Frequency filtering should consider:

| Factor | Why it matters |
| --- | --- |
| Disease prevalence | Common variants cannot usually cause very rare diseases alone |
| Inheritance model | Dominant, recessive, X-linked, mitochondrial, de novo |
| Penetrance | Low penetrance permits higher population frequency |
| Ancestry | A variant may be rare globally but common in one ancestry group |
| Technical quality | Some recurrent calls are artefacts |
| Cohort context | Internal frequency can reveal batch effects or shared ancestry |

A simple minor allele frequency threshold can be useful, but it is not interpretation. Frequency is evidence that must be combined with mechanism, phenotype, segregation, and variant effect.

## Disease-gene panels

A disease-gene panel is a curated list of genes relevant to a phenotype or clinical indication.

Panels are useful because they define the search space. They also make interpretation more reproducible. A rare missense variant in a gene unrelated to the phenotype is usually less useful than a rare damaging variant in a validated disease gene.

Important panel resources include:

| Resource | Use |
| --- | --- |
| Genomics England PanelApp | Curated gene panels with confidence levels |
| ClinGen | Gene-disease validity and dosage curation |
| OMIM | Mendelian disease-gene relationships |
| Orphanet | Rare disease entities and genes |
| ACMG Secondary Findings list | Genes recommended for reporting of actionable secondary findings |
| HPO | Phenotype terms used to select relevant genes |

Panel selection should be recorded. A report should state which genes were assessed, which transcripts were used, and which regions had insufficient coverage.

Virtual panels are often applied to genome or exome data after sequencing. This allows reanalysis when gene knowledge changes.

## Variant interpretation

Variant interpretation asks whether a variant explains a phenotype.

For rare disease, interpretation usually combines:

| Evidence type | Examples |
| --- | --- |
| Variant consequence | Missense, nonsense, frameshift, splice, structural |
| Gene-disease validity | ClinGen, OMIM, PanelApp, published cases |
| Population frequency | gnomAD, ancestry-specific frequency, internal controls |
| Inheritance | Dominant, recessive, de novo, compound heterozygous, X-linked |
| Segregation | Does the variant track with disease in the family |
| Phenotype match | HPO similarity, clinical fit, disease mechanism |
| Functional evidence | Assays, expression, protein studies, model systems |
| Computational prediction | SpliceAI, CADD, REVEL, AlphaMissense, ESM1b |
| Constraint | LOEUF, pLI, missense Z-score, regional constraint |
| Previous classification | ClinVar, locus-specific databases, literature |

The ACMG and AMP framework is the main clinical structure for germline variant classification. It classifies variants as pathogenic, likely pathogenic, uncertain significance, likely benign, or benign.

That label is useful, but it is not the whole conclusion. A patient-level diagnosis also needs gene validity, phenotype match, inheritance consistency, and confidence that the relevant regions were measured.

## Inheritance models

Inheritance is often the fastest way to reduce candidate variants.

| Model | Typical pattern |
| --- | --- |
| Autosomal dominant | One disease-causing allele may be sufficient |
| Autosomal recessive | Two affected alleles in the same gene are usually required |
| Compound heterozygous | Two different variants affect the two copies of one gene |
| X-linked | Variant on the X chromosome, often sex-dependent |
| De novo | Variant present in the child but absent from parents |
| Mitochondrial | Variant in mitochondrial DNA, often heteroplasmic |
| Mosaic | Variant present in only a fraction of cells |
| Somatic | Acquired variant, common in cancer and some inflammatory disorders |

Trio sequencing is powerful because it shows inheritance directly. A trio includes the affected child and both biological parents. It helps identify de novo variants, recessive inheritance, compound heterozygosity, and sample mix-ups.

## Phenotype data

Genomic interpretation is weaker without structured phenotype data.

The Human Phenotype Ontology, or HPO, provides standard terms for clinical features. Examples include `HP:0001250` for seizure, `HP:0001631` for atrial septal defect, and `HP:0001249` for intellectual disability.

HPO terms help match patients to disease-gene panels, OMIM diseases, and published cases. Tools such as Exomiser, PhenoTips, LIRICAL, Phen2Gene, and PanelAppRex AI use phenotype information to prioritise genes or panels.

Phenotype quality matters. “Developmental delay” is less informative than a structured set of age of onset, neurological findings, growth measurements, imaging results, immune features, and laboratory abnormalities.

## Precision medicine

Precision medicine uses molecular evidence to guide diagnosis, prognosis, prevention, treatment, or data reuse.

In genomics, precision medicine can include:

| Area | Example |
| --- | --- |
| Rare disease diagnosis | Identifying a causal variant in a Mendelian disorder |
| Cancer genomics | Matching tumour variants to therapy, prognosis, or trials |
| Pharmacogenomics | Using CYP2D6, CYP2C19, TPMT, DPYD, SLCO1B1, or HLA genotypes |
| Carrier screening | Identifying reproductive risk for recessive disorders |
| Newborn sequencing | Early detection of actionable inherited conditions |
| Polygenic risk | Estimating inherited risk across many common variants |
| Infectious disease genomics | Host or pathogen genomic contribution to disease |
| Multi-omics | Integrating DNA, RNA, protein, metabolite, and phenotype evidence |

Precision medicine depends on infrastructure as much as sequencing. Results must be traceable, reproducible, interpretable, and updateable.

A genome sequenced today may become more informative years later. That only works if the raw files, metadata, reference build, consent, and interpretation records are preserved.

## Reanalysis

A negative genomic result is not always final.

Reanalysis can find diagnoses because gene-disease knowledge improves, variant databases grow, phenotype information becomes clearer, and methods improve.

Common reasons to reanalyse include:

| Reason | Example |
| --- | --- |
| New disease gene | A gene was not known at the first analysis |
| Updated ClinVar classification | A VUS becomes likely pathogenic or benign |
| Improved phenotype | New HPO terms refine the search |
| Better caller | Structural variant or repeat expansion detected later |
| New reference | GRCh38 or T2T improves mapping |
| Additional family data | Segregation becomes informative |
| RNA or protein evidence | Multi-omics supports a candidate gene |

Reanalysis is strongest when the original data are stored in standard formats such as FASTQ, BAM or CRAM, VCF, and structured reports.

## Network and pathway analysis

Single-gene interpretation works well when a known disease gene explains the case.

Cohort studies often need a broader view. Different patients can carry damaging variants in different genes that affect the same pathway.

Useful resources include STRING, Reactome, KEGG, Gene Ontology, BioGRID, IntAct, OmniPath, Cytoscape, and the Markov Cluster Algorithm.

Pathway analysis can help identify shared biology, but it needs discipline. Protein interaction databases contain many weak or context-dependent links. A network result should be treated as hypothesis-generating unless it is supported by variant evidence, phenotype fit, statistical enrichment, and functional validation.

Modern rare variant association methods include burden tests, SKAT, SKAT-O, STAAR, SAIGE-GENE, REGENIE, DeepRVAT, and other gene or variant-set methods. These methods are useful when cohorts are large enough for statistical testing.

Small rare disease cohorts often remain interpretation-led. In those settings, pathway analysis can organise evidence, but it does not replace variant interpretation.

## Data security and governance

Genomic data is identifying.

A genome is not like a routine blood test result. It contains information about the individual, biological relatives, ancestry, disease risk, and future interpretability.

Good genomic infrastructure should record:

| Item | Reason |
| --- | --- |
| Consent | Defines permitted use |
| Sample metadata | Supports interpretation and audit |
| File provenance | Shows where each file came from |
| Reference genome | Defines coordinates |
| Software versions | Supports reproducibility |
| Access history | Shows who accessed or received data |
| Report versions | Preserves interpretation at a point in time |
| Reanalysis history | Shows how conclusions changed |

Relevant standards and organisations include GA4GH, HL7 FHIR Genomics, ISO 15189, ACMG, AMP, ClinGen, SPHN, and national data protection frameworks.

The practical principle is simple. Genome data should be private by default, shareable by explicit request, and interpretable with a complete audit trail.

## What a good genomic report should say

A useful genomic report should not only list variants.

It should state:

| Report element | Purpose |
| --- | --- |
| Test type | Panel, exome, genome, long-read, tumour, germline |
| Reference genome | GRCh37, GRCh38, T2T-CHM13, or other |
| Regions assessed | Genes, transcripts, intervals, coverage limits |
| Methods | Sequencing, alignment, calling, annotation, filtering |
| Main findings | Variants and interpretation |
| Inheritance evidence | De novo, recessive, compound heterozygous, segregation |
| Population evidence | gnomAD or other frequency evidence |
| Clinical evidence | ClinVar, OMIM, ClinGen, literature |
| Phenotype match | Relevant HPO terms or clinical features |
| Limitations | Regions not covered, variant classes not assessed |
| Data retained | FASTQ, BAM or CRAM, VCF, report, metadata |
| Reanalysis recommendation | When and why to review again |

The most important distinction is between absence of evidence and evidence of absence. A report should make clear whether a variant was not found, or whether the relevant region was not measured well enough to know.

## Common mistakes

A few mistakes cause many interpretation problems.

Using the wrong reference build gives incorrect coordinates.

Using old gene symbols creates failed database joins.

Ignoring transcript choice changes variant consequence.

Filtering too strictly can remove real pathogenic variants.

Filtering too loosely creates false candidate lists.

Treating ClinVar as truth ignores submitter disagreement and review status.

Treating a VUS as causal overstates the evidence.

Ignoring coverage makes negative reports unreliable.

Ignoring ancestry makes frequency interpretation weaker.

Reporting a variant without the phenotype context can mislead the reader.

## Key terms

| Term | Meaning |
| --- | --- |
| Allele | One version of a genetic sequence at a locus |
| Genotype | The allele combination in an individual |
| Heterozygous | One reference and one alternate allele |
| Homozygous | Two copies of the same allele |
| Hemizygous | One copy of a chromosome region, often X-linked in males |
| Compound heterozygous | Two different variants affecting the two copies of one gene |
| Penetrance | Probability that a genotype produces a phenotype |
| Expressivity | Range or severity of features caused by a genotype |
| Mosaicism | A variant present in only some cells |
| Phasing | Determining which variants are on the same parental chromosome |
| Coverage | Number of reads covering a genomic position |
| Allele balance | Fraction of reads supporting each allele |
| VUS | Variant of uncertain significance |
| SNV | Single nucleotide variant |
| Indel | Insertion or deletion |
| CNV | Copy number variant |
| SV | Structural variant |

## Tools and resources to know

| Category | Examples |
| --- | --- |
| Read QC | FastQC, MultiQC, fastp |
| Alignment | BWA-MEM2, DRAGMAP, minimap2 |
| BAM and CRAM handling | samtools, Picard, Sambamba |
| Variant calling | GATK HaplotypeCaller, DeepVariant, DRAGEN, Sentieon DNAscope |
| Joint genotyping | GATK GenomicsDBImport, GenotypeGVCFs, GLnexus |
| Somatic calling | Mutect2, Strelka2, VarDict, Octopus |
| Structural variants | Manta, Delly, GRIDSS, Sniffles, cuteSV |
| Copy number | ExomeDepth, CNVkit, XHMM, GATK gCNV |
| Annotation | Ensembl VEP, ANNOVAR, SnpEff, Nirvana |
| Population frequency | gnomAD, TOPMed, 1000 Genomes, UK Biobank |
| Clinical interpretation | ClinVar, ClinGen, OMIM, Orphanet |
| Phenotype | HPO, PhenoTips, Exomiser, LIRICAL |
| Disease panels | PanelApp, ACMG SF, ClinGen, OMIM |
| Protein context | UniProt, Pfam, InterPro, AlphaFold DB |
| Pathways | Reactome, KEGG, GO, STRING, BioGRID |
| Workflow systems | Nextflow, Snakemake, WDL, Cromwell |
| Cohort genetics | PLINK, bcftools, REGENIE, SAIGE, SKAT, STAAR |

## A useful mental model

Genomic analysis has three layers.

The first layer is measurement. Did the sequencing and alignment measure the region well enough?

The second layer is evidence. What does the variant, gene, population frequency, inheritance, and phenotype suggest?

The third layer is consequence. Can the result support diagnosis, treatment, research, reanalysis, or data reuse?

Most errors happen when these layers are mixed together.

A variant can be real but irrelevant.

A variant can be rare but benign.

A gene can be plausible but not validated.

A negative result can be uninformative if coverage was poor.

A report can be technically correct but clinically unusable if it does not state uncertainty.

Precision medicine depends on keeping these distinctions clear.

## Closing note

DNA sequencing is now routine. Genomic interpretation is not.

The value comes from the chain: sample, sequence, reference, alignment, variant call, annotation, phenotype, inheritance, mechanism, population frequency, report, and reanalysis.

When that chain is visible, genomic data becomes usable evidence.
