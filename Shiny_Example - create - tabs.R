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
                  tabPanel("Data", tableOutput("mtcars")),
                  tabPanel("Summary", verbatimTextOutput("summ")),
                  tabPanel("Plot", plotOutput("plot"))
                  )  
    )
  )
)

server <- function(input, output){
  
  output$mtcars <- renderTable({
    mtcars[,c("mpg", input$ngear)]
  })
  
  output$summ <- renderPrint({
    summary(mtcars)
  })
  
  output$plot <- renderPlot({
    with(mtcars, boxplot(mpg~gear))
  })
  
}

shinyApp(ui = ui, server = server)