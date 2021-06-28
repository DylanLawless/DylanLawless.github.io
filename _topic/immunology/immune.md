---
layout: topic
title: Immunogenomics
created: 20 Feb 2021
tags: immunology
status: finished
subject: immunology
---
{{ page.title }}
================
<p class="meta">20 Feb 2021</p>

* TOC
{:toc}

# The study of rare immune disorders.
_Note: in genomic analysis cohort studies a purely statistical approach 
is preferrable to prevent bias in the initial discovery phase.
The following pertains to rare disease or single case studies where 
traditional statistical based assocciations are impossible detect.
A link to new statistical based approaches for rare disease will also be provided shortly._

Our goal is the discovery of rare variants in primary immune deficiency 
diseases and autoinflammatory disease. 
There is a long history of advancements in the field of immunology 
by investigating rare diseases. 
In a very broad sense immunology can be approached in two ways; 
1. Categorically define each protein and signalling mechanism in a pathway or 
2. Identify monogenic or complex genetic causes for immune disorders to identify new or known protein functions.

Both of these approaches require _a priori_ knowledge;
i.e. 
"what functional experiment will demonstrate the mechanism of the system 
or protein of interest, 
and how does a genetic variant explain the phenotype demonstrated by a patient"
The second method is [discussed carefully by Casanova and Notarangelo](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4203950/).

Novel discovery of rare mutations in immune genes has some hurdles.
* The patients included for sequencing must be selected carefully.
The majority of disease-causing mutations identified will be known variants, 
those that are obviously damaging, etc. and have defined treatments. 
These must be identified quickly to focus on more significant discoveries.
* Novel discoveries require functional experimentation to prove mechanism. 
This can require a major investment for complex studies and therefore ends 
up itself taking investigation approach number 1 mentioned above.

There are two options for the approach: 
 * Small single-case studies that require some functional work along with clinical investigation.
	+ This first option can have very dramatic consequences for understanding 
protein function - when the phenotype is extremely strong it is easier to identify.
 * Cohort studies on larger groups of affected patients where the phenotype 
is not as profound as rare single cases disorders.
	+ This second option is more statistically reliable but the effect sizes tend to 
be much smaller. Sample sizes are usually also small for rare diseases.

# Genomic analysis protocol
The best-practice methods for genomic analysis are discussed in other posts 
including ["Genomic analysis for rare disease"]({{ site.baseurl }}{% link _topic/genomic_analysis/1_exome_seq.md %}).
These methods are generally a routine protocol that is performed for every sample, 
and dependant on the technology used; 
i.e. genome sequencing with
illumina short reads, 10x Genomics long reads, RNAseq, Hi-C, etc.

The disease-specific subtleties still often require a highly tailored analysis
protocol to correctly identify a genetic determinant of disease.
A simple explanation is seen with disease genes where knowledge about 
protein function is used for annotation of candidate disease variants

