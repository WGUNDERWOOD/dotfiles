#!/usr/bin/env Rscript
local({r <- getOption("repos")
    r["CRAN"] <- "http://cran.r-project.org"
    options(repos=r)})
lib_loc <- "~/R_packages"
to_install <- unname(installed.packages(lib.loc = lib_loc)[, "Package"])
install.packages(pkgs = to_install)
