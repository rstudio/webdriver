
#' @include endpoints.R

driver <- R6Class(
  "driver",
  public = list(

    initialize = function(session, session_private)
      driver_init(self, session, session_private),
    
    make_request = function(endpoint, data = NULL, params = NULL,
      headers = NULL) 
      driver_make_request(self, endpoint, data, params, headers),

    report_error = function(response)
      driver_report_error(self, response),
    
    ## These are not private, because we need to access them from
    ## child classes. But this is an internal class, anyway.
    session = NULL,
    session_private = NULL,
    endpoints = NULL
  )
)

driver_init <- function(self, session, session_private) {
  self$session <- session
  self$session_private <- session_private
  self$endpoints <- endpoints
}

make_driver <- function(type) {
  switch(
    type,
    "generic"      = driver,
    "phantomjs"    = phantom_driver,
    "chromedrover" = chrome_driver,
    stop("Unknown driver")
  )
}

#' @importFrom httr status_code

report_error <- function(self, response) {

  if (status_code(response) < 300) {
    invisible(response)
  } else {
    call <- sys.call(-1)
    stop(create_condition(response, "error", call = call))
  }
}
