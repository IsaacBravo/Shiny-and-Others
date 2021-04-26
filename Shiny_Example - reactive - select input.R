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
                   inline = TRUE),
      sliderInput("ndayspent",
                  "No. of days spent",1,100, value = c(10,20),
                  step = 5),
      selectInput("dept","what is your department", 
                  choices = c("Marketing","Finance","Other"),
                  multiple = TRUE
      )
    ),
    mainPanel(
      textOutput("project_code"),
      textOutput("project_name"),
      textOutput("technology_used"),
      textOutput("location"),
      textOutput("no_of_days_spent"),
      textOutput("department"),
      
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
  
  output$no_of_days_spent <- {(
    renderText(input$ndayspent)  
  )} 
  
  output$department <- {(
    renderText(input$dept)  
  )}  
  
}

shinyApp(ui = ui, server = server)