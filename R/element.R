
#' @importFrom R6 R6Class

element <- R6Class(
  "element",
  public = list(

    initialize = function(id, session, session_private)
      element_initialize(self, private, id, session, session_private),

    find_element = function(css = NULL, link_text = NULL,
      partial_link_text = NULL, xpath = NULL)
      element_find_element(self, private, css, link_text,
                           partial_link_text, xpath),

    find_elements = function(css = NULL, link_text = NULL,
      partial_link_text = NULL, xpath = NULL)
      element_find_elements(self, private, css, link_text,
                            partial_link_text, xpath),

    is_selected = function()
      element_is_selected(self, private),

    get_attribute = function(name)
      element_get_attribute(self, private, name),

    get_property = function(name)
      element_get_property(self, private, name),

    get_css_value = function(name)
      element_get_css_value(self, private, name),

    get_text = function()
      element_get_text(self, private),

    get_name = function()
      element_get_name(self, private),

    get_rect = function()
      element_get_rect(self, private),

    is_enabled = function()
      element_id_enabled(self, private),

    click = function()
      element_click(self, private),

    clear = function()
      element_clear(self, private),

    send_keys = function(keys)
      element_send_keys(self, private),

    take_screenshot = function(file = NULL)
      element_take_screenshot(self, private, file)
  ),

  private = list(
    id = NULL,
    session = NULL,
    session_private = NULL
  )
)


element_initialize <- function(self, private, id, session,
                               session_private) {

  assert_string(id)
  assert_session(session)

  private$id <- id
  private$session <- session
  private$session_private <- session_private

  invisible(self)
}


element_find_element <- function(self, private, css, link_text,
                                 partial_link_text, xpath) {

  find_expr <- parse_find_expr(css, link_text, partial_link_text, xpath)

  response <- private$session_private$make_request(
    "FIND ELEMENT FROM ELEMENT",
    list(
      using = unbox(find_expr$using),
      value = unbox(find_expr$value)
    ),
    list(element_id = private$id)
  )

  element$new(
    id = response$value$ELEMENT,
    session = private$session,
    session_private = private$session_private
  )
}


element_find_elements <- function(self, private, css, link_text,
                                  partial_link_text, xpath) {
  ## TODO
}


element_is_selected <- function(self, private) {

  response <- private$session_private$make_request(
    "IS ELEMENT SELECTED",
    params = list(element_id = private$id)
  )

  response$value
}


element_get_attribute <- function(self, private, name) {

  assert_string(name)

  response <- private$session_private$make_request(
    "GET ELEMENT ATTRIBUTE",
    params = list(element_id = private$id, name = name)
  )

  response$value
}


element_get_property <- function(self, private, name) {

  assert_string(name)

  response <- private$session_private$make_request(
    "GET ELEMENT PROPERTY",
    params = list(element_id = private$id, name = name)
  )

  response$value
}


element_get_css_value <- function(self, private, name) {

  assert_string(name)

  response <- private$session_private$make_request(
    "GET ELEMENT CSS VALUE",
    params = list(element_id = private$id, name = name)
  )

  response$value
}


element_get_text <- function(self, private) {

  response <- private$session_private$make_request(
    "GET ELEMENT TEXT",
    params = list(element_id = private$id)
  )

  response$value
}


element_get_name <- function(self, private) {

  response <- private$session_private$make_request(
    "GET ELEMENT TAG NAME",
    params = list(element_id = private$id)
  )

  response$value
}


element_get_rect <- function(self, private) {

  response <- private$session_private$make_request(
    "GET ELEMENT RECT",
    params = list(element_id = private$id)
  )

  response$value
}


element_id_enabled <- function(self, private) {

  response <- private$session_private$make_request(
    "IS ELEMENT ENABLED",
    params = list(element_id = private$id)
  )

  response$value
}


element_click <- function(self, private) {

  response <- private$session_private$make_request(
    "ELEMENT CLICK",
    params = list(element_id = private$id)
  )

  invisible(private$session)
}


element_clear <- function(self, private) {

  response <- private$session_private$make_request(
    "ELEMENT CLEAR",
    params = list(element_id = private$id)
  )

  invisible(self)
}


element_send_keys <- function(self, private, keys) {

  response <- private$session_private$make_request(
    "ELEMENT SEND KEYS",
    params = list(element_id = private$id)
  )

  invisible(self)
}


## TODO: seems to return full screenshot?

element_take_screenshot <- function(self, private, file) {

  if (!is.null(file)) assert_filename(file)

  response <- private$session_private$make_request(
    "TAKE ELEMENT SCREENSHOT",
    params = list(element_id = private$id)
  )

  handle_screenshot(response, file)

  invisible(self)
}
