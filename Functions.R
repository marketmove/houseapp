# A file containing all our non standard R functions in the web application

#________________________________________________________________________
# ipak function: Install and load multiple R packages.

# Description:
# It first checks to see if packages are installed, and 
# Installs them if they are not. 
# Then, it loads them into the R session.

# Source: https://gist.github.com/stevenworthington/3178163

# ipak <- function(pkg){
#   new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
#   if (length(new.pkg)) 
#     install.packages(new.pkg, dependencies = TRUE)
#   sapply(pkg, require, character.only = TRUE)
# }
#________________________________________________________________________

#in caret: Predictor must be numeric or ordered
# since SMOTE from DMwR is not available anymore, I made a custom smote function from performanceEstimation package
lib_load<-function(){
  if(!"pacman" %in% rownames(installed.packages())){
    install.packages(pkgs = "pacman",repos = "http://cran.us.r-project.org")
  }
  # p_load is equivalent to combining both install.packages() and library()
  pacman::p_load(shiny,shinydashboard, shinyLP, shinyBS)}




# NumericInputRow: Side-by-Side User Numeric Inputs
# Based on: https://stackoverflow.com/questions/20637248/shiny-4-small-textinput-boxes-side-by-side
NumericInputRow <- function (inputId, label, value = "", min ="", max =""){
  div(style="display:inline-block",
      tags$label(label, `for` = inputId), 
      tags$input(id = inputId, type = "numeric", value = value,class="input"))
}
#________________________________________________________________________
