library(shiny)
library(shinyWidgets)
library(magrittr)
#***********************************************************
# Dir where graphs are located, relative to app folder +
# getting list of imgs
dir <- "../_graphs/"
imgList <-  list.files(dir, pattern=".*", 
                       full.names=TRUE) %>%   
                .[grep("png$",.)]             # PNGs only
                
# Scenario Number List
## List element NAME: JUN21 draft numbering
## List element CONTENTS: internal numbering
scList <- list(
            "Scenario 1 (squared term)" = "sc 5",
            "Scenario 2 (interaction)"  = "sc 6",
            "Scenario 3 (squared term)" = "sc 1",
            "Scenario 4 (interaction)"  = "sc 2"
          )

# % of RC
rcPercList <- c("None" = "p0", 
                "25%"  = "p25")

# Get list of correspondences for 0/1 x2 vs contin x2
scEquivList <- list(
                 "sc 5" = "sc 11",
                 "sc 6" = "sc 12",
                 "sc 1" = "sc 9",
                 "sc 2" = "sc 10"
               )