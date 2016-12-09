
#' A browser window
#'
#' @section Usage:
#' \preformatted{w <- s$getWindow()
#' wlist <- s$getAllWindows()
#'
#' w$close()
#' w$is_active()
#' w$switch_to()
#' w$maximize()
#' w$get_size()
#' w$set_size(width, height)
#' w$get_position()
#' w$set_position(x, y)
#' }
#'
#' @section Arguments:
#' \describe{
#'   \item{s}{A \code{\link{Session}} object.}
#'   \item{w}{A \code{Window} object.}
#'   \item{wlist}{A list of \code{Window} objects.}
#'   \item{width}{Integer scalar, requested width of the window.}
#'   \item{height}{Integer scalar, requested height of the window.}
#'   \item{x}{Integer scalar, requested horizontal window position.}
#'   \item{y}{Integer scalar, requested vertical window position.}
#' }
#'
#' @section Details:
#'
#' The \code{getWindow} method of a \code{\link{Session}} object
#' returns the current browser window as a \code{Window} object.
#' The \code{getAllWindows} method returns a list of window objects,
#' all browser windows.
#'
#' \code{w$close()} closes the window.
#'
#' \code{w$is_active()} returns \code{TRUE} if the window is active,
#' \code{FALSE} otherwise.
#'
#' \code{w$switch_to} makes the window active.
#'
#' \code{w$maximize} maximizes the window. Currently it sets it to
#' a fixed size.
#'
#' \code{w$get_size} returns the size of the window, in a list with
#' elementh \code{width} and \code{height}, both integers.
#'
#' \code{w$set_size} sets the size of the window.
#'
#' \code{w$get_position} returns the position of the window on the
#' screen. Phantom.js being headless, it always returns
#' \code{list(x = 0, y = 0)}, and it is included to have a complete
#' impelementation of the WebDriver standard.
#'
#' \code{w$set_position(x, y)} sets the position of the window on the
#' screen. Phantom.js being headless, it has no effect, and it is included
#' to have a complete implementation of the WebDriver standard.
#'
#' @name Window
#' @importFrom R6 R6Class
NULL

Window <- R6Class(
  "Window",
  public = list(

    initialize = function(id, session, session_private) {
      window_initialize(self, private, id, session, session_private)
    },

    close = function()
      window_close(self, private),

    is_active = function()
      window_is_active(self, private),

    switch_to = function()
      window_switch_to(self, private),

    ## Not supported
    ## make_fullscreen = function()
    ##   window_make_fullscreen(self, private),

    maximize = function()
      window_maximize(self, private),

    get_size = function()
      window_get_size(self, private),

    set_size = function(width, height)
      window_set_size(self, private, width, height),

    get_position = function()
      window_get_position(self, private),

    set_position = function(x, y)
      window_set_position(self, private, x, y)
  ),
  private = list(
    id = NULL,
    session = NULL,
    session_private = NULL
  )
)

window_initialize <- function(self, private, id, session,
                              session_private) {

  assert_string(id)
  assert_session(session)

  private$id <- id
  private$session <- session
  private$session_private <- session_private

  invisible(self)

}

window_close <- function(self, private) {

  "!DEBUG window_close"
  private$session_private$makeRequest(
    "CLOSE WINDOW",
    list(name = private$id)
  )

  invisible(self)
}

window_is_active <- function(self, private) {

  "!DEBUG window_is_active"
  active <- private$session$getWindow()
  active$.__enclos_env__$private$id == private$id
}

window_switch_to <- function(self, private) {

  "!DEBUG window_switch_to"
  private$session_private$makeRequest(
    "SWITCH TO WINDOW",
    list(name = private$id)
  )

  invisible(self)
}

## window_make_fullscreen <- function(self, private) {

##  "!DEBUG window_make_fullscreen"
##   private$session_private$makeRequest(
##     "FULLSCREEN WINDOW",
##   )

##   invisible(self)
## }

window_maximize <- function(self, private) {

  "!DEBUG window_maximize"
  private$session_private$makeRequest(
    "MAXIMIZE WINDOW",
    params = list(window_id = private$id)
  )

  invisible(self)
}

window_get_size <- function(self, private) {

  "!DEBUG window_get_size"
  response <- private$session_private$makeRequest(
    "GET WINDOW SIZE",
    params = list(window_id = private$id)
  )

  list(width = response$value$width, height = response$value$height)
}

window_set_size <- function(self, private, width, height) {

  "!DEBUG window_set_size `width`x`height`"
  assert_window_size(width)
  assert_window_size(height)

  private$session_private$makeRequest(
    "SET WINDOW SIZE",
    list(
      width = width,
      height = height
    ),
    params = list(window_id = private$id)
  )

  invisible(self)
}

window_get_position <- function(self, private) {

  "!DEBUG window_get_position"
  response <- private$session_private$makeRequest(
    "GET WINDOW POSITION",
    params = list(window_id = private$id)
  )

  response$value
}

window_set_position <- function(self, private, x, y) {

  "!DEBUG window_set_position"
  assert_window_position(x)
  assert_window_position(y)

  private$session_private$makeRequest(
    "SET WINDOW POSITION",
    list(
      x = x,
      y = y
    ),
    params = list(window_id = private$id)
  )


  invisible(self)
}
