if (packageVersion('shiny') < 1.5) {
  source("R/functions/funcs.R")
}

inputFile <- function() {
  div(
    checkboxInput("useBuiltIns", label = "Use built-in datasets", value = FALSE),
    div(id = "noDataSet",
      column(1.5, ""),
      column(9, 
             div(
               "If you don't have a dataset, you can try the built-in datasets",
               selectizeInput("selectBuiltIns", "Select a dataset" ,c("", ls("package:datasets")), selected = "")
             )
             ),
      column(1.5, "")
    ),
    
    column(4, 
           div( id = "uploader",
             uploader,
             fileInput("uploadFile", "Choose a file (csv, xls, xlsx)",
                       multiple = FALSE,
                       accept = c("text/csv",
                                  "application/vnd.ms-excel",
                                  "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                                  "text/comma-separated-values,text/plain",
                                  ".csv"))
           )),
    column(8, 
           htmlOutput("fileSummary"))
  )
  
}