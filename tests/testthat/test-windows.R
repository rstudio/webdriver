
context("Windows")

test_that("Window methods are OK", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  w1 <- s$getWindow()
  expect_true(w1$isActive())

  ## Click opens another window
  s$go(server$url("/window1.html"))
  s$findElement("a")$click()

  ## Switch to the new window
  allw <- s$getAllWindows()
  if (allw[[1]]$isActive()) allw[[2]]$switchTo() else allw[[1]]$switchTo()
  w2 <- s$getWindow()
  expect_false(w1$isActive())
  expect_true(w2$isActive())

  expect_equal(s$getUrl(), server$url("/window2.html"))

  w2$close()
  expect_equal(length(s$getAllWindows()), 1)

  w1$switchTo()
  expect_equal(s$getUrl(), server$url("/window1.html"))

  w1$setSize(800, 600)
  expect_equal(w1$getSize(), list(width = 800, height = 600))

  expect_equal(w1$getPosition(), list(x = 0, y= 0))

  w1$maximize()
  expect_equal(w1$getSize(), list(width = 1366, height = 768))

  w2$close()
  expect_equal(length(s$getAllWindows()), 0)
})
