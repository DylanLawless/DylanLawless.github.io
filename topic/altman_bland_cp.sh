#!/bin/bash

# cp ~/web/notes/202*-perm-altman_bland*md ./

name=test
file=202107191052-lit-sensitivity_specificity.md

cat ./.altman_bland_head > altman_bland_$name.md

printf "<sup id="a1">[1](#f1)</sup>" >> ./altman_bland_$name.md

cat ~/web/notes/$file >> ./altman_bland_$name.md

printf "## References\n{% bibliography --cited %}\n" >> ./altman_bland_$name.md

printf "**Footnote**\n<b id="f1">1</b> This article is almost identical to the original version in acknowledgment to Altman and Bland. It is adapted here as part of a set of curated, consistent, and minimal examples of statistics required for human genomic analysis.\n[↩](#a1)" >> ./altman_bland_$name.md
