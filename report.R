# please execute install.packages("googlesheets4") and 
# library(googlesheets4) before running this script

url <- "https://docs.google.com/spreadsheets/d/1Ycg7zTxds9DZnDvTrFcyNNKuTUxg6Yy6WF0a8Wc02WQ"

transactions <- read_sheet(
  url, 
  sheet = "transactions", 
  col_types = "cTic"
)
str(transactions)

clients <- read_sheet(
  url, 
  sheet ="clients",
  col_types = "cTc"
)
str(clients)

managers <- read_sheet(
  url, 
  sheet ="managers",
  col_types = "ccc"
)
str(managers)

leads <- read_sheet(
  url, 
  sheet ="leads",
  col_types = "cTcccc"
)
str(leads)