# please execute install.packages("googlesheets4") and 
# install.packages("dplyr") before running this script
# also run gs4_auth() and provide requested credentials

library(googlesheets4)
library(dplyr)

report <- function(
  cache = makeReportCache(),
  from = Sys.Date(),
  to = Sys.Date(),
  sourceurl = "https://docs.google.com/spreadsheets/d/1Ycg7zTxds9DZnDvTrFcyNNKuTUxg6Yy6WF0a8Wc02WQ", 
  outputname = "report") {
  
  # check if date interval is correct
  interval <- to - from;
  if (interval < 0) {
    stop('invalid date interval')
  }
  # create actual date and time interval
  fromDateTime <- as.POSIXct(paste(format(from, "%Y-%m-%d"), "00:00:00" ), format="%Y-%m-%d %H:%M:%S")
  toDateTime <- as.POSIXct(paste(format(to, "%Y-%m-%d"), "23:59:59" ), format="%Y-%m-%d %H:%M:%S")
  
  transactions <- cache$getTransactions()
  if(is.null(transactions)) {
    transactions <- read_sheet(
      sourceurl, 
      sheet = "transactions", 
      col_types = "cTic"
    )
    cache$setTransactions(transactions)
  }

  clients <- cache$getClients()
  if(is.null(clients)) {
    clients <- read_sheet(
     sourceurl, 
     sheet ="clients",
     col_types = "cTc"
    )
    cache$setClients(clients)
  }

  managers <- cache$getManagers()
  if(is.null(managers)) {
    managers <- read_sheet(
     sourceurl, 
     sheet ="managers",
     col_types = "ccc"
    )
    managers[["d_manager"]] <- as.factor(managers[["d_manager"]])
    managers[["d_club"]] <- as.factor(managers[["d_club"]])
    cache$setManagers(managers)
  }

  leads <- cache$getLeads()
  if(is.null(leads)) {
    leads <- read_sheet(
     sourceurl, 
     sheet ="leads",
     col_types = "cTcccc"
    )
    leads[["d_utm_source"]] <- as.factor(leads[["d_utm_source"]])
    cache$setLeads(leads)
  }
  
  manager_leads <- merge(x = managers, y = leads, by.x = "manager_id", by.y = "l_manager_id", all.x = TRUE)
  manager_leads_interval <- filter(manager_leads, created_at <= toDateTime, created_at >= fromDateTime)
  result <- 
    manager_leads_interval %>% 
    group_by(d_utm_source, d_manager, d_club) %>% 
    summarise(lead_count = n())
  
  result

  # TODO
  # ss <- gs4_create(outputname, sheets = result)
  # ss
  
}

