#!/bin/bash
rm image_path_html

cd images
for v1 in *.png
do

line1="<div class=\"responsive\"> <div class=\"gallery\">"
line2="<a	href=\"{{ site.baseurl }}{% link pages/portfolio/images/$v1 %}\">"
line3="<img src=\"{{ site.baseurl }}{% link pages/portfolio/images/$v1 %}\"> </a>"
line4="<div class=\"desc\"> Description"
line5="</div></div></div>"

printf '%s\n' "" >> ../image_path_html
printf '%s\n' "${line1}" >> ../image_path_html
printf '%s\n' "${line2}" >> ../image_path_html
printf '%s\n' "${line3}" >> ../image_path_html
printf '%s\n' "${line4}" >> ../image_path_html
printf '%s\n' "${line5}" >> ../image_path_html
printf '%s\n' "" >> ../image_path_html

done

