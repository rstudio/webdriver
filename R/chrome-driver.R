
chrome_driver <- R6Class(
  "chrome_driver",
  inherit = driver,
  public = list(

    initialize = function(session)
      chrome_driver_init(self, super, session),

    report_error = function(response)
      chrome_driver_report_error(self, response)
  )
)

chrome_driver_init <- function(self, super, session, session_private) {
  super$initialize(session, session_private)

  ## Update endpoints
  self$endpoints <- update_list(self$endpoints, endpoints_chromedriver)

  ## Script timeout of chromedriver seems to be zero by default.
  ## That's a little agressive, the standard says 30 seconds
  self$session$set_timeout(script = 30000)
}

chrome_driver_report_error <- function(self, response) {

  ## chromedriver does not return proper HTTP errors, but
  ## it just sets 'status' in the result
  cont <- content(response)
  if (is.null(cont$status) || !identical(as.integer(cont$status), 0L)) {
    call <- sys.call(-1)
    stop(create_condition(response, "error", call = call))
  } else {
    invisible(response)
  }
}
