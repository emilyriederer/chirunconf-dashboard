library(shiny)
library(projmgr)

# register repositories
Sys.setenv("GITHUB_PAT" = "2f6242ea6590c98d67b2d9e134c756e588dcee11")
Sys.setenv(TZ="America/Chicago")
drake <- create_repo_ref('ropensci', 'drake')
broom <- create_repo_ref('tidymodels', 'broom')

function(input, output){

  v <- reactiveValues(
    data_drake = NULL,
    data_broom = NULL,
    last_updated = NULL,
    rate_limit = NULL
    )

  observeEvent(input$refresh, {
    v$data_drake <- parse_issues(get_issues(drake, state = "all", labels = "Chicago R Unconference"))
    v$data_broom <- parse_issues(get_issues(broom, state = "all", labels = "beginner-friendly"))
    v$last_updated <- Sys.time()
    v$rate_limit <- capture.output(check_rate_limit(drake))
  })
  
  output$text_overall <- renderText({
    if(is.null(v$data_drake) | is.null(v$data_broom)) return()
    data <- rbind(v$data_drake, v$data_broom)
    paste("So far, we've closed", sum(data$state == "closed", na.rm = TRUE), "issues!")
  })

  output$board_drake <- renderUI({
    if (is.null(v$data_drake)) return()
    html <- report_taskboard(v$data_drake, in_progress_when = is_assigned(), hover = TRUE, include_link = TRUE)
    class(html) <- "character"
    HTML(html)
  })

  output$board_broom <- renderUI({
    if (is.null(v$data_broom)) return()
    html <- report_taskboard(v$data_broom, in_progress_when = is_assigned(), hover = TRUE, include_link = TRUE)
    class(html) <- "character"
    HTML(html)
  })

  output$last_updated <- renderText({
    if (is.null(v$last_updated)) return()
    paste("Last updated: ", v$last_updated)
    })
  
  output$rate_limit <- renderText({
    if (is.null(v$rate_limit)) return()
    paste("API Hits Remaining: ", v$rate_limit)
  })

}