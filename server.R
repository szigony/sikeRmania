### Server
server <- function(input, output) {
  
  ### Hide sidebar by default
  addClass(selector = "body", class = "sidebar-collapse")
  
  ### Visualizations
  # All time users
  output$all_time_users <- renderPlotly({
    ggplotly(
      all_time_users(user_data()),
      tooltip = c("text")
    ) %>% 
      layout(
        hoverlabel = list(bgcolor = "white")
      )
  })
  
}