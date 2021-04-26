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
                  tabPanel("Help",
                           tags$img(src="argen.jpg"),
                           tags$video(src="video.mp4",
                                      width = "500px",
                                      height = "350px",
                                      type = "video/mp4",
                                      controls = "controls"),
                           # To add youtube videos
                           HTML(' '),
                  tabPanel("Data", tableOutput("mtcars")),
                  tabPanel("Summary", verbatimTextOutput("summ")),
                  tabPanel("Plot", plotOutput("plot"))
      )  
    )
  )
))

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
  
}

shinyApp(ui = ui, server = server)