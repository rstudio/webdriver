
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
#' e$get_value()
#' e$set_value(value)
#' e$get_attribute(name)
#' e$get_class()
#' e$get_css_value(name)
#' e$get_text()
#' e$get_name()
#' e$get_data(name)
#' e$get_rect()
#' e$is_enabled()
#' e$click()
#' e$clear()
#' e$send_keys(...)
#' e$move_mouse_to(xoffset = NULL, yoffset = NULL)
#'
#' e$execute_script(script, ...)
#' e$execute_script_async(script, ...)
#' }
#'
#' @section Arguments:
#' \describe{
#'   \item{e}{An \code{element} object.}
#'   \item{s}{A \code{\link{session}} object.}
#'   \item{css}{Css selector to find an HTML element.}
#'   \item{link_text}{Find \code{<a>} HTML elements based on their
#'     \code{innerText}.}
#'   \item{partial_link_text}{Find \code{<a>} HTML elements based on their
#'     \code{innerText}. It uses partial matching.}
#'   \item{xpath}{Find HTML elements using XPath expressions.}
#'   \item{name}{String scalar, named of attribute, property or css key.
#'     For \code{get_data}, the key of the data attribute.}
#'   \item{xoffset}{Horizontal offset for mouse movement, relative to the
#'     position of the element. If at least of of \code{xoffset} and
#'     \code{yoffset} is \code{NULL}, then they are ignored.}
#'   \item{yoffset}{Vertical offset for mouse movement, relative to the
#'     position of the element. If at least of of \code{xoffset} and
#'     \code{yoffset} is \code{NULL}, then they are ignored.}
#'   \item{value}{Value to set, a character string.}
#'   \item{...}{For \code{send_keys} the keys to send, see
#'     \code{\link{key}}. For \code{execute_script} and
#'     \code{execute_script_async} argument to supply to the script.}
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
#' \code{e$get_value()} returns the value of an input element, it is a
#' shorthand for \code{e$get_attribute("value")}.
#'
#' \code{e$set_value()} sets the value of an input element, it is
#' essentially equivalent to sending keys via \code{e$send_keys()}.
#'
#' \code{e$get_attribute()} queries an arbitrary HTML attribute. It is
#' does not exist, \code{NULL} is returned.
#'
#' \code{e$get_class()} uses \code{e$get_attribute} to parse the
#' \sQuote{class} attribute into a character vector.
#'
#' \code{e$get_css_value()} queries a CSS property of an element.
#'
#' \code{e$get_text()} returns the \code{innerText} on an element.
#'
#' \code{e$get_name()} returns the tag name of an element.
#'
#' \code{e$get_data()} is a shorthand for querying \code{data-*} attributes.
#'
#' \code{e$get_rect()} returns the \sQuote{rectangle} of an element. It is
#' named list with components \code{x}, \code{y}, \code{height} and
#' \code{width}.
#'
#' \code{e$is_enabled()} returns \code{TRUE} if the element is enabled,
#' \code{FALSE} otherwise.
#'
#' \code{e$click()} scrolls the element into view, and clicks the
#' in-view centre point of it.
#'
#' \code{e$clear()} scrolls the element into view, and then attempts to
#' clear its value, checkedness or text content.
#'
#' \code{e$send_keys()} scrolls the form control element into view, and
#' sends the provided keys to it. See \code{\link{key}} for a list of
#' special keys that can be sent.
#'
#' \code{e$upload_file()} uploads a file to a \code{<input type="file">}
#' element. The \code{filename} argument can contain a single filename,
#' or multiple filenames, for file inputs that can take multiple files.
#'
#' \code{e$move_mouse_to()} moves the mouse cursor to the element, with
#' the specified offsets. If one or both offsets are \code{NULL}, then
#' it places the cursor on the center of the element. If the element is
#' not on the screen, then is scrolls it into the screen first.
#'
#' \code{e$execute_script()} and \code{e$execute_script_async()}
#' call the method of the same name on the \code{\link{session}} object.
#' The first argument of the script (\code{arguments[0]}) will always
#' hold the element object itself.
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

    get_value = function()
      element_get_value(self, private),

    set_value = function(value)
      element_set_value(self, private, value),

    get_attribute = function(name)
      element_get_attribute(self, private, name),

    get_class = function()
      element_get_class(self, private),

    get_css_value = function(name)
      element_get_css_value(self, private, name),

    get_text = function()
      element_get_text(self, private),

    get_name = function()
      element_get_name(self, private),

    get_data = function(name)
      element_get_data(self, private, name),

    get_rect = function()
      element_get_rect(self, private),

    is_enabled = function()
      element_id_enabled(self, private),

    click = function()
      element_click(self, private),

    clear = function()
      element_clear(self, private),

    send_keys = function(...)
      element_send_keys(self, private, ...),

    upload_file = function(filename)
      element_upload_file(self, private, filename),

    move_mouse_to = function(xoffset = NULL, yoffset = NULL)
      element_move_mouse_to(self, private, xoffset, yoffset),

    execute_script = function(script, ...)
      element_execute_script(self, private, script, ...),

    execute_script_async = function(script, ...)
      element_execute_script_async(self, private, script, ...)
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

  "!DEBUG element_find_element `css %||% link_text %||% partial_link_text %||% xpath`"
  find_expr <- parse_find_expr(css, link_text, partial_link_text, xpath)

  response <- private$session_private$make_request(
    "FIND ELEMENT FROM ELEMENT",
    list(
      using = find_expr$using,
      value = find_expr$value
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

  "!DEBUG element_find_elements `css %||% link_text %||% partial_link_text %||% xpath`"
  find_expr <- parse_find_expr(css, link_text, partial_link_text, xpath)

  response <- private$session_private$make_request(
    "FIND ELEMENTS FROM ELEMENT",
    list(
      using = find_expr$using,
      value = find_expr$value
    ),
    list(element_id = private$id)
  )

  lapply(response$value, function(el) {
    element$new(
      id = el$ELEMENT,
      session = private$session,
      session_private = private$session_private
    )
  })
}


element_is_selected <- function(self, private) {

  "!DEBUG element_is_selected `private$id`"
  response <- private$session_private$make_request(
    "IS ELEMENT SELECTED",
    params = list(element_id = private$id)
  )

  response$value
}

element_get_value <- function(self, private) {
  "!DEBUG element_get_value `private$id`"
  self$get_attribute("value")
}

element_set_value <- function(self, private, value) {

  "!DEBUG element_set_value `private$id`"
  assert_string(value)

  private$session_private$make_request(
    "SET ELEMENT VALUE",
    list(value = I(value)),
    params = list(element_id = private$id)
  )

  invisible(self)
}

element_get_attribute <- function(self, private, name) {

  "!DEBUG element_get_attribute `private$id` `name`"
  assert_string(name)

  response <- private$session_private$make_request(
    "GET ELEMENT ATTRIBUTE",
    params = list(element_id = private$id, name = name)
  )

  response$value
}


element_get_class <- function(self, private) {

  "!DEBUG element_get_class `private$id`"
  class <- self$get_attribute("class")
  strsplit(class, "\\s+")[[1]]
}

element_get_css_value <- function(self, private, name) {

  "!DEBUG element_get_css_value `private$id` `name`"
  assert_string(name)

  response <- private$session_private$make_request(
    "GET ELEMENT CSS VALUE",
    params = list(element_id = private$id, property_name = name)
  )

  response$value
}


element_get_text <- function(self, private) {

  "!DEBUG element_get_text `private$id`"
  response <- private$session_private$make_request(
    "GET ELEMENT TEXT",
    params = list(element_id = private$id)
  )

  response$value
}

element_get_data <- function(self, private, name) {

  "!DEBUG element_get_data `private$id` `name`"
  assert_string(name)
  self$get_attribute(paste0("data-", name))
}

element_get_name <- function(self, private) {

  "!DEBUG element_get_name `private$id`"
  response <- private$session_private$make_request(
    "GET ELEMENT TAG NAME",
    params = list(element_id = private$id)
  )

  response$value
}

## GET ELEMENT RECT is not implemented by phantomjs, but we can
## emulate it with two other endpoints: location and size

element_get_rect <- function(self, private) {

  "!DEBUG element_get_rect `private$id`"
  response1 <- private$session_private$make_request(
    "GET ELEMENT LOCATION",
    params = list(element_id = private$id)
  )

  response2 <- private$session_private$make_request(
    "GET ELEMENT SIZE",
    params = list(element_id = private$id)
  )

  list(
    x = response1$value$x,
    y = response1$value$y,
    width = response2$value$width,
    height = response2$value$height
  )
}


element_id_enabled <- function(self, private) {

  "!DEBUG element_id_enabled `private$id`"
  response <- private$session_private$make_request(
    "IS ELEMENT ENABLED",
    params = list(element_id = private$id)
  )

  response$value
}


element_click <- function(self, private) {

  "!DEBUG element_click `private$id`"
  response <- private$session_private$make_request(
    "ELEMENT CLICK",
    params = list(element_id = private$id)
  )

  invisible(private$session)
}


element_clear <- function(self, private) {

  "!DEBUG element_clear `private$id`"
  response <- private$session_private$make_request(
    "ELEMENT CLEAR",
    params = list(element_id = private$id)
  )

  invisible(self)
}


element_upload_file <- function(self, private, filename) {
  # The file upload endpoint requires a CSS selector to pick out the element,
  # so try to contsruct a selector for this element.
  selector <- NULL

  # Attempt id
  id <- self$get_attribute("id")
  if (length(id) > 0 && nzchar(id))
    selector <- paste0("#", id)

  # Attempt name
  if (is.null(selector)) {
    name <- self$get_attribute("name")
    if (length(name) > 0 && nzchar(name))
      selector <- paste0("input[type=file,name=", name, "]")
  }

  if (is.null(selector))
    stop("File input element must have an id or name attribute.")

  private$session_private$make_request(
    "UPLOAD FILE",
    data = list(
      selector = selector,
      filepath = as.list(filename)
    )
  )
}

element_move_mouse_to <- function(self, private, xoffset, yoffset) {

  "!DEBUG element_move_mouse_to `private$id` `xoffset`, `yoffset`"

  if (!is.null(xoffset)) assert_count(xoffset)
  if (!is.null(yoffset)) assert_count(yoffset)

  private$session_private$make_request(
    "MOVE MOUSE TO",
    list(
      element = private$id,
      xoffset = xoffset,
      yoffst = yoffset
    )
  )

  invisible(self)
}

element_execute_script <- function(self, private, script, ...) {
  "!DEBUG element_execute_script `private$id`"
  private$session$execute_script(script, self, ...)
}

element_execute_script_async <- function(self, private, script, ...) {
  "!DEBUG element_execute_script_async `private$id`"
  private$session$execute_script(script, self, ...)
}
