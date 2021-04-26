setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

library(shiny)
library(shinydashboard)

ui <- fluidPage(
  headerPanel(
    title = "Shiny File Upload Example"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload the file"),
      h5("Max file size to upload is 5 MB"),
      radioButtons("sep","Separator",
                   choices = c(Comma = ",", Period = ".",
                               Tilde = "~", minus = "-")),
      checkboxInput("header","Header?")
    ),
    mainPanel(
      tableOutput("input_file")
    )  
  )
)


server <- function(input, output){
  
  output$input_file <- renderTable({
    
    file_to_read = input$file
    
    if(is.null(file_to_read)){
      return()
    }
  
  read.table(file_to_read$datapath, 
             sep = input$sep, 
             header = input$header)
  })
}

shinyApp(ui = ui, server = server)