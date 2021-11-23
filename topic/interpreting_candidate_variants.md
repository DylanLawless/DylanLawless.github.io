# Interpreting candidate variants
Rewrite:
https://lawlessgenomics.com/topic/genetic-mutation-websites

## Incidental findings
When clinical genetics is performed for diagnosis of a disease, 
some genes variants should be reported whether or not they are the cause of the disease under investigation.  
However, the ethics/consent may have a specific rules about reporting incidental findings. 

Ignoring this requirement, we might ask why are these variants worth reporting? 
It is because they are known to cause some phenotype, or perhaps could be treatable. 

If we understand what makes a gene/variant one of these recommended for reporting, then we will also recognise new or unknown candidate variants for our disease of interest. 

A certain level of evidence must exist that can be agreed upon by whichever committee is making the recommendations. 
For out individual person with a VUS (variants of unknown significance), we must gather and outline this evidence along with a thesis of variant effect - how this variant could cause a protein to disfunction. 

There may be two options for validation: 

1. Perform functional experiments that support this hypothesis. 
	- Example: you find a patient with a homozygous  mutation in gene X. The mutation occurs in a protein doamin that is known to bind to another protein, Y. The wetlab will express this gene in cell culture and a knock-out cell culture, and measure some markers like inflammation, etc. They might also test whether the protein domain X and Y bind with and without this variant. Your mechanism hypothesis will allow the experiment design. 

2. Independent genetics analysis also identifies the same gene/function. If they statistics are satisfactory between different studies, then the physical wetlab experiments may not be required. 
	Example: you find a recessive gene variant in patient N. Their extended family has genetics tested to confirm that only homozygous individuals are sick. A second study on the same disease finds another variant in the same gene that also has the same association. The probability of finding both by chance as false positives is incredibly low, and we are confidence that this is the disease mechanism.


## Some examples of recommended genes with known disease link


Standards and Guidelines for the Interpretation of Sequence Variants: A Joint Consensus Recommendation of the American College of Medical Genetics and Genomics and the Association for Molecular Pathology 

https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4544753/


ACMG Recommendations for Reporting of Incidental Findings in Clinical Exome and Genome Sequencing

https://www.ncbi.nlm.nih.gov/clinvar/docs/acmg/


https://www.acmg.net/ACMG/Medical-Genetics-Practice-Resources/Practice-Guidelines.aspx

https://panelapp.genomicsengland.co.uk/panels/

https://blueprintgenetics.com/tests/panels/


## Interpreting

The easiest examples are LoF.
If knocking out a protein causes disease, then a LoF in this gene will be detrimental. 

You only have to determine whether homozygous or heterozygous LoF will cause disease (recessive versus dominant). 

For other types of variants (missense, splice-site variants, in-frame deletions, etc.) it is more difficult to interpret. 

Output the gene name, variant (protein position or amino acid change), 
go to several databases to see where the a variant occurs on the protein, 
summarise the protein function, 
list any known protein domains and how they function - are they interacting only within the protein or with other proteins?
Is there a protein structure that can be used to model the variant? 
and lastly propose a mechanism of how it could cause disease.


Output all info on your candidates for patients.



