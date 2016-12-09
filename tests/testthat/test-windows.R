
context("windows")

test_that("window methods are OK", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  w1 <- s$getWindow()
  expect_true(w1$is_active())

  ## Click opens another window
  s$go(server$url("/window1.html"))
  s$findElement("a")$click()

  ## Switch to the new window
  allw <- s$get_all_windows()
  if (allw[[1]]$is_active()) allw[[2]]$switch_to() else allw[[1]]$switch_to()
  w2 <- s$getWindow()
  expect_false(w1$is_active())
  expect_true(w2$is_active())

  expect_equal(s$getUrl(), server$url("/window2.html"))

  w2$close()
  expect_equal(length(s$get_all_windows()), 1)

  w1$switch_to()
  expect_equal(s$getUrl(), server$url("/window1.html"))

  w1$set_size(800, 600)
  expect_equal(w1$get_size(), list(width = 800, height = 600))

  expect_equal(w1$get_position(), list(x = 0, y= 0))

  w1$maximize()
  expect_equal(w1$get_size(), list(width = 1366, height = 768))

  w2$close()
  expect_equal(length(s$get_all_windows()), 0)
})
