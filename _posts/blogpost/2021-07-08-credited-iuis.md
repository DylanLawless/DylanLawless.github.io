---
layout: post
title: Credited for a newly added immune gene in IUIS
created: 08 Feb 2021
tags: statistics
status: finished
---

{{ page.title }}
================

<p class="meta">08 Feb 2021</p>

Our recent paper 
_Germline TET2 loss of function causes childhood immunodeficiency and lymphoma_
{% cite stremenova2020germline %} has been 
credited for a newly added immune gene in _Novel inborn errors of immunity: an Interim Update by the IUIS Committee_
[full link](https://doi.org/10.1007/s10875-021-00980-1),
[pdf](https://link.springer.com/content/pdf/10.1007/s10875-021-00980-1.pdf),
as [TET2 in table 1](https://link.springer.com/article/10.1007/s10875-021-00980-1/tables/1)
{% cite tangye2021ever %}.
It has been included for the gene list of _Autoinflammatory diseases_ based on our work in 3 patients, 2 families with autosomal recessive loss-of-function.
Since I began research on the genomics of immunology, the IUIS list of genes has been an extremely important reference for my work to which I am now thrilled to _give back_.

International Union of Immunological Societies (IUIS) [IUIS.org](https://iuis.org);
>The International Union of Immunological Societies (IUIS) is an umbrella organization for many of the regional and national societies of immunology throughout the world. As articulated in its Constitution, the objectives of IUIS are:
> * to organize international co-operation in immunology and to promote communication between the various branches of immunology and allied subjects
> * to encourage within each scientifically independent territory co-operation between the Societies that represent the interests of immunology
> * to contribute to the advancement of immunology in all its aspects.

From _Novel inborn errors of immunity: an Interim Update by the IUIS Committee_,
> Inborn errors of immunity (IEI) are generally considered to result from monogenic germline defects that manifest as increased susceptibility to severe and/or recurrent infectious diseases, autoimmune or autoinflammatory conditions, atopic manifestations, and hematopoietic or solid tissue malignancies [[1](https://doi.org/10.1126/sciimmunol.abb1662)]. 
> Over the past decade, the discovery of new IEIs has been occurring at an impressive rate. 
> Indeed, the 2011 biennial update published by the IUIS Committee update listed 191 IEIs; this number increased to 430 in the 2019 update
> [[2](https://doi.org/10.1007/s10875-020-00758-x)],
> [[3](https://doi.org/10.1007/s10875-019-00737-x)].
> This near-exponential increase in gene discovery is being driven by the accessibility and affordability of next-generation sequencing, and the efficient application of these technologies to elucidate the molecular etiology of unsolved cases of IEIs that are likely to result from single-gene defects
> [4](https://doi.org/10.1016/j.jaci.2016.08.003).
>
> Over the last 12 months, we have witnessed the ongoing rapid identification, and occasionally detailed molecular, biochemical, and cellular characterization, of genetic variants that cause, or are at least associated with, human diseases impacting host defense or immune regulation.
> Here, we will summarize reports on variants detected in 26 genes which we consider represent novel IEI 
> ([Table 1](https://link.springer.com/article/10.1007/s10875-021-00980-1/tables/1)).
> Many additional genetic variants have been reported recently. 
> However, those listed here have been adjudicated by the IUIS Committee to meet the strict criteria to be considered disease-causing
> [57](https://doi.org/10.1084/jem.20140520).

Our paper took several years to complete, 
although the genomic analysis worked incredibly well in this case - 
a patient presented as described in **figure 1** (Fig. S3 in publication);
after running the routine pipeline that we had made, the result was immediately the top candidate, number one, as cause of disease in a single patient, lymphoma with immunodeficiency and autoinflammtory disease
{% cite stremenova2020germline %}.
We then found that our collaborator had a second family with a LoF in the same gene causing the same severe immunological features.
By combining the families for further genomic and functional analysis work over several years we finally produced a robust explanation for the disease and strong evidence of the immunological features.
The summarised information can be read in 
[Table 1 Newly validated inborn errors of immunity](https://link.springer.com/article/10.1007/s10875-021-00980-1/tables/1).

**Figure 1.** Patient histories as shown in the published 
_Supplemental Figure S3: Clinical timelines_
(this version with legend is an extract my PhD thesis).
<a href="{{ site.baseurl }}{% link images/posts/clinical_history_summary.pdf %}">(pdf version)</a>.

<object data="{{ site.baseurl }}{% link images/posts/clinical_history_summary.pdf %}" type="application/pdf" width="100%"  style="height:700px;">

The gene of interest, _TET2_ is intriguing since it is the monogenic cause of disease but has a widespread mechanism of action throughout the genome by epigenetic effects.
From one of my unpublished documents, in reference to different types of epigenetic systems;
> The effect of mutations which disrupt any of these systems have been described as damaging toward (i) epigenetic modifiers, (ii) epigenetic mediators, and (iii) epigenetic modulators [[15](https://pubmed.ncbi.nlm.nih.gov/26972587/)]. Epigenetic modifiers are genes whose products have direct involvement; protein coding genes that control DNA methylation, post-translational modification, or higher-order chromatin structure (e.g. TET2, IDH, ARID). Mutation in these genes can have a cascade effect since they control the regulation of many downstream genes. The downstream genes which are targeted by the modifiers are epigenetic mediators.
> Damaging mutations in mediators might only be linked with epigenetics when they occur in, for example, tumour suppressor genes resulting in the same disease as mutation in one of the upstream epigenetic modifiers. Epigenetic modulators are upstream of modifiers and have the potential to induce or suppress differentiation-specific epigenetic states. Pro-inflammatory NF-κB signalling has been reported as an example of a modulator that links the environment and epigenome [[15](https://pubmed.ncbi.nlm.nih.gov/26972587/)]. Excessive signalling in this pathway can trigger an epigenetically-dependant interleukin-6 positive feed-back loop.

<div class="table-wrapper" markdown="block">

| Epigenetic modulators | Epigenetic modifiers | Epigenetic mediators |
|:---------------------:|:--------------------:|:--------------------:|
| Secondary effect on multiple pathways (NF-kB, IL-6) | Primary effect on multiple genes (TET2, IDH1) | Primary effect on single genes (IGF-2, OCT4, WNT) |

</div>

When a protein has widespread control for many other genes, a LoF variant is often embryonic lethal and would never result in a relatively narrow phenotype. 
For TET2 LoF, we found that completely disrupting the genome-wide methylation process causes a pronounced immunological phenotype.
Unfortunately, the disease can be very difficult to correct without successful haematopoietic stem cell transplantation.
In such cases, a great deal of biological understanding is gained that may otherwise have taken very long to elucidate. 

Loss of TET2 in humans has severe consequences including haematological malignancy.
Yet, it has also been shown that TET2 knock-out can improve anti-tumour therapy for the same reasons;
Fraietta et al. showed that while developing therapeutic CD19-targeted T cells (CAR-T anti-tumour therapy), the integration of the CD19-CAR sequence happened to interrupt the TET2 coding sequence by chance
{% cite fraietta2018disruption %}.
This fortuitous integration event had a combined effect; disrupting TET2 promoted the therapeutic efficacy of CD19-targeted T cells in the patient. 
Inhibiting TET2 normally would not be considered ameliorative in cancer immunology. 
However, in this case the pathogenic effect of TET2 deficiency allowed for more successful CAR-T cell therapy. 
It is likely that this type of combined genetic alteration will improve CART function. This anecdotal example demonstrates the lymphoproliferative effect of TET2 deficiency.

## References 

{% bibliography --cited %}
