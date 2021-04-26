setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

library(shiny)
library(shinydashboard)

ui <- fluidPage(
  headerPanel(
    title = "Shiny Tabset Example"),
  sidebarLayout(
    sidebarPanel(
      selectInput("ngear",
                  "Select the gear number",
                  c("Cylinders" = "cyl", 
                    "Transmission" = "am",
                    "Gears" = "gear"))
    ),
    mainPanel(
      tabsetPanel(type = "tab",
                  tabPanel("Data", tableOutput("mtcars"),
                           downloadButton("downloadData", 
                                          "Download Data")),
                  tabPanel("Summary", verbatimTextOutput("summ")),
                  tabPanel("Plot", plotOutput("plot"),
                           downloadButton("downloadPlot", 
                                          "Download Plot"))
      )  
    )
  )
)

server <- function(input, output){
  
  ### reactive function ###
  mtreact <- reactive ({
    mtcars[,c("mpg", input$ngear)]
  })
  
  output$mtcars <- renderTable({
    mtreact()
  })
  
  output$summ <- renderPrint({
    summary(mtreact())
  })
  
  output$plot <- renderPlot({
    with(mtreact(), boxplot(mpg~mtreact()[,2]))
  })
  
  output$downloadData <- downloadHandler(
    filename = function(){
      paste("mtcars","csv", sep = ".")
    },
    
    content = function(file){
      write.csv(mtreact(),file)
    }
  )
  
  output$downloadPlot <- downloadHandler(
    filename = function(){
      paste("mtcars-plot","png", sep = ".")
    },
    
    content = function(file){
      png(file)
      with(mtreact(), boxplot(mpg~mtreact()[,2]))
      dev.off()
    }
  )
  
}

shinyApp(ui = ui, server = server)