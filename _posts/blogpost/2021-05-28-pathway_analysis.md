<!-- --- -->
<!-- layout: post -->
<!-- title: Historical review of rare immune pathway analysis -->
<!-- created: 28 May 2021 -->
<!-- tags: genomics -->
<!-- status: finished -->
<!-- --- -->

<!-- {{ page.title }} -->
<!-- ================ -->

<!-- <p class="meta">28 May 2021</p> -->
<!-- # Itan & Casanova contributions -->

<!-- We are tackling this problem of protein pathway analysis from the viewpoint of --> 
<!-- rare immune disease and infection. -->
<!-- Historically, several topics in bioinformatic and functional analysis have --> 
<!-- been required before we could achieve our current position of --> 
<!-- statistically-robust genetic discovery for rare disease: -->

<!-- 1. Candidate variant select for individual genomes -->
<!-- 2. Compiling reliable cohorts of patients with shared phenotypes -->
<!-- 3. Protein-protein interactions -->
<!-- 4. Variant collapse -->
<!-- 5. Protein pathway analysis -->
<!-- 6. Functional validation -->

<!-- Therefore, a historical review of the timeline is beneficial to illustrate the --> 
<!-- technical successes that allow us to reliably produce candidate variants by -->
<!-- genome sequencing and to validate statistically-driven results by _"traditional"_ -->
<!-- functional validation. --> 
<!-- These steps [1, 2 and 6 in our list] are exemplified by the following --> 
<!-- historical review. --> 
<!-- The complete list of steps 1-6 are touched on, --> 
<!-- but full validation of each step is the culmination of what we are currently --> 
<!-- working on and will be explicitly reviewed when we have completed our study. -->

<!-- As one of the leaders in this field, Casanova lab has provided a lot of insider -->
<!-- history to the story in a great twitter thread -->
<!-- <https://twitter.com/casanova_lab/status/1397539593608695808>. -->
<!-- The literature for discussion is first listed here to facilitate downloading --> 
<!-- but sources are referenced as usual throughout. --> 

<!-- --- -->

<!-- 2013 PNAS. The human gene connectome as a map of short cuts for morbid allele discovery. -->
<!-- {% cite itan2013human %} -->
<!-- <https://pubmed.ncbi.nlm.nih.gov/23509278/> -->

<!-- 2014 BMC Gen. HGCS: an online tool for prioritizing disease-causing gene variants by biological distance. -->
<!-- {% cite itan2014hgcs %} -->
<!-- <https://pubmed.ncbi.nlm.nih.gov/24694260/> -->

<!-- 2015 Front. Novel primary immunodeficiency candidate genes predicted by the human gene connectome. -->
<!-- {% cite itan2015novel %} -->
<!-- <https://pubmed.ncbi.nlm.nih.gov/25883595/>, --> 

<!-- 2015 PNAS. The human gene damage index as a gene-level approach to prioritizing exome variants. -->
<!-- {% cite itan2015human %} -->
<!-- <https://pubmed.ncbi.nlm.nih.gov/26483451/> -->

<!-- 2016 NatMet. The mutation significance cutoff: gene-level thresholds for variant predictions. -->
<!-- {% cite itan2016mutation %} -->
<!-- <https://pubmed.ncbi.nlm.nih.gov/26820543/> -->

<!-- 2015 PNAS. Can the impact of human genetic variations be predicted? -->
<!-- {% cite itan2015can %} -->
<!-- <https://pubmed.ncbi.nlm.nih.gov/26351682/> -->

<!-- 2018 Bioinf. PopViz: a webserver for visualizing minor allele frequencies and damage prediction scores of human genetic variations. -->
<!-- {% cite zhang2018popviz %} -->
<!-- <https://pubmed.ncbi.nlm.nih.gov/30535305/> -->

<!-- 2019 PNAS. Blacklisting variants common in private cohorts but not in public databases optimizes human exome analysis. -->
<!-- {% cite maffucci2019blacklisting %} -->
<!-- <https://pubmed.ncbi.nlm.nih.gov/30591557/> -->

