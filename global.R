### Load libraries
library(shiny)
library(shinydashboard)
library(tidyverse)
library(googleAuthR)
library(googleAnalyticsR)
library(keyring)
library(scales)
library(lubridate)

### Helper Functions
space <- function(x, ...) {
  format(x, ..., big.mark = " ", scientific = FALSE, trim = TRUE)
}

### Connect to Google Developers
options(googleAuthR.client_id = key_get("CLIENT_ID", keyring = "sikeRmania"))
options(googleAuthR.client_secret = key_get("CLIENT_SECRET", keyring = "sikeRmania"))
options(googleAuthR.scopes.selected = "https://www.googleapis.com/auth/analytics.readonly")
keyring_lock("sikeRmania")
ga_auth()

### Account ID for Sikermánia - Backup View
ga_id <- ga_account_list() %>% 
  filter(
    accountName == "Sikermánia", 
    viewName == "Backup"
  ) %>% 
  select(viewId) %>% 
  pull(1)

### Metadata
# metadata <-  meta

# Pull metrics for users and newUsers
# users: The total number of users for the requested time period.
# newUsers: The number of sessions marked as a user's first sessions.
user_data <- function() {
  google_analytics(
    ga_id,
    metrics = c("users", "newUsers"),
    date_range = c("2019-12-01", "2020-08-15"),
    dimension = "date"
  ) %>% 
    mutate(
      users_cumsum = cumsum(users),
      # new_users_cumsum = cumsum(newUsers),
      month_start_users = ifelse(day(date) == 1, users_cumsum, NA)
    )
}

### Visualizations
# Colors
color_light_yellow <- rgb(252, 242, 206, maxColorValue = 255)
color_dark_yellow <- rgb(245, 194, 23, maxColorValue = 255)
  
# Users and new users
ggplot(data = user_data(), aes(x = date)) +
  geom_area(aes(y = users_cumsum), fill = color_light_yellow) +
  geom_line(aes(y = users_cumsum), color = color_dark_yellow, size = 2) +
  geom_point(aes(y = month_start_users), color = color_dark_yellow, size = 4) +
  # geom_line(aes(y = new_users_cumsum)) +
  scale_x_date(date_labels = "%Y. %B", date_breaks = "1 month") +
  scale_y_continuous(labels = space) +
  labs(title = "0-ról 100 000+ látogatóig") +
  theme(
    plot.title = element_text(size = 24, face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 65, vjust = 0.6),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.background = element_blank(),
    plot.background = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line(color = "gray84"),
    panel.grid.minor.y = element_line(color = "gray84")
  )

