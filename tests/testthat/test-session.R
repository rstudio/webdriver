
context("session")

test_that("can create a session", {
  expect_silent(s <- session$new(port = phantom$port))
  expect_silent(s$delete())
})

test_that("can go to URL", {
  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/check.html"))
  src <- s$get_source()
  expect_match(src, "Hello there")
})

test_that("basic operations", {

  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  ## $go
  s$go(server$url("/check.html"))

  ## $get_url
  expect_equal(s$get_url(), server$url("/check.html"))

  ## $go_back
  s$go(server$url("/check2.html"))
  expect_match(s$get_source(), "Hello again")
  s$go_back()
  expect_equal(s$get_url(), server$url("/check.html"))
  expect_match(s$get_source(), "Hello there")

  ## $go_forward
  s$go_forward()
  expect_equal(s$get_url(), server$url("/check2.html"))
  expect_match(s$get_source(), "Hello again")
  s$go_back()

  ## $refresh, TODO: this would need a web app...

  ## $get_title
  expect_equal(s$get_title(), "check")

  ## $get_source
  src <- paste(
    readLines(file.path("web", "check.html"))[-(1:2)],
    collapse = "\n"
  )
  expect_match(
    gsub("\\s+", "", s$get_source()),
    gsub("\\s+", "", src)
  )
})

test_that("screenshot", {

  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)
  s$go(server$url("/check.html"))

  s$take_screenshot(file = tmp <- tempfile())
  on.exit(unlink(tmp), add = TRUE)
  expect_true(file.exists(tmp))
  expect_true(file.info(tmp)$size > 0)
})

test_that("find elements", {

  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)
  s$go(server$url("/elements.html"))

  el <- s$find_element(css = ".foo")
  expect_equal(el$get_text(), "This is foo!")

  el2 <- s$find_element(link_text = "R project web site")
  expect_equal(el2$get_text(), "R project web site")

  el3 <- s$find_element(partial_link_text = "project web")
  expect_equal(el3$get_text(), "R project web site")

  el4 <- s$find_element(xpath = "//body/p/a")
  expect_equal(el4$get_text(), "R project web site")

  el4$send_keys("")
  el5 <- s$get_active_element()
  expect_equal(el5$get_text(), "R project web site")

  pars <- s$find_elements(css = "form p")
  expect_equal(length(pars), 7)
  expect_true(is(pars[[1]], "element"))
})

test_that("execute script (sync)", {
  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/elements.html"))

  expect_equal(
    s$execute_script("return 42 + 'foobar';"),
    "42foobar"
  )
  expect_null(
    s$execute_script("1 + 1;")
  )
  expect_equal(
    s$execute_script("return arguments[0] + arguments[1]", 42, 24),
    66
  )
  expect_error(s$execute_script("syntax error"))
})

test_that("execute script (async)", {
  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/elements.html"))

  expect_equal(
    s$execute_script_async("arguments[arguments.length - 1](42);"),
    42
  )
})

test_that("execute script with element arguments", {
  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/elements.html"))

  el <- s$find_element(".foo")

  expect_equal(
    s$execute_script("return arguments[0].className;", el),
    "foo bar"
  )
  expect_equal(
    s$execute_script("return arguments[0].className;", el, 42),
    "foo bar"
  )
  expect_equal(
    s$execute_script("return arguments[1].className;", 42, el),
    "foo bar"
  )
})

test_that("execute script and return elements", {
  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/elements.html"))
  el <- s$find_element(".foo")

  ## Single element
  ret <- s$execute_script("return arguments[0];", el)
  expect_true(inherits(ret, "element"))

  ## List of elements
  ret <- s$execute_script("return arguments;", el, el, el)
  expect_true(is.list(ret))
  expect_equal(length(ret), 3)
  expect_true(inherits(ret[[1]], "element"))
  expect_true(inherits(ret[[2]], "element"))
  expect_true(inherits(ret[[3]], "element"))

  ## List of elements and other stuff
  ret <- s$execute_script("return arguments;", el, 42, el, 42 * 42)
  expect_true(is.list(ret))
  expect_equal(length(ret), 4)
  expect_true(inherits(ret[[1]], "element"))
  expect_equal(ret[[2]], 42)
  expect_true(inherits(ret[[3]], "element"))
  expect_equal(ret[[4]], 42 * 42)
})

test_that("move mouse cursor", {
  ## TODO: we need session$click to test this
})

test_that("mouse clicks", {
  ## TODO
})

test_that("logs", {
  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  s$go(server$url("/elements.html"))

  ## Read out the logs first, chromedriver gives error for missing
  ## favicon.ico
  s$read_log()

  s$execute_script("console.error('Just a start');")
  s$execute_script("console.error('Hello world!');")
  expect_equal(nrow(s$read_log()), 2)
  s$execute_script("console.error('Hello again!');")
  s$execute_script(paste0(
    "console.error('A very long message, just to see how it will be ",
    "printed to the screen in R');"))
  log <- s$read_log()
  expect_equal(nrow(log), 2)
  expect_true(is.data.frame(log))
  expect_match(log$message[1], "Hello again")
  expect_equal(names(log), c("timestamp", "level", "message"))
})


test_that("can pass additional parameters", {
  user_agent_string <- "my_user_agent"
  ap <- list(phantomjs.page.settings.userAgent = unbox("my_user_agent"))
  s <- session$new(port = phantom$port, additional_parameters = ap)
  on.exit(s$delete(), add = TRUE)
  uastr <- "phantomjs.page.settings.userAgent"
  expect_identical(s$.__enclos_env__$private$parameters[[uastr]],
                   user_agent_string)
  
})

test_that("passing non list additonal paramters throws exception", {
  expect_error(
    s <- session$new(port = phantom$port,
                     additional_parameters = "some string")
  )
  
})