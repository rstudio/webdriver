library(testthat)
library(webdriver)

if (Sys.getenv("NOT_CRAN", "") != "" ||
    Sys.getenv("CI", "") != "") {
  if (is.null(webdriver:::find_phantom())) install_phantomjs()
  cat("Using phantom.js from", webdriver:::find_phantom(), "\n")
  test_check("webdriver")
}
