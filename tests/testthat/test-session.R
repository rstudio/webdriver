
context("Session")

test_that("can create a session", {
  expect_silent(s <- Session$new(port = phantom$port))
  expect_silent(s$delete())
})

test_that("can go to URL", {
  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/check.html"))
  src <- s$getSource()
  expect_match(src, "Hello there")
})

test_that("basic operations", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  ## $go
  s$go(server$url("/check.html"))

  ## $getUrl
  expect_equal(s$getUrl(), server$url("/check.html"))

  ## $goBack
  s$go(server$url("/check2.html"))
  expect_match(s$getSource(), "Hello again")
  s$goBack()
  expect_equal(s$getUrl(), server$url("/check.html"))
  expect_match(s$getSource(), "Hello there")

  ## $goForward
  s$goForward()
  expect_equal(s$getUrl(), server$url("/check2.html"))
  expect_match(s$getSource(), "Hello again")
  s$goBack()

  ## $refresh, TODO: this would need a web app...

  ## $getTitle
  expect_equal(s$getTitle(), "check")

  ## $getSource
  expect_equal(
    gsub("\\s+", "", s$getSource()),
    gsub(
      "\\s+", "",
      paste(readLines(file.path("web", "check.html")), collapse = "\n")
    )
  )
})

test_that("screenshot", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)
  s$go(server$url("/check.html"))

  s$takeScreenshot(file = tmp <- tempfile())
  on.exit(unlink(tmp), add = TRUE)
  expect_true(file.exists(tmp))
  expect_true(file.info(tmp)$size > 0)
})

test_that("find elements", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)
  s$go(server$url("/elements.html"))

  el <- s$findElement(css = ".foo")
  expect_equal(el$getText(), "This is foo!")

  el2 <- s$findElement(linkText = "R project web site")
  expect_equal(el2$getText(), "R project web site")

  el3 <- s$findElement(partialLinkText = "project web")
  expect_equal(el3$getText(), "R project web site")

  el4 <- s$findElement(xpath = "//body/p/a")
  expect_equal(el4$getText(), "R project web site")

  el4$sendKeys("")
  el5 <- s$getActiveElement()
  expect_equal(el5$getText(), "R project web site")

  pars <- s$findElements(css = "form p")
  expect_equal(length(pars), 7)
  expect_true(is(pars[[1]], "Element"))
})

test_that("execute script (sync)", {
  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/elements.html"))

  expect_equal(
    s$executeScript("return 42 + 'foobar';"),
    "42foobar"
  )
  expect_null(
    s$executeScript("1 + 1;")
  )
  expect_equal(
    s$executeScript("return arguments[0] + arguments[1]", 42, 24),
    66
  )
  expect_error(
    s$executeScript("syntax error"),
    "Expected an identifier but found 'error' instead"
  )
})

test_that("execute script (async)", {
  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/elements.html"))

  expect_equal(
    s$executeScriptAsync("arguments[arguments.length - 1](42);"),
    42
  )
})

test_that("execute script with element arguments", {
  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/elements.html"))

  el <- s$findElement(".foo")

  expect_equal(
    s$executeScript("return arguments[0].className;", el),
    "foo bar"
  )
  expect_equal(
    s$executeScript("return arguments[0].className;", el, 42),
    "foo bar"
  )
  expect_equal(
    s$executeScript("return arguments[1].className;", 42, el),
    "foo bar"
  )
})

test_that("execute script and return elements", {
  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/elements.html"))
  el <- s$findElement(".foo")

  ## Single element
  ret <- s$executeScript("return arguments[0];", el)
  expect_true(inherits(ret, "Element"))

  ## List of elements
  ret <- s$executeScript("return arguments;", el, el, el)
  expect_true(is.list(ret))
  expect_equal(length(ret), 3)
  expect_true(inherits(ret[[1]], "Element"))
  expect_true(inherits(ret[[2]], "Element"))
  expect_true(inherits(ret[[3]], "Element"))

  ## List of elements and other stuff
  ret <- s$executeScript("return arguments;", el, 42, el, 42 * 42)
  expect_true(is.list(ret))
  expect_equal(length(ret), 4)
  expect_true(inherits(ret[[1]], "Element"))
  expect_equal(ret[[2]], 42)
  expect_true(inherits(ret[[3]], "Element"))
  expect_equal(ret[[4]], 42 * 42)
})

test_that("move mouse cursor", {
  ## TODO: we need Session$click to test this
})

test_that("mouse clicks", {
  ## TODO
})

test_that("logs", {
  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/elements.html"))

  s$executeScript("console.log('Just a start');")
  s$executeScript("console.log('Hello world!');")
  expect_equal(nrow(s$readLog()), 2)
  s$executeScript("console.log('Hello again!');")
  s$executeScript(paste0(
    "console.log('A very long message, just to see how it will be ",
    "printed to the screen in R');"))
  log <- s$readLog()
  expect_equal(nrow(log), 2)
  expect_true(is.data.frame(log))
  expect_match(log$message[1], "Hello again")
  expect_equal(names(log), c("timestamp", "level", "message"))
})
