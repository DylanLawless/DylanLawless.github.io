---
layout: topic
title: Variant annotation
created: 23 Sept 2021
tags: genomics
subject: Precision medicine
---
{{ page.title }}
================
<p class="meta">23 Sept 2021</p>

Unfinished article

## Annotation
[Variant Effect Predictor (VEP)](http://grch37.ensembl.org/Homo_sapiens/Tools/VEP/) is very useful.
A real-world example of VEP in use can be read in [this pharmacogenomics article](https://lawlessgenomics.com/topic/pharmacogenomics).
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

The terms in the table below are shown in order of severity (more severe to less severe) as estimated by Ensembl.
In single case studies, we often find rare disease due to variants of "IMPACT" that is "HIGH or MODERATE".
However, there may be a bias in that these variants are often most likely to be functionally interpretable.
Variants that are more difficult to predict function might only be detected in large-scale association studies where a  is statistically valid explanation for correlation/cause is possible.
Other tools may provide alternative estimates that the ones shown here from VEP. 
Missense variants may have further annotation on their effect on the protein function, using a number of algorithms
(see [VEP Ensembl Variation - Calculated variant consequences](https://m.ensembl.org/info/genome/variation/prediction/predicted_data.html)).

<div class="table-wrapper" markdown="block">

|	SO term	|	SO description	|	SO accession	|	Display term	|	IMPACT	|
|	---	|	---	|	---	|	---	|	---	|
|	transcript_ablation	|	A feature ablation whereby the deleted region includes a transcript feature.	|	SO:0001893	|	Transcript ablation	|	HIGH	|
|	splice_acceptor_variant	|	A splice variant that changes the 2 base region at the 3' end of an intron.	|	SO:0001574	|	Splice acceptor variant	|	HIGH	|
|	splice_donor_variant	|	A splice variant that changes the 2 base region at the 5' end of an intron.	|	SO:0001575	|	Splice donor variant	|	HIGH	|
|	stop_gained	|	A sequence variant whereby at least one base of a codon is changed, resulting in a premature stop codon, leading to a shortened transcript.	|	SO:0001587	|	Stop gained	|	HIGH	|
|	frameshift_variant	|	A sequence variant which causes a disruption of the translational reading frame, because the number of nucleotides inserted or deleted is not a multiple of three.	|	SO:0001589	|	Frameshift variant	|	HIGH	|
|	stop_lost	|	A sequence variant where at least one base of the terminator codon (stop) is changed, resulting in an elongated transcript.	|	SO:0001578	|	Stop lost	|	HIGH	|
|	start_lost	|	A codon variant that changes at least one base of the canonical start codon.	|	SO:0002012	|	Start lost	|	HIGH	|
|	transcript_amplification	|	A feature amplification of a region containing a transcript.	|	SO:0001889	|	Transcript amplification	|	HIGH	|
|	inframe_insertion	|	An inframe non synonymous variant that inserts bases into in the coding sequence.	|	SO:0001821	|	Inframe insertion	|	MODERATE	|
|	inframe_deletion	|	An inframe non synonymous variant that deletes bases from the coding sequence.	|	SO:0001822	|	Inframe deletion	|	MODERATE	|
|	missense_variant	|	A sequence variant, that changes one or more bases, resulting in a different amino acid sequence but where the length is preserved.	|	SO:0001583	|	Missense variant	|	MODERATE	|
|	protein_altering_variant	|	A sequence_variant which is predicted to change the protein encoded in the coding sequence.	|	SO:0001818	|	Protein altering variant	|	MODERATE	|
|	splice_region_variant	|	A sequence variant in which a change has occurred within the region of the splice site, either within 1-3 bases of the exon or 3-8 bases of the intron.	|	SO:0001630	|	Splice region variant	|	LOW	|
|	incomplete_terminal_codon_variant	|	A sequence variant where at least one base of the final codon of an incompletely annotated transcript is changed.	|	SO:0001626	|	Incomplete terminal codon variant	|	LOW	|
|	start_retained_variant	|	A sequence variant where at least one base in the start codon is changed, but the start remains.	|	SO:0002019	|	Start retained variant	|	LOW	|
|	stop_retained_variant	|	A sequence variant where at least one base in the terminator codon is changed, but the terminator remains.	|	SO:0001567	|	Stop retained variant	|	LOW	|
|	synonymous_variant	|	A sequence variant where there is no resulting change to the encoded amino acid.	|	SO:0001819	|	Synonymous variant	|	LOW	|
|	coding_sequence_variant	|	A sequence variant that changes the coding sequence.	|	SO:0001580	|	Coding sequence variant	|	MODIFIER	|
|	mature_miRNA_variant	|	A transcript variant located with the sequence of the mature miRNA.	|	SO:0001620	|	Mature miRNA variant	|	MODIFIER	|
|	5_prime_UTR_variant	|	A UTR variant of the 5' UTR.	|	SO:0001623	|	5 prime UTR variant	|	MODIFIER	|
|	3_prime_UTR_variant	|	A UTR variant of the 3' UTR.	|	SO:0001624	|	3 prime UTR variant	|	MODIFIER	|
|	non_coding_transcript_exon_variant	|	A sequence variant that changes non-coding exon sequence in a non-coding transcript.	|	SO:0001792	|	Non coding transcript exon variant	|	MODIFIER	|
|	intron_variant	|	A transcript variant occurring within an intron.	|	SO:0001627	|	Intron variant	|	MODIFIER	|
|	NMD_transcript_variant	|	A variant in a transcript that is the target of NMD.	|	SO:0001621	|	NMD transcript variant	|	MODIFIER	|
|	non_coding_transcript_variant	|	A transcript variant of a non coding RNA gene.	|	SO:0001619	|	Non coding transcript variant	|	MODIFIER	|
|	upstream_gene_variant	|	A sequence variant located 5' of a gene.	|	SO:0001631	|	Upstream gene variant	|	MODIFIER	|
|	downstream_gene_variant	|	A sequence variant located 3' of a gene.	|	SO:0001632	|	Downstream gene variant	|	MODIFIER	|
|	TFBS_ablation	|	A feature ablation whereby the deleted region includes a transcription factor binding site.	|	SO:0001895	|	TFBS ablation	|	MODIFIER	|
|	TFBS_amplification	|	A feature amplification of a region containing a transcription factor binding site.	|	SO:0001892	|	TFBS amplification	|	MODIFIER	|
|	TF_binding_site_variant	|	A sequence variant located within a transcription factor binding site.	|	SO:0001782	|	TF binding site variant	|	MODIFIER	|
|	regulatory_region_ablation	|	A feature ablation whereby the deleted region includes a regulatory region.	|	SO:0001894	|	Regulatory region ablation	|	MODERATE	|
|	regulatory_region_amplification	|	A feature amplification of a region containing a regulatory region.	|	SO:0001891	|	Regulatory region amplification	|	MODIFIER	|
|	feature_elongation	|	A sequence variant that causes the extension of a genomic feature, with regard to the reference sequence.	|	SO:0001907	|	Feature elongation	|	MODIFIER	|
|	regulatory_region_variant	|	A sequence variant located within a regulatory region.	|	SO:0001566	|	Regulatory region variant	|	MODIFIER	|
|	feature_truncation	|	A sequence variant that causes the reduction of a genomic feature, with regard to the reference sequence.	|	SO:0001906	|	Feature truncation	|	MODIFIER	|
|	intergenic_variant	|	A sequence variant located in the intergenic region, between genes.	|	SO:0001628	|	Intergenic variant	|	MODIFIER	|

</div>


