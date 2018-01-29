#
# This is the server logic of the Shiny web application. 
#

library(shiny)


# Define server logic required to draw a histogram

piValues <- data.frame(nb_points = numeric(), value = numeric())


shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    
    number_of_points <- input$Points
    
    mydf <- data.frame(
      dataX = runif(number_of_points, 0, 1), 
      dataY = runif(number_of_points, 0, 1))
    
    mydf$in_circle = ifelse(mydf$dataX^2+mydf$dataY^2 <= 1, TRUE, FALSE)
    
    main <- ifelse(input$show_title, "Current distribution of the random points", "")
    
    point_col = ifelse(mydf$in_circle, "green", "red")
    plot(mydf$dataX, mydf$dataY, main = main, xlab = "X", ylab = "Y",
      xlim = c(0, 1), ylim = c(0, 1), col = point_col, asp = 1)
    
    myPi <- nrow(mydf[mydf$in_circle == TRUE,]) * 4 / number_of_points
    
    output$myPi <- renderText(myPi)
    
    error <- 100*abs(myPi-pi)/pi
    
    output$error <- renderText(error)
    
    newdf <- data.frame(nb_points = number_of_points , error = error)
    piValues <<- rbind(piValues, newdf)
  
    output$valuesPlot <- renderPlot({
      main <- ifelse(input$show_title, "Relative errors", "")
      plot(piValues$nb_points, piValues$error, main = main, col = "blue", 
           ylab = "% error", xlab = "Number of points")
    })
    
    output$valuesNb <-renderText(nrow(piValues))

  })
  

  
})


