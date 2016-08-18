
#' @importFrom R6 R6Class
#' @export

session <- R6Class(
  "session",
  public = list(

    initialize = function(host = "localhost", port = 8910)
      session_initialize(self, private, host, port),

    delete = function()
      session_delete(self, private),

    go = function(url)
      session_go(self, private, url),

    get_url = function()
      session_get_url(self, private),

    go_back = function()
      session_go_back(self, private),

    go_forward = function()
      session_go_forward(self, private),

    refresh = function()
      session_refresh(self, private),

    get_title = function()
      session_get_title(self, private)

    ## Elements ------------------------------------------------

    find_element = function(css = NULL, link_text = NULL,
      partial_link_text = NULL, xpath = NULL)
      session_find_element(self, private, css, link_text,
                           partial_link_text, xpath),

    find_elements = function(css = NULL, link_text = NULL,
      partial_link_text = NULL, xpath = NULL)
      session_find_elements(self, private, css, link_text,
                            partial_link_text, xpath),

    get_active_element = function()
      session_get_active_element(self, private)
  ),

  private = list(

    host = NULL,
    port = NULL,
    session_id = NULL,
    parameters = NULL,

    make_request = function(endpoint, data = NULL, params = NULL)
      session_make_request(self, private, endpoint, data, params)
  )
)


#' @importFrom jsonlite unbox

session_initialize <- function(self, private, host, port) {

  assert_string(host)
  assert_port(port)

  private$host <- host
  private$port <- port

  response <- private$make_request(
    "NEW SESSION",
    list(
      desiredCapabilities = list(
        browserName = unbox("phantomjs"),
        driverName  = unbox("ghostdriver")
      )
    )
  )

  private$session_id = response$sessionId %||% stop("Got no session_id")
  private$parameters = response$value

  invisible(self)
}


session_delete <- function(self, private) {

  response <- private$make_request(
    "DELETE SESSION",
    list()
  )

  invisible(response$sessionId)
}


session_go <- function(self, private, url) {

  assert_url(url)

  private$make_request(
    "GO",
    list("url" = unbox(url))
  )

  invisible(self)
}


session_get_url <- function(self, private) {

  response <- private$make_request(
    "GET CURRENT URL"
  )

  response$value
}


session_go_back <- function(self, private) {

  private$make_request(
    "BACK"
  )

  invisible(self)
}


session_go_forward <- function(self, private) {

  private$make_request(
    "FORWARD"
  )

  invisible(self)
}


session_refresh <- function(self, private) {

  private$make_request(
    "REFRESH"
  )

  invisible(self)
}


session_get_title <- function(self, private) {
  response <- private$make_request(
    "GET TITLE"
  )

  response$value
}


session_find_element <- function(self, private, css, link_text,
                                 partial_link_text, xpath) {

  find_expr <- parse_find_expr(css, link_text, partial_link_text, xpath)

  response <- private$make_request(
    "FIND ELEMENT",
    list(
      using = unbox(find_expr$using),
      value = unbox(find_expr$value)
    )
  )

  element$new(
    id = response$value$ELEMENT,
    session = self,
    session_private = private
  )
}


parse_find_expr <- function(css, link_text, partial_link_text, xpath) {

  if (is.null(css) + is.null(link_text) + is.null(partial_link_text) +
      is.null(xpath) != 3) {
    stop(
      "Specify one of 'css', 'link_text', ",
      "'partial_link_text' and 'xpath'"
    )
  }

  if (!is.null(css)) {
    list(using = "css selector", value = css)

  } else if (!is.null(link_text)) {
    list(using = "link text", value = link_text)

  } else if (!is.null(partial_link_text)) {
    list(using = "partial link text", value = partial_link_text)

  } else if (!is.null(xpath)) {
    list(using = "xpath", value = xpath)
  }
}


session_find_elements <- function(self, private, css, link_text,
                                  partial_link_text, xpath) {
  ## TODO
}


## TODO: this does not seem to work
session_get_active_element <- function(self, private) {

  response <- private$make_request(
    "GET ACTIVE ELEMENT"
  )

  element$new(
    id = response$value$ELEMENT,
    session = self,
    session_private = private
  )
}