<!-- 2019 NAR. SeqTailor: a user-friendly webserver for the extraction of DNA or protein sequences from next-generation sequencing data. -->
<!-- {% cite zhang2019seqtailor %} -->
<!-- <https://pubmed.ncbi.nlm.nih.gov/31045209/>. -->

<!-- 2020 Hum Gen. The human genetic determinism of life-threatening infectious diseases: genetic heterogeneity and physiological homogeneity? -->
<!-- {% cite casanova2020human %} -->
<!-- <https://pubmed.ncbi.nlm.nih.gov/32462426/> -->

<!-- 2021 JCI. Herpes simplex encephalitis in a patient with a distinctive form of inherited IFNAR1 deficiency. -->
<!-- {% cite bastard2021herpes %} -->
<!-- <https://pubmed.ncbi.nlm.nih.gov/32960813/> -->

<!-- 2021 JCI. TLR3 controls constitutive IFN-β antiviral immunity in human fibroblasts and cortical neurons. -->
<!-- {% cite gao2021tlr3 %} -->
<!-- <https://pubmed.ncbi.nlm.nih.gov/33393505/> -->

<!-- 2021 AJHG. A computational approach for detecting physiological homogeneity in the midst of genetic heterogeneity -->
<!-- {% cite zhang2021computational %} -->
<!-- <https://pubmed.ncbi.nlm.nih.gov/34015270/> -->

<!-- --- -->

<!-- To date, the main paper that implements protein pathway analysis for rare --> 
<!-- immune disease is that by -->
<!-- Peng Zhang and --> 
<!-- Yuval Itan {% cite zhang2021computational %}. -->

<!-- The history begins with determining methods for candidate variant selection - --> 
<!-- the main challenge in human genomics, --> 
<!-- especially for individual patients who can benefit from precision medicine. --> 
<!-- Over the last decade, we have reached a point where we can now reasonably --> 
<!-- discern individual candidate-causal variants from the background noise of --> 
<!-- genomic variability. -->

<!-- From the authors' perspective, the project began around 2011 and its first --> 
<!-- step was concluded in 2013 with --> 
<!-- Yuval Itan's -->
<!-- first "Human Gene Connectome" paper --> 
<!-- while he was a post-doc with Casanova lab. --> 
<!-- {% cite itan2013human %}. -->
<!-- This software connected genes like streets in a map, --> 
<!-- based on their physiological relatedness. -->
<!-- It was soon followed by methodological development --> 
<!-- {% cite itan2014hgcs %} -->
<!-- and application to inborn errors of immunity --> 
<!-- {% cite itan2015novel %} -->
<!-- or both --> 
<!-- {% cite itan2015human %}, -->
<!-- and a couple of necessary detours --> 
<!-- {% cite itan2016mutation %} -->
<!-- and --> 
<!-- {% cite maffucci2019blacklisting %}. -->
<!-- A review was also written by two of the main authors during the same period -->
<!-- {% cite itan2015can %}. -->

<!-- When Peng Zhang joined the Casanova lab as post-doc, --> 
<!-- Yuval Itan had started his own lab. --> 
<!-- However, the pair worked together to continue producing the papers on variant -->
<!-- interpretation and data processing -->
<!-- {% cite zhang2018popviz %} -->
<!-- and -->
<!-- {% cite zhang2019seqtailor %}. -->

<!-- After completing this period of work, --> 
<!-- they renamed "Human Gene Connectome II" the --> 
<!-- "Network-based Heterogeneity Clustering". -->
<!-- At this point, their aims were defined as being generally indistinguishable --> 
<!-- from ours. --> 
<!-- That is, _"the detection of physiological homogeneity in a cohort of patients --> 
<!-- sharing a clinical phenotype but with high genetic heterogeneity - --> 
<!-- a hallmark of severe infectious diseases"_ (Casanova via twitter), --> 
<!-- as presented in their next paper on this topic -->
<!-- {% cite casanova2020human %}. -->

