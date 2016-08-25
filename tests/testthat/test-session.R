
context("session")

server <- start_web_server("web")
on.exit(stop_web_server(server), add = TRUE)

phantom <- start_phantomjs()
on.exit(stop_phantomjs(phantom), add = TRUE)

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
  expect_equal(
    gsub("\\s+", "", s$get_source()),
    gsub(
      "\\s+", "",
      paste(readLines(file.path("web", "check.html")), collapse = "\n")
    )
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

  el4 <- s$find_element(xpath = "//body/p")
  expect_equal(el4$get_text(), "This is foo!")

  ## TODO: find_elements is not implemented yet
})
