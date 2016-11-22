
context("cookies")

test_that("cookies created, queried, deleted", {

  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  ## This page has some cookies set already
  s$go(server$url("/cookies.html"))
  
  ## Get all cookies
  s$get_all_cookies()

})

test_that("cookies are kept between visits", {

  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  ## This page has no cookies
  s$go(server$url("/check.html"))

  ## Set cookies

  ## close window

  ## new window

  ## get cookies
  
})
