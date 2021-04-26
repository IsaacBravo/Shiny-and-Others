library(shiny)
library(shinydashboard)

ui <- fluidPage(
        headerPanel(
          title = "Texct Input Shiny Widget"),
        sidebarLayout(
          sidebarPanel(
            textInput("projcode","Enter your project code"),
            textInput("projName", "Enter the project Name"),
            textInput("tech","Technology you are using?")
          ),
        mainPanel(
          textOutput("project_code"),
          textOutput("project_name"),
          textOutput("technology_used")
        )
    )
)


server <- function(input, output){
  
  output$project_code <- {(
    renderText(input$projcode)
  )}
  
  output$project_name <- {(
    renderText(input$projName)
  )}    
    
  output$technology_used <- {(
    renderText(input$tech)  
  )}


  
}

shinyApp(ui = ui, server = server)