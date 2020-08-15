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
  
  tags$h1("Sikermánia")
)

### Dashboard
ui <- dashboardPage(
  skin = "yellow",
  title = "Sikermánia",
  
  header,
  sidebar,
  body
)