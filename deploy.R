# Deployment script.

builddir <- "build"
dir.create(builddir, showWarnings=FALSE)
unlink(list.files(builddir, pattern="Rmd$", full.names=TRUE))

ordering <- c(
    "topics/introduction.Rmd", 
    "topics/bulkref.Rmd",
    "topics/scref.Rmd",
    "topics/diagnostics.Rmd", 
    "topics/multiple.Rmd",
    "topics/ontology.Rmd", 
    "topics/advanced.Rmd",
    "about/authors.Rmd",
    "about/bibliography.Rmd"
)

for (x in seq_along(ordering)) {
    new.name <- sprintf("%02d-%s", x, basename(ordering[x]))
    file.copy(ordering[x], file.path(builddir, new.name))
}

for (y in list.files("sundries", full.names=TRUE)) {
    file.copy(y, file.path(builddir, basename(y)), overwrite=TRUE)
}

file.copy("ref.bib", builddir, overwrite=TRUE)

setwd(builddir)
bookdown::render_book('index.Rmd')
