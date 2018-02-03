#
# This is the user-interface definition of the Shiny web application.
# https://en.wikipedia.org/wiki/Monte_Carlo_method
#

library(shiny)

# Define UI for application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Computing an estimation of Pi using a Monte Carlo method"),
  h1(""),
  
  h4("Quick Start Documentation"),
  h5("This application estimates Pi by using a sample of uniformly distributed random points"),
  h5("in a square. The estimated value is the ratio of the number of points in the inscribed disk (x 4)"),
  h5("over the total number of points. The relative error is reported."),
  
  h1(""),
  h5("Just type in the number of random points to use (max < 100001) and click the <Submit> button. Retry with other values."),
  h1(""),
  
  h1(""),
  h5("See: "),
  h5(a("Wikipedia Monte Carlo method article", href="https://en.wikipedia.org/wiki/Monte_Carlo_method")),
  h5(a("Application reproductible pitch presentation at RPubs", href="http://rpubs.com/Antonio-Guerreiro/Pi")),
  h5(a("Source code available on GitHub", href="https://github.com/Antonio-Guerreiro/Data_Products")),
  h1(""),
  
  h4("Shiny Application"),
  h1(""),
  
  # Sidebar with a numeric input for number of points
  sidebarLayout(
    sidebarPanel(
    
       numericInput("Points",
                   "How many uniformely distributed random points?",
                   min = 1,
                   max = 100000,
                   value = 5000, step = 1),
       submitButton("Submit"),
       
       h1(" "),
       h5("Estimated Pi value"),
       textOutput("myPi"),
       h1(" "),
       h5("% Error"),
       textOutput("error"),
       h1(" "),
       h5("Current Total number of estimations"),
       textOutput("valuesNb")
   ),
    
    # Show a plot of the generated distribution
    mainPanel(
      checkboxInput("show_title", "Show/Hide Title", value = TRUE),
      plotOutput("distPlot"),
      plotOutput("valuesPlot")
    )
  )
))