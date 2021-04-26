setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

library(shiny)
library(shinydashboard)

ui <- dashboardPage(
        title = "Demo App", skin = "red",
        dashboardHeader(title = "This is the header",
                        # dropdownMenuOutput("msgOutput"),
                        # dropdownMenu(type = "message",
                        #              messageItem(from = "Finance update",
                        #                          message = "we are on threshold"),
                        #              messageItem(from = "sales update",
                        #                          message = "Sales are at 55%",
                        #                          icon = icon("bar-chart"),
                        #                          time = "22:00"),
                        #              messageItem(from = "Sales update",
                        #                          message = "Sales meeting at 6 PM on Monday",
                        #                          icon = icon("handshake-o"),time = "25-03-2021"),
                        dropdownMenu(type = "notifications",
                                     notificationItem(
                                       text = "2 new tabs added to the dashboard",
                                       icon = icon("dashboard"),
                                       status = "success"),
                                     notificationItem(
                                       text = "Sever is currently running at 95% load",
                                       icon = icon("warning"),
                                       status = "warning")),
                        dropdownMenu(type = "tasks",
                                     taskItem(
                                     value = 80,
                                     color = "aqua",
                                     "Shiny Dashboard Education"),
                                     taskItem(
                                       value = 55,
                                       color = "red",
                                       "Overall R Education"),
                                     taskItem(
                                       value = 40,
                                       color = "green",
                                       "Data Science Education")
                        )),
        dashboardSidebar(
          sidebarMenu(
            sidebarSearchForm("searchText","buttonSearch","Search"),
          menuItem("Dashboard", 
                   tabName = "dashboard",
                   icon = icon("dashboard")),
            menuSubItem("Dashboard Finance",
                        tabName = "finance"),
            menuSubItem("Dashboard Sales",
                        tabName = "Sales"),
          menuItem("Detailed Analysis", badgeLabel = "New", badgeColor = "green"),
          menuItem("Raw Data")
          
        )),
        dashboardBody(
          tabItems(
            tabItem(tabName = "dashboard",
                    fluidRow(
                      column(width = 12,
                      infoBox("Sales",10000, icon = icon("thumbs-up")),
                      infoBox("Conversion %", paste0('20%'), icon = icon("warning")),
                      infoBoxOutput("approvedSales")
                    )),
                    fluidRow(
                      valueBox(15*200,"Budget for 15 Days", icon = icon("hourglass-3")),
                      valueBoxOutput("itemRequested")
                    ),
                    fluidRow(
                      tabBox(
                      tabPanel(title = "Histogram of Faithful",
                          status = "primary",
                          solidHeader = TRUE,
                          background = "aqua",
                          plotOutput("histogram")),
                      tabPanel(title = "Controls for Dashboard",
                          status = "warning",
                          solidHeader = TRUE,
                          background = "yellow",
                          "Use these controls to fine tune your dashboard",br(),
                          "Do not use lot of control as it confusese the user",
                          sliderInput("bins", "Number of Breaks", 1,100,50),
                          textInput("text_input","Search Opportunities", value = "1234556"))
                      ),
                      tabBox(
                        
                      )
                    )),
            tabItem(tabName = "finance",
                    h1("Finance Dashboard")                                     
                    ),
            tabItem(tabName = "Sales",
                    h1("Sales Dashboard")                                     
            )
          )
        )
)

      

server <- function(input, output){

  output$histogram <- renderPlot({
    hist(faithful$eruptions, breaks = input$bins)
  
  
  # output$msgOutput <- renderMenu({
  #   msgs <- apply(read.csv("messages.csv"), 1,function(row){
  #                   messageItem(from = row[["from"]], message = row[["message"]])
  #                 })
  #   dropdownMenu(type = "messages", .list = msgs)
  # })
  })
  output$approvedSales <- renderInfoBox(
    infoBox("Approval Sales", "10.00.000", icon = icon("bar-chart-o"))
  )
  
  output$itemRequested <- renderValueBox(
    valueBox(15*300, "Item Requested by Employees", icon = icon("fire"),
             color = "yellow")
    
  )
  
  
}

shinyApp(ui = ui, server = server)