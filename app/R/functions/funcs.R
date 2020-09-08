library(readr)
library(readxl)

uploader <- div(
  checkboxInput("header", "Header", TRUE),
  
  radioButtons("sep", "Separator",
               choices = c(Comma = ",",
                           Semicolon = ";",
                           Tab = "\t"),
               selected = ","),
  radioButtons("quote", "Quote",
               choices = c(None = "",
                           "Double Quote" = '"',
                           "Single Quote" = "'"),
               selected = '"'),
  
  tags$hr(),
  radioButtons("disp", "Display",
               choices = c(Head = "head",
                           All = "all"),
               selected = "head")
)


summarizeDF <- function(dataset, input, output) {
  littleSummary <- function(dataset) {
    dimensions = dim(dataset)
    div(
      p(paste("This dataset contains", dimensions[1], "rows and", dimensions[2],
              "columns")),
      # p(class = "smallText", paste("Other columns :", colnames(dataset)), collapse = " - ")
    )
  }
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
        littleSummary(dataset),
      tableOutput("datasetTable"),
      output$datasetTable <- renderTable(df))
    } else {
      
      renderSummary <- div(
        littleSummary(dataset),
        tableOutput("datasetTable"),
        output$datasetTable <- renderTable(dataset)
      )
    } 
    
    return(renderSummary)
  }
}


# # Define UI for data upload app ----
# ui <- fluidPage(
#   
#   # App title ----
#   titlePanel("Uploading Files"),
#   
#   # Sidebar layout with input and output definitions ----
#   sidebarLayout(
#     
#     # Sidebar panel for inputs ----
#     sidebarPanel(
#       
#       # Input: Select a file ----
#       fileInput("file1", "Choose CSV File",
#                 multiple = FALSE,
#                 accept = c("text/csv",
#                            "text/comma-separated-values,text/plain",
#                            ".csv")),
#       
#       # Horizontal line ----
#       tags$hr(),
#       
#       # Input: Checkbox if file has header ----
#       checkboxInput("header", "Header", TRUE),
#       
#       # Input: Select separator ----
#       radioButtons("sep", "Separator",
#                    choices = c(Comma = ",",
#                                Semicolon = ";",
#                                Tab = "\t"),
#                    selected = ","),
#       
#       # Input: Select quotes ----
#       radioButtons("quote", "Quote",
#                    choices = c(None = "",
#                                "Double Quote" = '"',
#                                "Single Quote" = "'"),
#                    selected = '"'),
#       
#       # Horizontal line ----
#       tags$hr(),
#       
#       # Input: Select number of rows to display ----
#       radioButtons("disp", "Display",
#                    choices = c(Head = "head",
#                                All = "all"),
#                    selected = "head")
#       
#     ),
#     
#     # Main panel for displaying outputs ----
#     mainPanel(
#       
#       # Output: Data file ----
#       tableOutput("contents")
#       
#     )
#     
#   )
# )
# 
# # Define server logic to read selected file ----
# server <- function(input, output) {
#   
#   output$contents <- renderTable({
#     
#     # input$file1 will be NULL initially. After the user selects
#     # and uploads a file, head of that data file by default,
#     # or all rows if selected, will be shown.
#     
#     req(input$file1)
#     
#     # when reading semicolon separated files,
#     # having a comma separator causes `read.csv` to error
#     tryCatch(
#       {
#         df <- read.csv(input$file1$datapath,
#                        header = input$header,
#                        sep = input$sep,
#                        quote = input$quote)
#       },
#       error = function(e) {
#         # return a safeError if a parsing error occurs
#         stop(safeError(e))
#       }
#     )
#     
#     if(input$disp == "head") {
#       return(head(df))
#     }
#     else {
#       return(df)
#     }
#     
#   })
#   
# }
# 
# # Create Shiny app ----
# shinyApp(ui, server)
# 
