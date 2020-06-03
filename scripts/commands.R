### TODO: put into the script, some parts are redundant!
pkgs <- list(
  "knitr", # for nice formatting
  "blogdown" # the clue of the tutorial
)

# check if pkgs installed, and install after providing a warning if not
invisible(
  lapply(pkgs, function(pkg) {
    if (!library(pkg, character.only = TRUE, logical.return = TRUE)) {
      print(paste0("Warning: Installing the ", pkg, 
                   ". You have 5s to stop the process."))
      Sys.sleep(5)
      install.packages(pkg)
    }
    library(pkg, character.only = TRUE, logical.return = TRUE)
  })
)

# Create new site into `example_website` directory
new_site(dir = "example_website/")

# Create new website, with new theme
new_site("new_site", theme = "gcushen/hugo-academic", theme_example = TRUE)