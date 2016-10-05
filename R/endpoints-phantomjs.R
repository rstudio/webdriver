
#' @include endpoints.R
#' @include utils.R

phantomjs_new <- list(

  ## This is /window in the standard, /window_handle in phantomjs
  "GET WINDOW HANDLE"    = "GET    /session/:session_id/window_handle",

  ## This is window/handles in the standard, /window_handles in phantomjs
  "GET WINDOW HANDLES"   = "GET    /session/:session_id/window_handles",

  ## Not supported
  "FULLSCREEN WINDOW"    = NULL,

  ## non-standard
  "MAXIMIZE WINDOW"      = "POST   /session/:session_id/window/:window_id/maximize",

  ## non-standard
  "SET WINDOW SIZE"      = "POST   /session/:session_id/window/:window_id/size",

  ## non-stadard
  "GET WINDOW POSITION"  = "GET    /session/:session_id/window/:window_id/position",

  ## non-standard
  "SET WINDOW POSITION"  = "POST   /session/:session_id/window/:window_id/position",

  ## This is also non-standard
  "GET WINDOW SIZE"      = "GET    /session/:session_id/window/:window_id/size",

  ## In the standard this is a GET, but phantomjs expects a POST :(
  "GET ACTIVE ELEMENT"   = "POST   /session/:session_id/element/active",

  ## Different URL
  "EXECUTE SCRIPT"       = "POST   /session/:session_id/execute",
  "EXECUTE ASYNC SCRIPT" = "POST   /session/:session_id/execute_async",

  ## -------------------------------------------------------------------
  ## Phantom JS specific endpoints

  "STATUS"               = "GET    /session/:session_id",
  "MOVE MOUSE TO"        = "POST   /session/:session_id/moveto",
  "CLICK"                = "POST   /session/:session_id/click",
  "DOUBLECLICK"          = "POST   /session/:session_id/doubleclick",
  "BUTTONDOWN"           = "POST   /session/:session_id/buttondown",
  "BUTTONUP"             = "POST   /session/:session_id/buttonup",
  "GET LOG TYPES"        = "GET    /session/:session_id/log/types",
  "READ LOG"             = "POST   /session/:session_id/log",
  "GET ELEMENT LOCATION" = "GET    /session/:session_id/element/:element_id/location",
  "GET ELEMENT SIZE"     = "GET    /session/:session_id/element/:element_id/size",
  "SET ELEMENT VALUE"    = "POST   /session/:session_id/element/:element_id/value"
)

endpoints$phantomjs <- update_list(endpoints$generic, phantomjs_new)
