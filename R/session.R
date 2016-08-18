
#' @importFrom R6 R6Class
#' @export

session <- R6Class(
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
  ),

  private = list(

    host = NULL,
    port = NULL,
    session_id = NULL,
    parameters = NULL,

    make_request = function(endpoint, data = NULL)
      session_make_request(self, private, endpoint, data)
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
