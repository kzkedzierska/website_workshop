#!/bin/Rscript
# Short script to check for and install all packages needed for the workshop.
# cowsay package is not entirely necessary, but I hope it'll make people smile.

# Checking for the necessary packages
list_of_pkgs <- c("curl", "rmarkdown", "blogdown", "cowsay")

null <-
  lapply(list_of_pkgs, function(pkg) {
  if (!suppressWarnings(library(pkg, character.only = TRUE, 
                                logical.return = TRUE))) {
    wait <- 3
    print(paste0("Warning: Installing ", pkg, 
                 ". You have ", wait,
                 "s to stop the process (by pressing Ctrl+C for example)."))
    Sys.sleep(wait)
    
    # check if CRAN is set up and if not, set Bristol one
    if (options('repos') == "@CRAN@") {
      chooseCRANmirror(81, graphics = FALSE)
    }
    
    # install the package
    install.packages(pkg, dependencies = TRUE, verbose = TRUE)
  }
})

# Installing HUGO, the engine that powers the website
print("Installing HUGO.")
blogdown::install_hugo()


check_if_installed <- sapply(c(list_of_pkgs, "curl"), function(pkg) {
  require(pkg, character.only = TRUE, quietly = TRUE)
})

if (all(check_if_installed)) {
  cowsay::say(what = "All done! Ready for the session :)", 
              by = "cow")
} else {
  print("##############################   ERROR   ##############################")
  print("# Something went wrong. Might be that additional system libraries     #")
  print("# are necessary. Try going through the installation log and follow    #")
  print("# the instruction. In case you use conda, you might trying installing #")
  print("# the packages with:                                                  #")
  print("#      conda install -c conda-forge r-blogdown                        #")
  print("#      conda install -c r r-rcurl r-rmarkdown                         #")
  print("#######################################################################")
}

