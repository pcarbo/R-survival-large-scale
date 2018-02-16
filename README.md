# A survival guide to large-scale data analysis in R

Materials for tutorial, "A survival guide to large-scale data analysis
in R."

## Overview

Large-scale data analysis in R is like the "super G" events in the
Winter Olympics---it is about pushing the physical limits of your
computer (or compute cluster). My first aim is to show you some
techniques to push your R computing further. My second aim is to help
you make more effective use of the most precious commodity in
computing---memory---and to demonstrate how R sometimes makes poor use
of it. This presentation is intended to be hands-on---bring your
laptop, and we will work through the examples together. This git
repository contains the source code for running the demos.

## Other information

+ In this tutorial I attempt to apply elements of the
[Software Carpentry approach](http://software-carpentry.org/lessons).
See also
[this article](http://dx.doi.org/10.12688/f1000research.3-62.v2).
Please also take a look at the [Code of Conduct](conduct.md), and
the [license information](LICENSE.md).

+ To generate PDFs of the slides from the R Markdown source, run `make
slides.pdf` in the [docs](docs) directory. For this to work, you will
need to to install the
[rmarkdown](https://cran.r-project.org/package=rmarkdown) package in
R, as well as any additional packages used in
[slides.Rmd](code/slides.Rmd). For more details, see the
[Makefile](docs/Makefile).

+ See also the [instructor notes](NOTES.md).

## Credits

These materials were developed by
[Peter Carbonetto](http://pcarbo.github.io) at the
[University of Chicago](https://www.uchicago.edu). Thank you to
[Matthew Stephens](http://stephenslab.uchicago.edu) for his support
and guidance. Also thanks to [Gao Wang](https://github.com/gaow) for
sharing the Python script to profile memory usage, to
[David Gerard](https://dcgerard.github.io) for sharing his code that
ultimately improved several of the examples, and to John Blischak,
John Novembre and Stefano Allesia for providing great examples to
learn from.
