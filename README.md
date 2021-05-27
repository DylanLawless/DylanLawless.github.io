# This is the data for LawlessGenomics
[lawlessgenomics.com](https://lawlessgenomics.com) hosted via [DylanLawless.github.io](https://dylanlawless.github.io)

Some installs may be required to serve this site locally for testing; 
e.g. at least requires:
"gem install jekyll-scholar"

It is repo automatically transformed by [Jekyll](http://github.com/mojombo/jekyll)
into a static site whenever I push this repository to GitHub.
For testing, jekyll serve runs this site locally for testing before pushing (jek.sh). 
The format of pages and blog structure were produced by copying the original code from co-creator of GitHub, Tom Preston-Werner, and then modifying to suit the current requierments for Jekyll. 
This site is built from writings in Markdown and LaTex and rendered as a minimalist source of knowledge without annoying popups, ads, or heavy content. One piece "analytic data" is recorded using [hit-counter](https://github.com/brentvollebregt/hit-counter).

The data is stored on GitHub and in private backups so that content is not lost and can be pushed from many locations.

Bibliography is set to update from my cloud master bib via shell script "update_bib.sh".
The scholar plugin is used by: plugins/ext.rb (require 'jekyll/scholar').
With this plugin, no information is required for the biblio in individual file headers.
Within text citations are used with: {% cite name %}.
The biblio is printed at end of file with:
{% bibliography --cited %}.

# Rake deploy
Plugins (scholar) cannot be run on GitHub pages, therefore the site is run by using the \_site directory as the root as described by [davidensinger.com](http://davidensinger.com/2013/07/automating-jekyll-deployment-to-github-pages-with-rake/).

The following tasks are automated by putting them in a rake file.

Delete master branch:
```
git branch -D master
```
Check out a new master branch:
```
git checkout -b master
```
Force the \_site/ subdirectory to be project root:
```
git filter-branch --subdirectory-filter _site/ -f
```
Checkout the source branch:
```
git checkout source
```
Push all branches to origin:
```
git push --all origin
```

The rake file is used as follows:

List the tasks from the Rakefile
```
rake -T
```

Run these individually
```
rake preview
```

The normal protocol is to run the tasks in order with one command
```
rake commit_deploy
```

# License
The following directories and their contents are Copyright Dylan Lawless.
You may not reuse anything therein without my permission (although I am unlikely to complain about non-profit usage):

* \_posts/
* \_topics/
* images/

All other directories and files are MIT Licensed. Feel free to use the HTML and
CSS as you please. If you a copy the jekyll site generator, a link back to
http://github.com/mojombo/jekyll would be appreciated by the devolper, but is not required.
If you copy my pushlished content, a link back to https://lawlessgenomics.com would be appreciated.

For git tracking, test:
`git config merge.conflictstyle diff3`

