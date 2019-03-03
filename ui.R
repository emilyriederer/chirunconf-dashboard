library(shiny)
library(shinythemes)

fluidPage(
  
  tags$head(includeScript("google-analytics.js")),
  titlePanel("#chirunconf"),
  theme = shinytheme("cerulean"),
  
  sidebarLayout(
    
    sidebarPanel(
      actionButton("refresh", "Refresh Dashboards"),
      hr(),
      textOutput("last_updated"),
      textOutput("rate_limit")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Overall", 
                 textOutput("text_overall"),
                 p(),
                 p("We can add more text here or some sort of a 'leader board' of most opened/closed issues by participant/repo?")
                 ),
        tabPanel("broom",   uiOutput("board_broom")), 
        tabPanel("drake",   uiOutput("board_drake")), 
        tabPanel("NLP",     uiOutput("board_NLP")), 
        tabPanel("gt",      uiOutput("board_gt"))
        
      )
    )
  )
)