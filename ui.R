library(shiny)
library(shinythemes)
library(ggplot2)
library(DT)

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
                 strong(textOutput("text_overall")),
                 plotOutput("closed_overall"),
                 strong("Here's everything we've tackled so far!"),
                 DTOutput('tbl_overall')
                 ),
        tabPanel("drake",     uiOutput("board_drake")), 
        tabPanel("broom",     uiOutput("board_broom")), 
        tabPanel("workflowr", uiOutput("board_workflowr")),
        tabPanel("NLP",       uiOutput("board_NLP")), 
        tabPanel("gt",        uiOutput("board_gt"))
        
      )
    )
  )
)