
context("element")

server <- start_web_server("web")
on.exit(stop_web_server(server), add = TRUE)

phantom <- start_phantomjs()
on.exit(stop_phantomjs(phantom), add = TRUE)

test_that("element methods are OK", {

  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)
  s$go(server$url("/elements.html"))

  ## TODO: is_selected

  el <- s$find_element(css = ".foo")
  expect_equal(el$get_attribute("class"), "foo bar")
  expect_equal(el$get_class(), c("foo", "bar"))
  expect_null(el$get_attribute("xxx"))

  expect_equal(el$get_css_value("color"), "rgba(255, 0, 0, 1)")

  expect_equal(el$get_text(), "This is foo!")

  expect_equal(el$get_name(), "p")

  sel <- s$find_element(css = "form select")
  expect_true(sel$is_enabled())
  sel2 <- s$find_element(css = ".disabledselect")
  expect_false(sel2$is_enabled())

  el <- s$find_element(css = ".clickme a")
  el$click()
  expect_equal(s$get_url(), server$url("/check.html"))
  s$go_back()

  el <- s$find_element(css = "#firstname")
  el$send_keys("Gabor")
  expect_equal(el$get_attribute("value"), "Gabor")
  expect_equal(el$get_value(), "Gabor")
  el$clear()
  expect_equal(el$get_attribute("value"), "")
  expect_equal(el$get_value(), "")

  el$set_value("Not Gabor")
  expect_equal(el$get_value(), "Not Gabor")
  el$clear()

  form <- s$find_element(css = "form")
  pars <- form$find_elements(css = "p")
  expect_equal(length(pars), 7)
  expect_true(is(pars[[1]], "element"))

  fn <- s$find_element("#firstname")
  expect_equal(fn$get_data("foo"), "bar")
})

test_that("move mouse cursor", {
  ## TODO: we need session$click to test this
})

test_that("element rect", {
  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)
  s$go(server$url("/elements.html"))

  el <- s$find_element(css = ".foo")
  rect <- el$get_rect()
  expect_equal(names(rect), c("x", "y", "width", "height"))
})