# Immune disorder genes
The genes which are most often identified in immune disorders can be separated 
into those of Primary Immunodeficiency (PID) and Autoinflammatory diseases. 
Of course there is overlap as many proteins have multiple functions 
(inhibitory, activation, autoinhibition, etc.). 
The analysis protcols use several stages of best-practice clinical genetic 
annotations accounting for numerous diagnosis criteria including variant consequence, 
gene ontology, inheritance, protein domain function, transcription editing, 
translation modification, etc. 
A reliable example of a disease gene list can be found on the 
[Genomics England panel app Primary immunodeficiency](https://panelapp.genomicsengland.co.uk/panels/398/).

<img src="{{ site.baseurl }}{% link images/ge_panel_app.png %}" width="100%">

The (simplified) list that I try to keep updated and close to hand when 
doing tailored bioinformatic analysis is exemplified in the following table. 
The analysis pipeline uses a curated and reliable sources to provide
a data-rich annotation process for candidate variant detection. 
However, as a repository of whole genome annotation, the information is 
difficult to illustrate here in a small image. 
Instead, the included table is a _very_ simplified example of candidate genes in immunogenomics. 
_Note that candidate gene approaches are not recommended, this list is an example 
of known functions that are applied to results after unbiased significance testing._ 

---

# Primary Immunodeficiency (PID) genes

| PID genes | Disorder | inheritance |
|-----------|----------|----------------|
| ACP5 | Spondyloenchondrodysplasia with immune dysregulation | AR |
| ACTB | Baraitser-Winter syndrome 1 | |
| ADA | Adenosine deaminase (ADA) deficiency | AR |
| ADAR | Aicardi-Goutieres syndrome 6 | |
| AICDA | Immunodeficiency with hyper-IgM, type 2 | AR |
| AIRE | Autoimmune polyendocrinopathy syndrome , type I, with or without reversible metaphyseal dysplasia (APECED) | AR |
| AK2 | Reticular dysgenesis, AK2 deficiency | AR |
| AP3B1 | Hermansky-Pudlak syndrome 2 | AR |
| APOL1 | Trypanosomiasis, susceptibility to | |
| ARVCF | DiGeorge syndrome | |
| ATM | Ataxia-telangiectasia | AR |
| BCL10 | combined immunodeficiency with B cell, T cell, and fibroblast defects | |
| BLM | Bloom syndrome | AR |
| BLNK | Agammaglobulinemia 4 | AR |
| BTK | Agammaglobulinemia, X-linked 1 (XLA) | x-linked |
| C1QA | C1q deficiency | AR |
| C1QB | C1q deficiency | AR |
| C1QC | C1q deficiency | AR |
| C1R | C1r/C1s deficiency, combined | AR |
| C1S | C1s deficiency | AR |
| C2 | C2 deficiency | AR |
| C3 | C3 deficiency | AD |
| C4A | C4a deficiency | AR |
| C4B | C4B deficiency | AR |
| C5 | C5 deficiency | |
| C6 | C6 deficiency | AR |
| C7 | C7 deficiency | |
| C8A | C8 deficiency, type I | AR |
| C8B | C8 deficiency, type II | AR |
| C8G | Complement factor 8 defect | AR |
| C9 | C9 deficiency | AR |
| CA2 | Osteopetrosis, autosomal recessive 3, with renal tubular acidosis | |
| CARD11 | Immunodeficiency 11/ CARD11 deficiency; Persistent polyclonal B-cell lymphocytosis | AR |
| CARD14 | Pityriasis rubra pilaris | |
| CARD9 | Candidiasis, familial, 2, autosomal recessive | AR |
| CASP10 | Autoimmune lymphoproliferative syndrome, type II | AD |
| CASP8 | Immunodeficiency due to CASP8 deficiency | AD |
| CCBE1 | Hennekam lymphangiectasia-lymphedema syndrome 1 | |
| CD19 | Immunodeficiency, common variable, 3 | AR |
| CD247 | Immunodeficiency 25 | AR |
| CD27 | Lymphoproliferative syndrome 2 | AR |
| CD28 | combined immunodeficiency T cell | |
| CD3D | CD3d deficiency | AR |
| CD3E | CD3e deficiency | AR |
| CD3G | CD3g deficiency | AR |
| CD4 | OKT4 epitope deficiency | |
| CD40 | CD40 deficiency | AR |
| CD40LG | CD40 ligand deficiency | x-linked |
| CD46 | Hemolytic uremic syndrome, atypical, susceptibility to, 2 | |
| CD55 | Hemolysis syndrome | |
| CD59 | Hemolytic anemia, CD59-mediated, with or without immune-mediated polyneuropathy | |
| CD79A | Agammaglobulinemia 3 | AR |
| CD79B | Agammaglobulinemia 6 | AR |
| CD81 | Immunodeficiency, common variable, 6 | AR |
| CD8A | CD8 deficiency | AR |
| CDKN2A | Neutropenia, severe congenital | |
| CEBPE | Specific granule deficiency | AR |
| CECR1 | ADA2 deficiency | AR |
| CFB | Complement factor B deficiency | AR |
| CFD | Complement factor D deficiency | AR |
| CFH | Complement factor H deficiency | AR and AD |
| CFHR1 | Hemolytic uremic syndrome, atypical, susceptibility to | |
| CFHR3 | Hemolytic uremic syndrome, atypical, susceptibility to | |
| CFI | Complement factor I deficiency | AR |
| CFP | Properdin deficiency, X-linked | x-linked |
| CHD7 | Charge syndrome | AD |
| CIITA | Bare lymphocyte syndrome, type II, complementation group A | AR |
| CLCN7 | Osteopetrosis, autosomal recessive | |
| CLEC7A | Candidiasis, familial, 4, autosomal recessive | AR |
| CNBP | Myotonic dystrophy 2 | |
| COLEC11 | 3MC syndrome 2 | |
| COMT | DiGeorge syndrome | AD |
| CORO1A | Coronin-1A deficiency | AR |
| CR2 | Immunodeficiency, common variable, 7 | |
| CSF2RA | Surfactant metabolism dysfunction, pulmonary, 4 | |
| CSF3R | Severe congenital neutropenia | AD |
| CTLA4 | Common variable immunodeficiency - Autosomal dominant immune dysregulation syndrome | AD |
| CTPS1 | Immunodeficiency 24 | AR |
| CTSC | Papillon-Lefevre syndrome | |
| CXCR4 | WHIM syndrome | AD |
| CYBA | Chronic granulomatous disease, autosomal, due to deficiency of CYBA | AR |
| CYBB | Chronic granulomatous disease, X-linked | x-linked |
| DCLRE1B | Hoyeraal-Hreidarsson syndrome | |
| DCLRE1C | DCLRE1C (Artemis) deficiency | AR |
| DKC1 | Dyskeratosis congenita, X-linked | x-linked |
| DNASE1 | Systemic lupus erythematosus | AD |
| DNMT3B | Immunodeficiency-centromeric instability-facial anomalies syndrome 1 | AR |
| DOCK8 | Hyper-IgE recurrent infection syndrome, autosomal recessive | AR |
| ELANE | Neutropenia, severe congenital 1, autosomal dominant | AD |
| ELF4 | undetermined | |
| F12 | Angioedema, Hereditary, Type III | AD |
| FADD | Infections, recurrent, with encephalopathy, hepatic dysfunction, and cardiovasuclar malformations | |
| FAS | Autoimmune lymphoproliferative syndrome, type IA (ALPS-FAS) | AD |
| FASLG | Autoimmune lymphoproliferative syndrome, type IB (ALPS-FASG) | AD |
| FCGR1A | IgG receptor I, phagocytic, familial deficiency of | |
| FCGR2A | Pseudomonas aeruginosa, susceptibility to chronic infection by, in cystic fibrosis | |
| FCGR2B | Malaria, resistance to | |
| FCGR3A | Immunodeficiency 20 | AR |
| FCGR3B | Neutropenia, alloimmune neonatal | |
| FCGRT | none reported | |
| FCN3 | Immunodeficiency due to ficolin 3 deficiency | |
| FERMT3 | Leukocyte adhesion deficiency, type III | AR |
| FOXN1 | T-cell immunodeficiency, congenital alopecia, and nail dystrophy | AR |
| FOXP3 | Immunodysregulation, polyendocrinopathy, and enteropathy, X-linked (IPEX) | x-linked |
| FPR1 | Periodontitis | |
| G6PC3 | Neutropenia, severe congenital 4, autosomal recessive | AR |
| G6PD | Chronic Granulomatous Disease | x-linked |
| GATA2 | Immunodeficiency 21 | AD |
| GFI1 | Neutropenia, severe congenital 2, autosomal dominant | AD |
| GP1BB | DiGeorge syndrome/Bernard Soulier syndrome | |
| HAX1 | Neutropenia, severe congenital 3, autosomal recessive | AR |
| HIRA | DiGeorge syndrome | AD |
| ICOS | Immunodeficiency, common variable, 1 | AR |
| IFIH1 | Aicardi-Goutieres syndrome 7 | |
| IFNGR1 | Immunodeficiency 27A, mycobacteriosis, AR; Immunodeficiency 27B, mycobacteriosis, AD | AD |
| IFNGR2 | Immunodeficiency 28, mycobacteriosis | AR |
| IGAD1 | Immunoglobulin A deficiency | AR and AD |
| IGHM | Agammaglobulinemia 1 | AR |
| IGKC | Kappa light chain deficiency | AR |
| IGLL1 | Agammaglobulinemia 2 | AR |
| IKBKB | Immunodeficiency 15 | AR |
| IKBKG | Ectodermal dysplasia, hypohidrotic, with immune deficiency; Ectodermal, dysplasia, anhidrotic, lymphedema and immunodeficiency; Immunodeficiency 33; Immunodeficiency, isolated; Invasive pneumococcal disease, recurrent isolated, 2 | X-Linked |
| IKZF1 | Leukemia, acute lymphoblastic | AR |
| IL10 | Early onset inflammatory bowel disease | AR |
| IL10RA | Inflammatory bowel disease 28, early onset, autosomal recessive | AR |
| IL10RB | Inflammatory bowel disease 25, early onset, autosomal recessive | AR |
| IL12B | Immunodeficiency 29, mycobacteriosis | AR |
| IL12RB1 | Immunodeficiency 30 | AR |
| IL12RB2 | Mendelian susceptibility to mycobacterial disease | AR |
| IL17F | Candidiasis, familial, 6, autosomal dominant | AD |
| IL17RA | Candidiasis, familial, 5, autosomal recessive | AR |
| IL17RC | Chronic Mucocutaneous Candidiasis (CMC) | AR |
| IL18 | Defects with susceptibility to mycobacterial infection (MSMD) | |
| IL1RN | Interleukin 1 receptor antagonist deficiency | |
| IL21 | Immunodeficiency, common variable, 11 | AR |
| IL21R | Immunodeficiency, primary, autosomal recessive, IL21R-related | AR |
| IL23A | Defects with susceptibility to mycobacterial infection (MSMD) | |
| IL2RA | Interleukin-2 receptor, alpha chain, deficiency of | AR |
| IL2RG | SCID (x-linked) | X-Linked |
| IL36RN | Psoriasis, generalized pustular | AR |
| IL7R | IL7Ra deficiency | AR |
| IRAK4 | IRAK4 deficiency | AR |
| IRF3 | susceptibility to herpes simplex encephalitis | |
| IRF7 | IRF7 deficiency | |
| IRF8 | Immunodeficiency 32A, mycobacteriosis, autosomal dominant | AR and AD |
| ISG15 | susceptibility to mycobacterial infection, enhanced IFN-?/? immunity | AR |
| ITCH | Autoimmune disease, multisystem, with facial dysmorphism | AR |
| ITGB2 | Leukocyte adhesion deficiency | AR |
| ITK | Lymphoproliferative syndrome 1 (LPFS1) | AR |
| JAGN1 | severe congeital neutropenia | AR |
| JAK3 | JAK3 deficiency | AR |
| KRAS | Ras associated lymphoproliferative disease (RALD) | AR and somatic |
| LAMTOR2 | Immunodeficiency due to defect in MAPBP-interacting protein | AR |
| LCK | Immunodeficiency 22/ LCK deficiency | AR |
| LIG1 | DNA ligase I deficiency | AR |
| LIG4 | LIG4 syndrome | AR |
| LPIN2 | Majeed syndrome | AR |
| LRBA | Immunodeficiency, common variable, 8, with autoimmunity | AR |
| LRRC8A | Agammaglobulinemia 5 | AD |
| LYST | Chediak-Higashi syndrome | AR |
| MAGT1 | Immunodeficiency, X-linked, with magnesium defect, Epstein-Barr virus infection and neoplasia (XMEN) | X-Linked |
| MALT1 | Immunodeficiency 12/ MALT1 deficiency | AR |
| MASP1 | 3MC syndrome 1 | AR |
| MASP2 | MASP2 deficiency | AR |
| MBL2 | Chronic infections, due to MBL deficiency | AR/het |
| MCM4 | Natural killer cell and glucocorticoid deficiency with DNA repair defect | AR |
| MEFV | Familial Mediterranean fever, AR; Familial Mediterranean fever, AD | AR |
| MKL1 | immunodeficiency, phagocyte function | AR |
| MLPH | Griscelli syndrome, type 3 | AR |
| MPO | Myeloperoxidase deficiency | AR/het |
| MRE11A | Ataxia-telangiectasia-like disorder | AR |
| MS4A1 | Immunodeficiency, common variable, 5 | AR |
| MTHFD1 | Severe combined immunodeficiency, defect in folate metabolism | |
| MVK | Hyper-IgD syndrome | AR |
| MYD88 | Pyogenic bacterial infections, recurrent, due to MYD88 deficiency | AR |
| MYO5A | Griscelli syndrome, type 1 | AR |
| NBN | Nijmegen breakage syndrome | AR |
| NCF1 | Chronic granulomatous disease due to deficiency of NCF-1 | AR |
| NCF2 | Chronic granulomatous disease due to deficiency of NCF-2 | AR |
| NCF4 | Granulomatous disease, chronic, autosomal recessive, cytochrome b-positive, type III | AR |
| NFKB1 | Common variable immunodeficiency (CVID) | |
| NFKB2 | Immunodeficiency, common variable, 10 | AD |
| NFKBIA | Ectodermal dysplasia, anhidrotic, with T-cell immunodeficiency | AD |
| NHEJ1 | Severe combined immunodeficiency with microcephaly, growth retardation, and sensitivity to ionizing radiation | AR |
| NHP2 | Dyskeratosis congenita, autosomal recessive 2 | AR |
| NLRP12 | Familial cold autoinflammatory syndrome 2 | het |
| NLRP3 | CINCA syndrome; Muckle-Wells syndrome | AR |
| NOD2 | Blau syndrome | |
| NOP10 | Dyskeratosis congenita, autosomal recessive 1 | AR |
| NRAS | Autoimmune lymphoproliferative syndrome type IV | |
| ORAI1 | Immunodeficiency 9 | AR |
| OSTM1 | Osteopetrosis, autosomal recessive 5 | |
| PGM3 | Immunodeficiency 23 | AR |
| PIK3CD | Immunodeficiency 14 | AD |
| PIK3R1 | Agammaglobulinemia 7, autosomal recessive | AR |
| PLCG2 | Autoinflammation, antibody deficiency, and immune dysregulation syndrome | AD |
| PMS2 | Mismatch repair cancer syndrome | |
| PNP | Immunodeficiency due to purine nucleoside phosphorylase deficiency; Purine nucleoside phosphorylase (PNP) deficiency | AR |
| POLE | FILS syndrome | AR |
| PRF1 | Hemophagocytic lymphohistiocytosis, familial, 2 | AR |
| PRKCD | Immunodeficiency, common variable, 9; ALPS3 | AR |
| PRKDC | DNA Pkcs deficiency | AR |
| PSMB8 | Autoinflammation, lipodystrophy, and dermatosis syndrome | AR |
| PSTPIP1 | Pyogenic sterile arthritis, pyoderma gangrenosum, and acne | |
| PTPRC | CD45 deficiency | AR |
| RAB27A | Griscelli syndrome, type 2 | AR |
| RAC2 | Neutrophil immunodeficiency syndrome | |
| RAG1 | RAG1 deficiency | AR |
| RAG2 | RAG2 deficiency | AR |
| RBCK1 | Polyglucosan body myopathy, early-onset, with or without immunodeficiency | AR |
| RECQL4 | Rothmund-Thomson syndrome | AR |
| RFX5 | Bare lymphocyte syndrome, type II, complementation group C | AR |
| RFXANK | MHC class II deficiency, complementation group B | AR |
| RFXAP | Bare lymphocyte syndrome, type II, complementation group D | AR |
| RHOH | RhoH deficiency | AR |
| RMRP | Cartilage-hair hypoplasia | AR |
| RNASEH2A | Aicardi-Goutieres syndrome 4 | |
| RNASEH2B | Aicardi-Goutieres syndrome 2 | |
| RNASEH2C | Aicardi-Goutieres syndrome 3 | |
| RNF168 | RIDDLE syndrome | AR |
| RORC | Susceptibility to candidasis & Mycobacterial infection | |
| RPSA | Isolated congential asplenia | AR |
| RTEL1 | Hoyeraal-Hreidarsson syndrome/ Dyskeratosis congenita, autosomal dominant 4; Dyskeratosis congenita, autosomal recessive 5 | AR and AD |
| SAMHD1 | Aicardi-Goutieres syndrome 5 | |
| SBDS | Shwachman-Bodian-Diamond syndrome | AR |
| SEMA3E | Charge syndrome | AD |
| SERPING1 | Angioedema, hereditary, types I and II | AD |
| SH2D1A | Lymphoproliferative syndrome, X-linked, 1 (XLP1) | X-Linked |
| SH3BP2 | Cherubism | |
| SLC11A1 | Mycobacterium tuberculosis, susceptibility to infection by | |
| SLC29A3 | Histiocytosis-lymphadenopathy plus syndrome | AR |
| SLC35C1 | Congenital disorder of glycosylation, type IIc | AR |
| SLC37A4 | Glycogen storage disease Ib | |
| SLC46A1 | Folate malabsorption, hereditary | |
| SMARCAL1 | Schimke immunoosseous dysplasia | AR |
| SP110 | Hepatic venoocclusive disease with immunodeficiency | AR |
| SPINK5 | Netherton syndrome | AR |
| STAT1 | Immunodeficiency 31A, mycobacteriosis, autosomal dominant; Candidiasis, familial, 7 | AR and AD |
| STAT2 | STAT2 deficiency | AR |
| STAT3 | Hyper-IgE recurrent infection syndrome; Autoimmune disease, multisystem, infantile-onset | AR/AD |
| STAT5A | Growth hormone insensitivity with immunodeficiency | |
| STAT5B | Growth hormone insensitivity with immunodeficiency | AR |
| STIM1 | Immunodeficiency 10 | AR |
| STK4 | T-cell immunodeficiency, recurrent infections, autoimmunity, and cardiac malformations | AR |
| STX11 | Hemophagocytic lymphohistiocytosis, familial, 4 | AR |
| STXBP2 | Hemophagocytic lymphohistiocytosis, familial, 5 | AR |
| TAP1 | Bare lymphocyte syndrome, type I | AR |
| TAP2 | Bare lymphocyte syndrome, type I, due to TAP2 deficiency | AR |
| TAPBP | Bare lymphocyte syndrome, type I | AR |
| TAZ | Barth syndrome | X-Linked |
| TBK1 | Herpes simplex encephalitis, susceptibility to, | |
| TBX1 | Di George syndrome | AD |
| TCF3 | E47 TF deficiency | |
| TCIRG1 | Osteopetrosis, autosomal recessive 1 | |
| TCN2 | Transcobalamin-2 precursor | AR |
| TERC | Dyskeratosis congenita, autosomal dominant 1 | AD |
| TERT | Dyskeratosis congenita, autosomal dominant 2, Dyskeratosis congenita, autosomal recessive 4 | AD |
| THBD | Hemolytic uremic syndrome, atypical, susceptibility to, 6 | |
| TICAM1 | Encephalopathy, acute, infection-induced, susceptibility to, 6 | AR and AD |
| TINF2 | Dyskeratosis congenita, autosomal dominant 3 | AD |
| TIRAP | Pneumococcal disease, invasive, protection against | |
| TLR3 | Herpes simplex encephalitis, susceptibility to, 2 | |
| TMC6 | Epidermodysplasia verruciformis | |
| TMC8 | Epidermodysplasia verruciformis | |
| TMEM173 | STING-associated vasculopathy, infantile-onset | |
| TNFRSF11A | Osteolysis, familial expansile ; Osteopetrosis, autosomal recessive 7 | |
| TNFRSF13B | Immunodeficiency, common variable, 2 | AR and AD |
| TNFRSF13C | Immunodeficiency, common variable, 4 | AR |
| TNFRSF1A | Periodic fever, familial | AD |
| TNFRSF4 | Immunodeficiency 16/ OX40 deficiency | AR |
| TNFSF12 | Immunodeficiency, common variable with lack of anti-pneumococcal antibody | |
| TPP2 | TPP2 deficiency | |
| TRAC | Immunodeficiency 7, TCR-alpha/beta deficient | AR |
| TRAF3 | Herpes simplex encephalitis, susceptibility to, 3 | AD |
| TRAF3IP2 | Candidiasis, familial, 8 | AR |
| TREX1 | Aicardi-Goutieres syndrome 1, dominant and recessive | |
| TRNT1 | congenital sideroblastic anemia with immunodeficiency, fevers, and developmental delay (SIFD) | AR |
| TTC37 | Trichohepatoenteric syndrome 1 | |
| TTC7A | Multiple intestinal atresia and severe combined immunodeficiency (MINAT) | AR |
| TYK2 | Immunodeficiency 35 | AR |
| UFD1L | DiGeorge syndrome | AD |
| UNC119 | Immunodeficiency 13/ UNC119 deficiency | |
| UNC13D | Hemophagocytic lymphohistiocytosis, familial, 3 | AR |
| UNC93B1 | Herpes simplex encephalitis, susceptibility to, 1 | AR |
| UNG | Immunodeficiency with hyper IgM, type 5 | AR |
| USB1 | Poikiloderma with neutropenia | AR |
| VPS13B | Cohen syndrome | AR |
| VPS45 | Neutropenia, severe congenital, 5, autosomal recessive | AR |
| WAS | Wiskott-Aldrich syndrome | X-Linked |
| WIPF1 | Wiskott-Aldrich syndrome 2 | AR |
| WRAP53 | Dyskeratosis congenita, autosomal recessive 3 | AR |
| XIAP | Lymphoproliferative syndrome, X-linked, 2 (XLP2) | X-Linked |
| XRCC4 | none reported | |
| ZAP70 | Zap-70 deficiency | AR |
| ZBTB24 | Immunodeficiency-centromeric instability-facial anomalies syndrome-2 | AR |

---

# Autoinflammatory disease genes

| Autoinflammatory genes | Disorder |
|------------------------|----------|
| ACP5 | Spondyloenchondrodysplasi a with immune dysregulation |
| ACP5 | Spondyloenchondrodysplasia with immune dysregulation |
| ADAR | Dyschromatosis symmetrica hereditaria, Aicardi-Goutières syndrome |
| Aicardi |  Goutieres syndromes (AGS) TREX1 (AGS1), RNASEH2B (AGS2), RNASEH2C (AGS3), RNASEH2A (AGS4), SAMHD1 (AGS5), ADAR (AGS6), and IFIH1 (AGS7) |
| AP1S3 | Pustular psoriasis (PSORS15) |
| CARD14 | Familial Psoriasis (PSORS2) |
| CECR1 | Deficiency of Adenosine Deaminase 2 (DADA2) aka Fever with Early Onset Stroke (FEOS) |
| DDX58 | Singleton-Merten syndrome |
| ELANE | Cyclic Neutropenia |
| FOXP3 | IPEX syndrome |
| GCH1 | Dopa responsive dystonia, Tetrahydrobiopterin deficiency |
| Gene | Associated phenotypes |
| HAX1 | Severe Congenital Neutropenia |
| HTR1A | Periodic fever, menstrual cycle |
| IFIH1 | Singleton-Merten syndrome |
| IL10 | Early Onset Inflammatory Bowel Disease (EoIBD25, EOIBD28, and EOIBD with Il10 deficiency) |
| IL10RA | Early Onset Inflammatory Bowel Disease (EoIBD25, EOIBD28, and EOIBD with Il10 deficiency) |
| IL10RB | Early Onset Inflammatory Bowel Disease (EoIBD25, EOIBD28, and EOIBD with Il10 deficiency) |
| IL1RN | Deficiency of Interleukin 1ß (IL1ß) Receptor Antagonist (DIRA) . Osteomyelitis, sterile multifocal, with periostitis and pustulosis |
| IL36RN | Pustular psoriasis, generalized  - Deficiency of Interleukin 36Receptor Antagonist (DITRA) |
| ISG15 | Immunodeficiency 38 with basal ganglia calcification (IMD38) |
| LPIN2 | Majeed syndrome |
| MEFV | Familial Mediterranean Fever (FMF) |
| MVK | Mevalonate Kinase Deficiencies (MKD): Hyper-IgD syndrome (HIDS) and MA |
| NEFL | Charcot Marie |
| NLRC4 | NLRC4 Macrophage Activation |
| NLRP12 | Familial Cold Autoinflammatory Syndrome 2 (FCAS2) |
| NLRP3 | Cryopyrin Associated Periodic Syndromes (CAPS): MWS, FCAS, CINCA and NOMID |
| NLRP7 | Recurrent hydatidiform mole |
| NOD2 | Blau syndrome, Sarcoidosis, early-onset |
| ORAI1 | Myopathy, tubular aggregate, 2 (TAM2), Immunodeficiency 9 (IMD9) |
| PLCG2 | PLCG2associated Antibody Deficiency & Immune Dysregulation (PLAID) or Familial Atypical Cold Urticaria (FACU) or FCAS3 and APLAID |
| PSMB8 | Chronic Atypical Neutrophilic Dermatosis with Lipodystrophy and Elevated Temperature Syndrome (CANDLE), Nakajo-Nishimura syndrome, Chronic atypical neutrophilic dermatosis with lipodystrophy and elevated temperature syndrome, Autoinflammation, lipodystrophy, and dermatosis syndrome, Joint contractures, muscular atrophy, microcytic anemia, and panniculitis-induced lipodystrophy syndrome |
| PSTPIP1 | Pyogenic Sterile Arthritis, Pyoderma Gangrenosum, and Acne Syndrome (PAPA) |
| RBCK1 | Polyglucosan body myopathy 1 with or without immunodeficiency (PGBM1) |
| RNASEH2A | Aicardi-Goutières syndrome |
| RNASEH2B | Aicardi-Goutières syndrome |
| RNASEH2C | Aicardi-Goutières syndrome |
| SAMHD1 | Aicardi-Goutières syndrome |
| SCO2 | Myopia 6 (MYP6), Cardioencephalomyopathy, fatal infantile, due to cytochrome c oxidase deficiency 1 (CEMCOX1) |
| SH3BP2 | Cherubism |
| SLC19A3 | biotin thiamine responsive basal ganglia disease |
| SLC25A19 | Amish lethal microcephaly |
| SLC29A3 | SLC29A3 Spectrum Disorder, aka H. syndrome; Pigmented Hypertrichosis with Insulin dependent Diabetes Mellitus (IDDM) |
| TLR3 | Human immunodeficiency virus type 1, susceptibility to |
| TMEM173 | STING-associated vasculopathy, infantile-onsent (SAVI) |
| TNFAIP3 | Haploinsufficiency of A20 (HA20), aka Behcet |
| TNFRSF11A | TNFRSF11A associated hereditary fever disease (TRAPS11) |
| TNFRSF1A | Periodic fever (Tumor Necrosis Factor (TNF) Associated Periodic Syndrome (TRAPS)) |
| TPK1 | Thiamine metabolism dysfunction syndrome 5, episodic encephalopathy type (THMD5) |
| TRAF3 | Herpes simplex encephalitis, susceptibility to |
| TREX1 | Vasculopathy, retinal, with cerebral leukodystrophy, Chilblain lupus, Aicardi-Goutières syndrome |
| TRNT1 | Sideroblastic anemia with B cell immunodeficiency, periodic fevers, and developmental delay (SIFD) |
