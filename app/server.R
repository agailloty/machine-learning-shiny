if (packageVersion('shiny') < 1.5) {
  source("R/functions/funcs.R")
}
shinyServer(
  function(input, output, session) {
    observeEvent(input$useBuiltIns, {
      shinyjs::toggle(id = "noDataSet")
      
      if (input$useBuiltIns) {
        shinyjs::hide(id = "uploadFile")
        shinyjs::hide(id = "uploader")
      } else {
        shinyjs::show(id = "uploadFile")
        shinyjs::show(id = "uploader")
      }
    })
    
    observeEvent(input$selectBuiltIns, {
      if (input$selectBuiltIns == "") {
        return()
      }
      if (input$useBuiltIns) {
        output$fileSummary <- renderUI(summarizeDF( get(input$selectBuiltIns), input, output))
      } else {
        
      }
    })
  }
)