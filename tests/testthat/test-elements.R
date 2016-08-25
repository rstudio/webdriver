
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
  expect_equal(el$get_attribute("class"), "foo")

  ## TODO: get_property does not work

  expect_equal(el$get_css_value("color"), "rgba(255, 0, 0, 1)")

  expect_equal(el$get_text(), "This is foo!")

  expect_equal(el$get_name(), "p")

  ## TODO: get_rect does not work

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
  el$clear()
  expect_equal(el$get_attribute("value"), "")

  ## TODO: take_screenshot takes screenshot of whole screen
})
