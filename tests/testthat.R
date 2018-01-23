library(testthat)
library(webdriver)

if (Sys.getenv("NOT_CRAN", "") != "" || Sys.getenv("CI", "") != "") {
  if (! requireNamespace("servr", quietly = TRUE)) {
    message("Need the 'servr' package to run the tests")
  }
  if (is.null(webdriver:::find_phantom())) install_phantomjs()
  message("Using phantom.js from", webdriver:::find_phantom(), "\n")

  test_check("webdriver")
}
