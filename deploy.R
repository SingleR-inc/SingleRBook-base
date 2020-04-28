# Deployment script.

builddir <- "build"
dir.create(builddir, showWarnings=FALSE)
unlink(list.files(builddir, pattern="Rmd$", full.names=TRUE))

ordering <- c(
    "introduction.Rmd", 
    "bulkref.Rmd",
    "scref.Rmd",
    "diagnostics.Rmd", 
    "multiple.Rmd",
    "ontology.Rmd", 
    "advanced.Rmd"
)

for (x in seq_along(ordering)) {
    new.name <- sprintf("%02d-%s", x, ordering[x])
    file.copy(file.path("topics", ordering[x]), file.path(builddir, new.name))
}

for (y in list.files("sundries", full.names=TRUE)) {
    file.copy(y, file.path(builddir, basename(y)), overwrite=TRUE)
}

file.copy("ref.bib", builddir, overwrite=TRUE)

setwd(builddir)
bookdown::render_book('index.Rmd')
