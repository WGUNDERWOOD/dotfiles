#!/usr/bin/env Rscript

lib_loc <- "~/R_packages"
to_install <- unname(installed.packages(lib.loc = lib_loc)[, "Package"])
install.packages(pkgs = to_install)
