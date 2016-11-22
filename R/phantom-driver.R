
phantom_driver <- R6Class(
  "phantom_driver",
  inherit = driver,
  public = list(
    initialize = function(session, session_private)
      phantom_driver_init(self, super, session, session_private)
  )  
)

phantom_driver_init <- function(self, super, session, session_private) {
  super$initialize(session, session_private)

  ## Update endpoints
  self$endpoints <- update_list(self$endpoints, endpoints_phantomjs)
  
  ## Set implicit timeout to zero. According to the standard it should
  ## be zero, but phantomjs uses about 200 ms
  self$session$set_timeout(implicit = 0)
}
