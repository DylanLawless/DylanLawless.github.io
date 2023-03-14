---
layout: topic
title: Variant annotation graph
date: 2021-09-22 00:00:01
bibliography:
- '../tail/bibliography.bib'
tags: genomics
subject: Precision medicine
---
{{ page.title }}
================
<p class="meta">26 Aug 2022 - last update</p>

Variant annotation is one major step in the diagnosis of genetic disease.

* [View a list of annotation tools that I recommend]({{ site.baseurl }}{% link _topic/precision_med/variant_annotation.md %}).
* [View a list of databases that I recommend]({{ site.baseurl }}{% link _topic/precision_med/variant_annotation_table_main.html %}).

Select an alternative analysis protocol using tabs.

<div class="w3-bar w3-black">
    <button class="tab tablink w3-green button" onclick="openCity(event,'module_GermlineSNV')">Germline SNV/INDEL</button>
    <button class="tab tablink w3-green" onclick="openCity(event,'module_RNAseq')">RNAseq</button>
</div>

<!-- # NOTE:                                    --> 
<!-- # This file must be already online,        --> 
<!-- # it seems that the jekyll tags to         --> 
<!-- # relative path break the downstream html. -->

<!-- # Note: -->
<!-- For the initial display, remove display:none -->

<!-- <div id="module_GermlineSNV" class="w3-container city active" style="display:none"> -->
<div id="module_GermlineSNV" class="w3-container city">
	<object type="image/svg+xml" data="https://lawlessgenomics.com/pages/portfolio_live/variant_annotation_graph_v2_side_A.svg">
	</object>
</div>

<div id="module_RNAseq" class="w3-container city" style="display:none">
<!-- <div id="module_RNAseq" class="w3-container city"> -->
	<object type="image/svg+xml" data="https://lawlessgenomics.com/pages/portfolio_live/variant_annotation_graph_v2_RNA.svg">
	</object>
</div>

<script>
function openCity(evt, cityName) {
  var i, x, tablinks;
  x = document.getElementsByClassName("city");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < x.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" w3-green", "");
  }
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " w3-green";
}
</script>

A PDF version of the Germline SNV/INDEL protocol is linked to [<a href="https://lawlessgenomics.com/pages/portfolio_live/variant_annotation_graph.pdf">download here</a>].
A PDF version of the RNAseq protocols will be available for download in the near future.
