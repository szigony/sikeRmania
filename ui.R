### Header
header <- dashboardHeader(
  title = "Sikermánia"
)

### Sidebar
sidebar <- dashboardSidebar(
  
)

### Body
body <- dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  
  fluidRow(
    column(10, offset = 1,
      plotlyOutput("all_time_users", height = "100%")
    )
  ),
  
  useShinyjs()
)

### Dashboard
ui <- dashboardPage(
  skin = "yellow",
  title = "Sikermánia",
  
  header,
  sidebar,
  body
)