# Chapters for the SingleR book

## Overview

This repository contains the basic ingredients for the [SingleR book](https://ltla.github.io/SingleRBook).
Developers wanting to contribute scientific content to the book should make pull requests to this repository;
the others with `-release` or `-devel` suffixes are just used to host the book content on GitHub Pages.
Our set-up provides a light code-only repository (this one) for day-to-day developer use,
which avoids the Git blob bloat from storing PNGs and HTMLs in the other repository.

## Build instructions

Install all of the packages listed in the `DESCRIPTION`.
Then, run the usual **bookdown** invocation, for example:

```r
bookdown::render_book('index.Rmd')
```

Caching is performed automatically for all chapters, some clearing of the cache may be necessary to guarantee a fresh build.

## Developer instructions

To contribute reports, follow standard procedure: fork and PR.
Note that any changes will be automatically accompanied by house-keeping updates to the `DESCRIPTION`.

## Deployment instructions

The deployment cycle for this book is amusingly circuitous:

1. Commit changes to this repository, usually on the `master` branch.
2. The [**SingleRBookWrapper**](https://github.com/LTLA/SingleRBookWrapper) package is a "trojan" that we will use to sneak the book onto Bioconductor's build system (BBS) owing to the latter's package-centric nature.
It contains a GitHub Action to poll for and incorporate any changes in this repository, after which it will bump the version number and push the changes to the Bioconductor Git servers.
3. The BBS does its stuff and compiles the book.
4. The [Pages repository](https://github.com/LTLA/SingleRBook-devel) has its own GitHub Action that pulls the built tarballs from the Bioconductor website and uploads the compiled book onto GitHub Pages.

Despite its complexity, it is fully automatic beyond the first push to this repository.

