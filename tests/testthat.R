library(testthat)
library(webdriver)

if (Sys.getenv("NOT_CRAN", "") != "" ||
    Sys.getenv("CI", "") != "") {
  test_check("webdriver")
}
