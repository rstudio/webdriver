library(testthat)
library(webdriver)

if (Sys.getenv("NOT_CRAN", "") != "" ||
    Sys.getenv("CI", "") != "") {
  if (is.null(webdriver:::find_phantom())) install_phantomjs()
  test_check("webdriver")
}
