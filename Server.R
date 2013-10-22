library(qcr)
data(data)

library ( shiny ) 

shinyServer ( function ( input , output ) { 
  
  datasetInput <- reactive ({ switch ( input$dataset , 
                                       "pistonrings" = pistonrings , 
                                       "one" = one)}) 
  
  output$summary <- renderPrint ({ dataset <- datasetInput () 
                                   summary ( dataset ) }) 
  
  output$view <- renderTable ({ head ( datasetInput (), n = input$obs ) })
  
  output$downloadData <- downloadHandler ( filename = function () 
  { paste ( input$dataset , '.csv' , sep = '' ) }, 
                                           content = function ( file ) 
                                           { write.csv ( datasetInput (), file ) } )
  
  qcs <- reactive ({ type <- switch ( input$type, qcs.cusum = qcs.cusum, 
                                      qcs.ewma = qcs.ewma)
                     
                     type( x = datasetInput (),
                           conf.nsigma = input$conf.nsigma, 
                           data.name = input$title, type.data = "dependence")} )
  
  output$plot <- renderPlot ({ type <- input$type 
                               conf.nsigma <- input$conf.nsigma 
                               plot( qcs(),main=input$title) 
  }) 
  
  output$summaryqcs <- renderPrint ({ summary ( qcs ()) }) 
  #   output$table <- renderTable ({ data.frame ( x = data ()) }) 
  
}) 
