
# api.R
library(plumber)

#* @apiTitle file analysis API

#* Cross-domain support (allowing GitHub web pages to access)
#* @filter cors
cors <- function(req, res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  if (req$REQUEST_METHOD == "OPTIONS") {
    res$setHeader("Access-Control-Allow-Methods", "POST, OPTIONS")
    res$setHeader("Access-Control-Allow-Headers", req$HTTP_ACCESS_CONTROL_REQUEST_HEADERS)
    return(res)
  } else {
    plumber::forward()
  }
}

#* Upload and analyze CSV files
#* @param file:file Uploaded file
#* @post /analyze
function(file) {
  df <- read.csv(file$datapath)
  summary_str <- capture.output(summary(df))
  paste(summary_str, collapse = "\n")
}