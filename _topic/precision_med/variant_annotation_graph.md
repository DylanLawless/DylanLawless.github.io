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
<p class="meta">01 Jul 2022 - last update</p>

Variant annotation is one major step in the diagnosis of genetic disease.

* [View a list of annotation tools that I recommend]({{ site.baseurl }}{% link _topic/precision_med/variant_annotation.md %}).
* [View a list of databases that I recommend]({{ site.baseurl }}{% link _topic/precision_med/variant_annotation_table_main.html %}).

<p>Select an alternative analysis protocol using tabs.</p>

<div class="w3-bar w3-black">
<!-- <div class="w3-bar w3-dark-grey"> -->
    <button class="tab tablink w3-green" onclick="openCity(event,'module_GermlineSNV')">Germline SNV/INDEL</button>
    <button class="tab tablink w3-green" onclick="openCity(event,'module_RNAseq')">RNAseq</button>
</div>

<!-- # NOTE:                                    --> 
<!-- # This file must be already online,        --> 
<!-- # it seems that the jekyll tags to         --> 
<!-- # relative path break the downstream html. -->
<div id="module_GermlineSNV" class="w3-container city">
<object type="image/svg+xml" data="https://lawlessgenomics.com/pages/portfolio_live/variant_annotation_graph_v2_side_A.svg">
    <!-- Your fall back here -->
    <img src="image.svg" />
</object>
A PDF version of this figure is linked to [<a href="https://lawlessgenomics.com/pages/portfolio_live/variant_annotation_graph.pdf">download here</a>].
</div>

<div id="module_RNAseq" class="w3-container city" style="display:none">
<object type="image/svg+xml" data="https://lawlessgenomics.com/pages/portfolio_live/variant_annotation_graph_v2_side_A.svg">
    <!-- Your fall back here -->
    <img src="image.svg" />
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