<!-- Shen-Ying Zhang came on board as senior author on the next two papers. -->
<!-- With an excellent database of immune disorders and infections, --> 
<!-- the team could gradually build their software. -->
<!-- Exomes from patients with HSV-1 encephalitis were used for testing successive --> 
<!-- versions in -->
<!-- {% cite bastard2021herpes %} --> 
<!-- and --> 
<!-- {% cite gao2021tlr3 %}. -->

<!-- Quoting Casanova _"When they were capable of detecting the known TLR3-IFN needles in the HSE stack, they installed camp 1, rested a bit and reported to me on the radio, while I was watching them from the basecamp with binoculars. I encouraged them to push for the final ascent and they did."_ -->

<!-- With the same goal as our own - --> 
<!-- producing unbiased methods for detection of biologically-connected causal --> 
<!-- genetic variation - --> 
<!-- they found new gene variants that interact via the TLR3-IFN protein pathway, -->
<!-- in individual patients. --> 
<!-- Shen-Ying Zhang found them to be biochemically deleterious, --> 
<!-- an important factor for validation of genetic-first aproaches. --> 
<!-- In this case, Zhang _et al_ get as close to the _"gold-standard"_ --> 
<!-- as anyone to date. -->

<!-- The functional validation of candidate variants in disease then provided a proof-of-principle indication that they could detect physiological homogeneity in the midst of genetic heterogeneity --> 
<!-- {% cite zhang2021computational %}. -->

<!-- Quoting Casanova --> 
<!-- _"A computational approach for detecting physiological homogeneity in the midst of genetic heterogeity. -->
<!-- That was terrific!"_. -->

<!-- --- -->

<!-- > An aside on what I call the _"gold-standard"_ for our field should be: -->
<!-- > 1. Unbiased statistical detection of a genetic phenomenon. -->
<!-- > 2. Validation by functional models under systematic control. -->
<!-- > --> 
<!-- > Part [1] Depends on patient cohorts that are large enough to detect the effect based on the phenotype strength - difficult for _rare disease_.\ -->
<!-- > Part [2] Depends on independently testing biological mechanisms. --> 
<!-- > -->
<!-- > This second step generally consists of two hurdles: -->
<!-- > * If the same researchers perform (1) genetic stats and (2) functional work, --> 
<!-- > there is a bias that is difficult to avoid when trying to functionally --> 
<!-- > validate statistically positive results. -->
<!-- > * If the statistical genetic associations happen to contain a false positive --> 
<!-- > for something like severe rare immune disease, --> 
<!-- > the sensitive functional models may detect a damaging response. --> 
<!-- > One might find a truly damaging biological mechanism, --> 
<!-- > but if the statistical genetic association is not correct then this --> 
<!-- > biological mechanism should not be deemed causal; --> 
<!-- > back-tracking at this stage would be very difficult due to self-imposed bias. --> 
<!-- > --> 
<!-- > Ideally, in the future we hope to see a separation of the two steps --> 
<!-- > (stat genetics and wet-lab) such that each are performed independently. --> 
<!-- > The wet-lab would also ideally focus their routines on a particular protein --> 
<!-- > pathway/system with SOPs that improve accuracy and precision --> 
<!-- > (e.g. clinical diagnostics labs, clinical trials) rather than setting up --> 
<!-- > models for each new study. -->

<!-- --- -->

<!-- Returning to our historical review, --> 
<!-- we have been producing our protocols similarly in parallel. -->
<!-- With patient cohorts of comparable sizes and phenotypes we will soon --> 
<!-- have a complementary validation of protocols. -->
<!-- However, great care is also being taken to test and select the most reliable --> 
<!-- statistical methods for association testing - --> 
<!-- an improvement to the fine work by -->
<!-- {% cite zhang2021computational %}. -->

<!-- Best practices in candidate variant selection protocols are basically --> 
<!-- standardised as of 2021, --> 
<!-- so the main remaining task is standardisation of the protein-pathway --> 
<!-- annotation and association testing methods - --> 
<!-- steps which we will soon be ready to publish after peer-review. -->

<!-- # References --> 

<!-- {% bibliography --cited %} -->
