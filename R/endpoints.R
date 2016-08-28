
## Order is (mostly) according to
## https://w3c.github.io/webdriver/webdriver-spec.html#list-of-endpoints

endpoints <- list(

  "NEW SESSION"          = "POST   /session",
  "DELETE SESSION"       = "DELETE /session/:session_id",
  "GO"                   = "POST   /session/:session_id/url",
  "GET CURRENT URL"      = "GET    /session/:session_id/url",
  "BACK"                 = "POST   /session/:session_id/back",
  "FORWARD"              = "POST   /session/:session_id/forward",
  "REFRESH"              = "POST   /session/:session_id/refresh",
  "GET TITLE"            = "GET    /session/:session_id/title",

  ## windows
  ## This is /window in the standard, /window_handle in phantomjs
  ## "GET WINDOW HANDLE"    = "GET    /session/:session_id/window",
  "GET WINDOW HANDLE"    = "GET    /session/:session_id/window_handle",
  "CLOSE WINDOW"         = "DELETE /session/:session_id/window",
  "SWITCH TO WINDOW"     = "POST   /session/:session_id/window",
  ## This is window/handles in the standard, /window_handles in phantomjs
  ## "GET WINDOW HANDLES"   = "GET    /session/:session_id/window/handles",
  "GET WINDOW HANDLES"   = "GET    /session/:session_id/window_handles",
  ## Not supported
  "FULLSCREEN WINDOW"    = "POST   /session/:session_id/window/fullscreen",
  ## non-standard
  ## "MAXIMIZE WINDOW"      = "POST   /session/:session_id/window/maximize",
  "MAXIMIZE WINDOW"      = "POST   /session/:session_id/window/:window_id/maximize",
  ## non-standard
  ## "SET WINDOW SIZE"      = "POST   /session/:session_id/window/size",
  "SET WINDOW SIZE"      = "POST   /session/:session_id/window/:window_id/size",
  ## non-stadard
  ## "GET WINDOW POSITION"  = "GET    /session/:session_id/window/position",
  "GET WINDOW POSITION"  = "GET    /session/:session_id/window/:window_id/position",
  ## non-standard
  ## "SET WINDOW POSITION"  = "POST   /session/:session_id/window/position",
  "SET WINDOW POSITION"  = "POST   /session/:session_id/window/:window_id/position",
  ## This is also non-standard
  ## "GET WINDOW SIZE"      = "GET    /session/:session_id/window/size",
  "GET WINDOW SIZE"      = "GET    /session/:session_id/window/:window_id/size",

  ## frames
  "SWITCH TO FRAME"      = "POST   /session/:session_id/frame",
  "SWITCH TO PARENT FRAME"
                         = "POST   /session/:session_id/frame/parent",

  ## elements
  "FIND ELEMENT"         = "POST   /session/:session_id/element",
  "FIND ELEMENT FROM ELEMENT"
                         = "POST   /session/:session_id/element/:element_id/element",
  "FIND ELEMENTS"        = "POST   /session/:session_id/elements",
  "FIND ELEMENTS FROM ELEMENT"
                         = "POST   /session/:session_id/element/:element_id/elements",
  ## In the standard this is a GET, but phantomjs expects a POST :(
  "GET ACTIVE ELEMENT"   = "POST   /session/:session_id/element/active",
  "IS ELEMENT SELECTED"  = "GET    /session/:session_id/element/:element_id/selected",
  "GET ELEMENT ATTRIBUTE"= "GET    /session/:session_id/element/:element_id/attribute/:name",
  "GET ELEMENT PROPERTY" = "GET    /session/:session_id/element/:element_id/property/:name",
  "GET ELEMENT CSS VALUE"= "GET    /session/:session_id/element/:element_id/css/:property_name",
  "GET ELEMENT TEXT"     = "GET    /session/:session_id/element/:element_id/text",
  "GET ELEMENT TAG NAME" = "GET    /session/:session_id/element/:element_id/name",
  "GET ELEMENT RECT"     = "GET    /session/:session_id/element/:element_id/rect",
  "IS ELEMENT ENABLED"   = "GET    /session/:session_id/element/:element_id/enabled",
  "ELEMENT CLICK"        = "POST   /session/:session_id/element/:element_id/click",
  "ELEMENT CLEAR"        = "POST   /session/:session_id/element/:element_id/clear",
  "ELEMENT SEND KEYS"    = "POST   /session/:session_id/element/:element_id/value",

  "GET PAGE SOURCE"      = "GET    /session/:session_id/source",
  ## "EXECUTE SCRIPT"       = "POST   /session/:session_id/execute/sync",
  "EXECUTE SCRIPT"       = "POST   /session/:session_id/execute",
  ## "EXECUTE ASYNC SCRIPT" = "POST   /session/:session_id/execute/async",
  "EXECUTE ASYNC SCRIPT" = "POST   /session/:session_id/execute_async",

  ## cookies
  "GET ALL COOKIES"      = "GET    /session/:session_id/cookie",
  "GET NAMED COOKIE"     = "GET    /session/:session_id/cookie/:name",
  "ADD COOKIE"           = "POST   /session/:session_id/cookie",
  "DELETE COOKIE"        = "DELETE /session/:session_id/cookie/:name",
  "DELETE ALL COOKIES"   = "DELETE /session/:session_id/cookie",

  "SET TIMEOUT"          = "POST   /session/:session_id/timeouts",
  "PERFORM ACTIONS"      = "POST   /session/:session_id/actions",
  "RELEASE ACTIONS"      = "DELETE /session/:session_id/actions",

  ## alerts
  "DISMISS ALERT"        = "POST   /session/:session_id/alert/dismiss",
  "ACCEPT ALERT"         = "POST   /session/:session_id/alert/accept",
  "GET ALERT TEXT"       = "GET    /session/:session_id/alert/text",
  "SEND ALERT TEXT"      = "POST   /session/:session_id/alert/text",

  ## screenshots
  "TAKE SCREENSHOT"      = "GET    /session/:session_id/screenshot",
  "TAKE ELEMENT SCREENSHOT"
                         = "GET    /session/:session_id/element/:element_id/screenshot",

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
  "GET ELEMENT SIZE"     = "GET    /session/:session_id/element/:element_id/size"
)
