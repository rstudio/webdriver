
context("errors")

test_that("no window", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  ## Close the window
  s$getWindow()$close()

  expect_error(s$go("http://r-hub.io"), "Window handle/name is invalid")
  expect_error(s$getUrl(), "Window handle/name is invalid")
  expect_error(s$goBack(), "Window handle/name is invalid")
  expect_error(s$goForward(), "Window handle/name is invalid")
  expect_error(s$refresh(), "Window handle/name is invalid")
  expect_error(s$getTitle(), "Window handle/name is invalid")
  expect_error(s$getSource(), "Window handle/name is invalid")
  expect_error(s$takeScreenshot(), "Window handle/name is invalid")

  ## This one does not give a proper error message
  expect_error(s$findElement(css = "<p>"), "WebDriver error")
})

test_that("no window", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$getWindow()$close()

  expect_error(s$getWindow(), "Current window handle invalid")
})

test_that("no elements", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  expect_error(s$findElement(css = "foobar"), "Unable to find element")
})

test_that("isSelected for non-selectable elements", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/check.html"))
  el <- s$findElement(css = "p")

  expect_error(el$isSelected(), "Element is not selectable")
})
