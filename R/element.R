
#' HTML element
#'
#' @section Usage:
#' \preformatted{e <- s$find_element(css = NULL, link_text = NULL,
#'     partial_link_text = NULL, xpath = NULL)
#'
#' e$find_element(css = NULL, link_text = NULL,
#'     partial_link_text = NULL, xpath = NULL)
#' e$find_elements(css = NULL, link_text = NULL,
#'     partial_link_text = NULL, xpath = NULL)
#'
#' e$is_selected()
#' e$get_attribute(name)
#' e$get_property(name)
#' e$get_css_value(name)
#' e$get_text()
#' e$get_name()
#' e$get_rect()
#' e$is_enabled()
#' e$click()
#' e$clear()
#' e$send_keys(keys)
#' }
#'
#' @section Arguments:
#' \describe{
#'   \item{e}{An \code{element} object.}
#'   \item{s}{A \code{\link{session}} object.}
#'   \item{css}{Css selector to find an HTML element.}
#'   \item{link_text}{Find HTML elements based on their \code{innerText}.}
#'   \item{partial_link_text}{Find HTML elements based on their
#'     \code{innerText}. It uses partial matching.}
#'   \item{xpath}{Find HTML elements using XPath expressions.}
#'   \item{name}{String scalar, named of attribute, property or css key.}
#'   \item{keys}{Character vector of keys to send.}
#' }
#'
#' @section Details:
#'
#' To create \code{element} objects, you need to use the \code{find_element}
#' (or \code{find_element}) method of a \code{\link{session}} object.
#'
#' \code{e$find_element()} finds the \emph{next} HTML element from the
#' current one. You need to specify one of the \code{css}, \code{link_text},
#' \code{partial_link_text} and \code{xpath} arguments. It returns a new
#' \code{element} object.
#'
#' \code{e$find_elements()} finds all matching HTML elements starting from
#' the current element. You need to specify one of the \code{css},
#' \code{link_text}, \code{partial_link_text} and \code{xpath} arguments.
#' It returns a list of newly created \code{element} objects.
#'
#' \code{e$is_selected()} returns \code{TRUE} is the element is currently
#' selected, and \code{FALSE} otherwise.
#'
#' \code{$get_attribute()} queries an arbitrary HTML attribute.
#'
#' \code{$get_property()} queries an HTML property.
#'
#' \code{$get_css_value()} queries a CSS property of an element.
#'
#' \code{$get_text()} returns the \code{innerText} on an element.
#'
#' \code{$get_name()} returns the tag name of an element.
#'
#' \code{$get_rect()} returns the \sQuote{rectangle} of an element. It is
#' named list with components \code{x}, \code{y}, \code{height} and
#' \code{width}.
#'
#' \code{$is_enabled()} returns \code{TRUE} if the element is enabled,
#' \code{FALSE} otherwise.
#'
#' \code{$click()} scrolls the element into view, and clicks the
#' in-view centre point of it.
#'
#' \code{$clear()} scrolls the element into view, and then attempts to
#' clear its value, checkedness or text content.
#'
#' \code{$send_keys()} scrolls the form control element into view, and
#' sends the provided keys to it.
#'
#' @name element
#' @importFrom R6 R6Class
NULL

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
      element_send_keys(self, private, keys),

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
    list(value = keys),
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
