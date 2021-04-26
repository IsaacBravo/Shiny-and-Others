library(shiny)
library(shinydashboard)

ui <- fluidPage(
  headerPanel(
    title = "Texct Input Shiny Widget"),
  sidebarLayout(
    sidebarPanel(
      textInput("projcode","Enter your project code"),
      textInput("projName", "Enter the project Name"),
      textInput("tech","Technology you are using?"),
      radioButtons("loc","What is your location", 
                   choices = c("off-site","on-site"),
                   selected = "on-site",
                   inline = TRUE)
    ),
    mainPanel(
      textOutput("project_code"),
      textOutput("project_name"),
      textOutput("technology_used"),
      textOutput("location")
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
  
  output$location <- {(
    renderText(input$loc)  
  )} 
  
}

shinyApp(ui = ui, server = server)