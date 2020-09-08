library(shiny)
library(shinyjs)

if (packageVersion('shiny') < 1.5) {
  source("R/UI-Components/fileInput.R")
}

tagList(
  
  shinyjs::useShinyjs(),
  navbarPage(
    theme = "style.css",
    
    tabPanel(title = "Welcome"),
    tabPanel("Input page", 
             inputFile()),
    tabPanel("Modelling")
    
  )
  
)