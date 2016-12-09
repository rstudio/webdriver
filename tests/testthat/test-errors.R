
context("errors")

test_that("no window", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  ## Close the window
  s$get_window()$close()

  expect_error(s$go("http://r-hub.io"), "Window handle/name is invalid")
  expect_error(s$getUrl(), "Window handle/name is invalid")
  expect_error(s$go_back(), "Window handle/name is invalid")
  expect_error(s$go_forward(), "Window handle/name is invalid")
  expect_error(s$refresh(), "Window handle/name is invalid")
  expect_error(s$get_title(), "Window handle/name is invalid")
  expect_error(s$get_source(), "Window handle/name is invalid")
  expect_error(s$take_screenshot(), "Window handle/name is invalid")

  ## This one does not give a proper error message
  expect_error(s$find_element(css = "<p>"), "WebDriver error")
})

test_that("no window", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$get_window()$close()

  expect_error(s$get_window(), "Current window handle invalid")
})

test_that("no elements", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  expect_error(s$find_element(css = "foobar"), "Unable to find element")
})

test_that("is_selected for non-selectable elements", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/check.html"))
  el <- s$find_element(css = "p")

  expect_error(el$is_selected(), "Element is not selectable")
})
