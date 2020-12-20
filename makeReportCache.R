makeReportCache <- function() {
  t <- NULL
  c <- NULL
  m <- NULL
  l <- NULL
  # internal functions
  setTransactions <- function(value) { t <<- value }
  getTransactions <- function() { t }
  setClients <- function(value) { c <<- value }
  getClients <- function() { c } 
  setManagers <- function(value) { m <<- value }
  getManagers <- function() { m } 
  setLeads <- function(value) { l <<- value }
  getLeads <- function() { l } 
  # public function list
  list(setTransactions = setTransactions, 
       getTransactions = getTransactions,
       setClients = setClients, 
       getClients = getClients,
       setManagers = setManagers, 
       getManagers = getManagers,
       setLeads = setLeads, 
       getLeads = getLeads
  )
}