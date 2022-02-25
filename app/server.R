## >>>>>> SERVER CODE <<<<<< --------
server <- function(input, output, session) {
    
    # HELPER: Get relevant file names, given selections ====
    fNames <- reactive({

        # Get RC perc var in correct form
        rcPercNum <- gsub("^p", "", input$rcPerc) %>%         # nuke opening "p"
                        as.numeric(.)/100                     # put in dec form
        rcPercNum <- gsub("^0\\.", "\\.", paste0(rcPercNum))  # nuke leading 0
        
        # If RC perc == 0, 
        rcType <- ifelse(rcPercNum=="0", "--", input$rcType) 
        
        # Update scenario, based on whether x2 is 0/1 or continuous
        sc <- ifelse(input$x2=="bin", input$scen, scEquivList[[input$scen]]) 
        
        # Get relv regex
        regEx <- paste0(sc,", n=100, surv=", input$survVers, ", ",
                        "rcPat=", rcType, ", rcPerc=", rcPercNum)
        
        # Pull imgs from file with this syntax
        fileNm <- imgList %>% .[grep(regEx, ., perl=TRUE)]
        
        # Return
        return(fileNm)
    })
    
    # OUTPUT: display the image ====
    ## (to get rid of the title, just do a hacky solution w/CSS that 
    ##  puts a white div over the relevant top portion of graph)
    output$imgs <- renderImage(
                        list(src=fNames(),
                             height=600),
                        deleteFile=FALSE
                   )
}
