
window <- R6Class(
  "window",
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

  private$session_private$make_request(
    "CLOSE WINDOW"
  )

  invisible(self)
}

window_is_active <- function(self, private) {

  active <- private$session$get_window()
  active$.__enclos_env__$private$id == private$id
}

window_switch_to <- function(self, private) {

  private$session_private$make_request(
    "SWITCH TO WINDOW",
    list(name = unbox(private$id))
  )

  invisible(self)
}

## window_make_fullscreen <- function(self, private) {

##   private$session_private$make_request(
##     "FULLSCREEN WINDOW",
##   )

##   invisible(self)
## }

window_maximize <- function(self, private) {

  private$session_private$make_request(
    "MAXIMIZE WINDOW",
    params = list(window_id = private$id)
  )

  invisible(self)
}

window_get_size <- function(self, private) {

  response <- private$session_private$make_request(
    "GET WINDOW SIZE",
    params = list(window_id = private$id)
  )

  list(width = response$value$width, height = response$value$height)
}

window_set_size <- function(self, private, width, height) {

  assert_window_size(width)
  assert_window_size(height)

  private$session_private$make_request(
    "SET WINDOW SIZE",
    list(
      width = unbox(width),
      height = unbox(height)
    ),
    params = list(window_id = private$id)
  )

  invisible(self)
}

window_get_position <- function(self, private) {

  response <- private$session_private$make_request(
    "GET WINDOW POSITION",
    params = list(window_id = private$id)
  )

  response$value
}

window_set_position <- function(self, private, x, y) {

  assert_window_position(x)
  assert_window_position(y)

  private$session_private$make_request(
    "SET WINDOW POSITION",
    list(
      x = unbox(x),
      y = unbox(y)
    ),
    params = list(window_id = private$id)
  )


  invisible(self)
}