Links
* Online Mendelian Inheritance in Man [OMIM](https://omim.org/)
* [ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/)

## OMIM
* Online Mendelian Inheritance in Man [OMIM](https://omim.org/)
For a gene, results include pages for diseases (#) and for genes (*)
Check the inheritance pattern for known disease:
* AD - autosomal dominant (heterozygous variants may be causal)
* AR - autosomal recessive (homozygous variants may be causal)

For the gene page, check the Allelic variant table view so list known disease-related variants.
If your variant is listed here, all of the linked data/literature will provide enough info for a initial report.

## ClinVar
* [ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/)
Like OMIM,i f your variant is listed here, all of the linked data/literature will provide enough info for a initial report.

## UniProt
* [UniProt](https://www.uniprot.org)
Quick read of function, known relationship to our phenotype?
Next look at protein domains and variant position:
* Family & Domains
	E.g. if our variant is in a known domain, what evidence supports the domain function?
	Can this same evidence support our candidate by assuming that the domain is damaged. 

## Protein structures
* [PDB](https://www.rcsb.org)
	Usually multiple resuls for each protein, subunits or partial structures. 
* [Alphafold](https://alphafold.com)
* Mutation prediction - RoseTTA --- 

## Conservation in speicies
Orthologous gene 
Compare across different species by multiple sequence alignment.
Use the amino acid level.
If the postion is conserved or variable, it may indicate how important it is to the proteins' structure or function. 
Highly conserved positions indicate puritfying selection.

## Population genetics
GnomAD, is our variant rare or novel (not in GnomAD)?
Is the protein intollerant to LoF (pLI).

* LOEUF versus pLI
LOEUF stands for the "loss-of-function observed/expected upper bound fraction." It is a conservative estimate of the observed/expected ratio, based on the upper bound of a Poisson-derived confidence interval around the ratio. Low LOEUF scores indicate strong selection against predicted loss-of-function (pLoF) variation in a given gene, while high LOEUF scores suggest a relatively higher tolerance to inactivation. Its advantage over pLI is that it can be used as a continuous value rather than a dichotomous scale (e.g. pLI > 0.9) - if such a single cutoff is still desired, pLI is a perfectly fine metric to use. At large sample sizes, the observed/expected ratio will be a more appropriate measure for selection, but at the moment, LOEUF provides a good compromise of point estimate and significance measure.

* recommend LOEUF $< 0.35$

gnomad constraint metrics
http://genome.ucsc.edu/cgi-bin/hgTrackUi?db=hg19&g=gnomadPLI

> "When evaluating how constrained a gene is, it is essential to consider the CI when using O/E. In research and clinical interpretation of Mendelian cases, pLI > 0.9 has been widely used for filtering. Accordingly, the Gnomad team suggests using the upper bound of the O/E confidence interval LOEUF < 0.35 as a threshold if needed."

Examples
* X	pLI 0 can survive LoF	= o/e = 0.99
* RAG1	pLI 0 can survive LoF	= o/e = 0.45
* TNFAIP3	pLI 1 is damaging 	= o/e = 0.06

Example, output a list of genes below our LOEUF threshold, then filter on those genes.

## VEP 

## dbNSFP
https://genomemedicine.biomedcentral.com/articles/10.1186/s13073-020-00803-9

## Example of whitelist
Sometimes called, virtual panel 
meaning we pretend that we sequenced only these genes, using gene panel.
Often used for very small cohort where we cannot do much correction for multiple testing.
Problem of false positives. 


## IUIS gene list

For immune disease, all immune related genes with strong evidence are included.
Currently ~450 genes.
https://ipopi.org/iuis-pid-classification-list-features-416-human-errors-of-inborn-immunity/

## GE panel app
https://panelapp.genomicsengland.co.uk/panels/

GE panel app PID list
https://panelapp.genomicsengland.co.uk/panels/398/
Contains more than the IUIS list, with good overlap, and evidence is quite reliable. 



## Single cases versos cohort studies
These guys, and many others have major works on so many genes that discovered to be part of the immune system - all based on single cases (or a small number of cases).
https://pubmed.ncbi.nlm.nih.gov/?term=fischer%20alain
https://pubmed.ncbi.nlm.nih.gov/?term=jean-laurent+casanova
https://pubmed.ncbi.nlm.nih.gov/?term=Notarangelo+LD&cauthor_id=20042228

You can discover biological mechanisms with at least 2 approaches:

1. Gradual discovery by working on the same system, long term. Modifying the conditions, with vitro/vivo genetic mutation to measure the change in assays. Or using some targeted protein inhibitor to induce LoF to get the same outcome. etc. Example, Andrea's lab, or any molecular biology lab would do this.
https://pubmed.ncbi.nlm.nih.gov/?term=ablasser+andrea

2. Find people/animal who naturally have a disfunction in this system and then define the genetic cause.
 - 2A. get a cohort of people with a common genetic cause, but the phenotype will be mild and difficult to see a strong effect (disease) (examples height, or coronary disease).
 - 2B. get individuals with a rare or novel genetic cause, their phenotype will be strong and easier to explain a direct gene to phenotype effect (examples X-SCID, or XLA)

https://en.wikipedia.org/wiki/X-linked_severe_combined_immunodeficiency
https://en.wikipedia.org/wiki/X-linked_agammaglobulinemia


Option 2B is how I would think about individuals. This is also how most people who require a genetic diagnosis in hospital are assessed (although usually only a small list of candidate genes may be tested based on their suspected disease).
A nice paper that started my interest in single-case immune discovery:
https://pubmed.ncbi.nlm.nih.gov/25311508/
