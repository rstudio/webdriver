
context("Element")

test_that("Element methods are OK", {

  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)
  s$go(server$url("/elements.html"))

  ## TODO: isSelected

  el <- s$findElement(css = ".foo")
  expect_equal(el$getAttribute("class"), "foo bar")
  expect_equal(el$getClass(), c("foo", "bar"))
  expect_null(el$getAttribute("xxx"))

  expect_equal(el$getCssValue("color"), "rgba(255, 0, 0, 1)")

  expect_equal(el$getText(), "This is foo!")

  expect_equal(el$getName(), "p")

  sel <- s$findElement(css = "form select")
  expect_true(sel$isEnabled())
  sel2 <- s$findElement(css = ".disabledselect")
  expect_false(sel2$isEnabled())

  el <- s$findElement(css = ".clickme a")
  el$click()
  expect_equal(s$getUrl(), server$url("/check.html"))
  s$goBack()

  el <- s$findElement(css = "#firstname")
  el$sendKeys("Gabor")
  expect_equal(el$getAttribute("value"), "Gabor")
  expect_equal(el$getValue(), "Gabor")
  el$clear()
  expect_equal(el$getAttribute("value"), "")
  expect_equal(el$getValue(), "")

  el$setValue("Not Gabor")
  expect_equal(el$getValue(), "Not Gabor")
  el$clear()

  form <- s$findElement(css = "form")
  pars <- form$findElements(css = "p")
  expect_equal(length(pars), 7)
  expect_true(is(pars[[1]], "Element"))

  fn <- s$findElement("#firstname")
  expect_equal(fn$getData("foo"), "bar")
})

test_that("move mouse cursor", {
  ## TODO: we need Session$click to test this
})

test_that("element rect", {
  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)
  s$go(server$url("/elements.html"))

  el <- s$findElement(css = ".foo")
  rect <- el$getRect()
  expect_equal(names(rect), c("x", "y", "width", "height"))
})

test_that("sending special keys", {
  s <- Session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)
  s$go(server$url("/elements.html"))

  textarea <- s$findElement("textarea")
  textarea$sendKeys(key$control, "a")  # select everything
  textarea$sendKeys(key$delete)        # delete
  textarea$sendKeys("line1", key$enter, "line2", key$enter)
  expect_equal(
    textarea$getValue(),
    "line1\nline2\n"
  )
})
