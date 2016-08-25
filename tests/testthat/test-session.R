
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
