
context("errors")

test_that("no window", {

  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  ## Close the window
  s$get_window()$close()

  expect_error(s$go("http://r-hub.io"))
  expect_error(s$get_url())
  expect_error(s$go_back())
  expect_error(s$go_forward())
  expect_error(s$refresh())
  expect_error(s$get_title())
  expect_error(s$get_source())
  expect_error(s$take_screenshot())
  expect_error(s$find_element(css = "<p>"))
})

test_that("no window", {

  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$get_window()$close()

  expect_error(s$get_window())
})

test_that("no elements", {

  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  expect_error(s$find_element(css = "foobar"))
})

test_that("is_selected for non-selectable elements", {

  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/check.html"))
  el <- s$find_element(css = "p")

  ## This is a bug in chromedriver
  if (driver_type != "chromedriver") {
    expect_error(el$is_selected(), "Element is not selectable")
  }
})
