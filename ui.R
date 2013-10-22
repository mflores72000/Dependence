library ( shiny ) 

doc <- tags$html(
  
  tags$head(
    tags$title('Quality Control Reability (qcr)')
  ),
  tags$body(
    h1(aling='center','MASTER OF STATISTICAL TECHNIQUES - QUALITY CONTROL CHART (DEPENDENCE)')
    #    ,
    #    p(aling='center' ,'DEVELOPMENT OF A GRAPHICS APPLICATION PROCESS CONTROL'),
    #      div(id='myDiv', class='simpleDiv',
    #        'Maintainer: Miguel Flores <mflores@outlook.com>')
  )
)



shinyUI ( pageWithSidebar ( 
  headerPanel ( doc ), 
  sidebarPanel (
    selectInput ( "dataset" , "Choose a dataset:" , 
                  choices = c ( "pistonrings" , "one"))
    ,br(),
    numericInput ( "obs" , "Number of observations to view:" , 10 ) 
    ,br(),                       
    downloadButton ( 'downloadData' , 'Download' )          
    ,br(),                       
    radioButtons ( "type" , "Quality Control Charts type:" , 
                   list ( "cusum" = "qcs.cusum", "ewma" = "qcs.ewma"))        
    ,br(),
    
    checkboxInput(inputId = "checknsigma",
                  label = strong("Number of stantard deviations:"),
                  value = FALSE)
    
    ,
    # Display this only if the density is shown
    conditionalPanel(condition = "input.checknsigma == true",
                     sliderInput(inputId = "conf.nsigma",
                                 label = "",
                                 min = 1, max = 3, value = 3, step = 0.2))
    ,br(),
    
    checkboxInput(inputId = "checktitle",
                  label = strong("Title of Chart Control:"),
                  value = FALSE)
    
    ,
    # Display this only if the density is shown
    conditionalPanel(condition = "input.checktitle == true",
                     textInput ( "title" , "" , "Chart of Control Data")  )
    
    
  ),
  mainPanel( 
    tabsetPanel ( tabPanel ( "View" , verbatimTextOutput ( "summary" ), 
                             tableOutput( "view" ) 
    )
                  ,tabPanel ( "Plot" , plotOutput ( "plot" )) 
                  ,tabPanel ( "Summary" , 
                              verbatimTextOutput ( "summaryqcs" ))
                  #                 ,tabPanel ( "Table" , tableOutput ( "table" ))
    )
  )
)
)
