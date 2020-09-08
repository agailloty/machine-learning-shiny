summarizeDF <- function(dataset) {
  
  if ( ! any(class(dataset) %in% c("tbl_df", "tbl", "data.frame"))) {
    div(
      h2("The data you upload is not a valid dataframe"),
      p("Please retry again")
    )
  } else {
    dimDF <- dim(dataset)
    if (dimDF[2] > 10) {
      df <- dataset[, colnames(dataset)[1:10]]
      df <- head(df, 10)
      renderSummary <- div(
        p(paste("This dataset contains", dim[1], "rows and", dim[2], "columns")),
        p(class = "smallText", paste("Other columns :", colnames(dataset)), collapse = " - "),
        tableOutput("datasetTable")
      )
      output$datasetTable <- renderTable(df)
    } else {
      
      renderSummary <- div(
        tableOutput("datasetTable"),
        output$datasetTable <- renderTable(dataset)
      )
    } 
    
    return(renderSummary)
  }
}

