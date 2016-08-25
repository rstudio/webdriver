library(testthat)
library(webdriver)

if (Sys.getenv("NOT_CRAN", "") != "") test_check("webdriver")
