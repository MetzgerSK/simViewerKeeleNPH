## >>>>>> UI CODE <<<<<< --------
ui <- fluidPage(

    # CSS
    tags$head(
      tags$style(HTML("
        #gphTitleHider{
            z-index: 9;
            background-color: #FFF;
            position: absolute;
            top: 0;
            left: 0;
            height: 32px;
            width: 100%;
        }
        
        #imgs{
            z-index: -1;
            /*margin-top: -32px;*/  /* If active, can run into app title, at smaller widths */
        }
        
        .caption{
            font-size: 80%;
            font-weight: normal;
            color: #333;
            font-style: italic;
        }
        
        .scDesc li{
            margin-left: -15px;
        }

    "))),
    
    # Enable
    withMathJax(),
    
    # Title
    titlePanel("Keele Redux: Simulation Graphs"),
    sidebarLayout(
        
        # Left Sidebar ====
        sidebarPanel(
            # Which scenario
            selectInput(
                "scen",
                label = "Scenario?",
                choices = scList,
                selected = scList[["sc1"]]
            ),
            
            # Descriptor about key bits of scenario
            ## (Was going to make this live, but would need to use JS so that
            ## info would update upon *hovering* over a choice (and somehow make
            ## this info visible, if you use a dropdown), so just make it static.)
            HTML("<div class='scDesc' 
                       style='border-bottom: 1px solid; margin-bottom: 15px;'>
                  <strong>Scenario Info</strong><br>
                  <ul>
                    <li>Scenarios 1 and 2
                      <ul>
                        <li>\\( x_1 \\in \\Bbb Z: 22 \\le x_1 \\le 90\\) (matches Keele)</li>
                        <li>\\(x_1\\)-related params: smaller than Keele</li>
                        <li>All else matches Keele</li>
                      </ul>
                    </li>
                    <li>Scenarios 3 and 4
                      <ul>
                        <li>\\( x_1 \\sim \\mathcal{U}[0,1]\\) (modified)</li>
                        <li>\\(x_1\\)-related params: match Keele</li>
                        <li>All else matches Keele</li>
                      </ul>
                    </li>
                 </ul></div>"),
            
            # Approx vs. actual
            radioGroupButtons(
                inputId = "survVers",
                label = "PH Test Calc: Approximation or Actual?",
                choices = c("Approx"="2.44.1", "Actual"="3.2.11"),
                selected = "2.44.1",
                checkIcon = list(yes = icon("ok", lib = "glyphicon")),
                justified = TRUE,
                status = "primary"
            ),
            
            # RC amount
            selectInput(
                "rcPerc",
                label = "% of Subjects w/Right Censoring (RC)?",
                choices = rcPercList,
                selected = "p25"
            ),
            
            # If RC!=0, need to select RC pattern
            conditionalPanel(
                condition = "input.rcPerc != 'p0'",
                
                radioGroupButtons(
                    "rcType",
                    label = "RC Pattern?",
                    choices = c("Random"  = "rand", 
                                "Top 25%" = "topX"),
                    selected = "topX",
                    checkIcon = list(yes = icon("ok", lib = "glyphicon")),
                    justified = TRUE
                )
            ),
            
            # 0/1 or contin x2
            radioGroupButtons(
                "x2",
                label = HTML("PH Violator \\((x_2)\\): 0/1 or Continuous?<br/>",
                             "<span class='caption'>(unmentioned in paper; 0/1 matches Keele)</span>"),
                choices = c("0/1" = "bin", "Continuous" = "cont"),
                selected = "bin",
                checkIcon = list(yes = icon("ok", lib = "glyphicon")),
                justified = TRUE
            )
        ), 
    
        # Main Panel (graph) ====
        mainPanel(
            div(id="container", style="position:relative;",
                div(id="gphTitleHider", 
                    HTML("&nbsp;")),
                imageOutput("imgs")
            )
        )
    )    
)