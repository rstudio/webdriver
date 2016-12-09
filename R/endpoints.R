
## Order is (mostly) according to
## https://w3c.github.io/webdriver/webdriver-spec.html#list-of-endpoints

endpoints <- list(

  "NEW SESSION"          = "POST   /session",
  "DELETE SESSION"       = "DELETE /session/:sessionId",
  "GO"                   = "POST   /session/:sessionId/url",
  "GET CURRENT URL"      = "GET    /session/:sessionId/url",
  "BACK"                 = "POST   /session/:sessionId/back",
  "FORWARD"              = "POST   /session/:sessionId/forward",
  "REFRESH"              = "POST   /session/:sessionId/refresh",
  "GET TITLE"            = "GET    /session/:sessionId/title",

  ## windows
  ## This is /window in the standard, /window_handle in phantomjs
  ## "GET WINDOW HANDLE"    = "GET    /session/:sessionId/window",
  "GET WINDOW HANDLE"    = "GET    /session/:sessionId/window_handle",
  "CLOSE WINDOW"         = "DELETE /session/:sessionId/window",
  "SWITCH TO WINDOW"     = "POST   /session/:sessionId/window",
  ## This is window/handles in the standard, /window_handles in phantomjs
  ## "GET WINDOW HANDLES"   = "GET    /session/:sessionId/window/handles",
  "GET WINDOW HANDLES"   = "GET    /session/:sessionId/window_handles",
  ## Not supported
  "FULLSCREEN WINDOW"    = "POST   /session/:sessionId/window/fullscreen",
  ## non-standard
  ## "MAXIMIZE WINDOW"      = "POST   /session/:sessionId/window/maximize",
  "MAXIMIZE WINDOW"      = "POST   /session/:sessionId/window/:window_id/maximize",
  ## non-standard
  ## "SET WINDOW SIZE"      = "POST   /session/:sessionId/window/size",
  "SET WINDOW SIZE"      = "POST   /session/:sessionId/window/:window_id/size",
  ## non-stadard
  ## "GET WINDOW POSITION"  = "GET    /session/:sessionId/window/position",
  "GET WINDOW POSITION"  = "GET    /session/:sessionId/window/:window_id/position",
  ## non-standard
  ## "SET WINDOW POSITION"  = "POST   /session/:sessionId/window/position",
  "SET WINDOW POSITION"  = "POST   /session/:sessionId/window/:window_id/position",
  ## This is also non-standard
  ## "GET WINDOW SIZE"      = "GET    /session/:sessionId/window/size",
  "GET WINDOW SIZE"      = "GET    /session/:sessionId/window/:window_id/size",

  ## frames
  "SWITCH TO FRAME"      = "POST   /session/:sessionId/frame",
  "SWITCH TO PARENT FRAME"
                         = "POST   /session/:sessionId/frame/parent",

  ## elements
  "FIND ELEMENT"         = "POST   /session/:sessionId/element",
  "FIND ELEMENT FROM ELEMENT"
                         = "POST   /session/:sessionId/element/:elementId/element",
  "FIND ELEMENTS"        = "POST   /session/:sessionId/elements",
  "FIND ELEMENTS FROM ELEMENT"
                         = "POST   /session/:sessionId/element/:elementId/elements",
  ## In the standard this is a GET, but phantomjs expects a POST :(
  "GET ACTIVE ELEMENT"   = "POST   /session/:sessionId/element/active",
  "IS ELEMENT SELECTED"  = "GET    /session/:sessionId/element/:elementId/selected",
  "GET ELEMENT ATTRIBUTE"= "GET    /session/:sessionId/element/:elementId/attribute/:name",
  "GET ELEMENT PROPERTY" = "GET    /session/:sessionId/element/:elementId/property/:name",
  "GET ELEMENT CSS VALUE"= "GET    /session/:sessionId/element/:elementId/css/:property_name",
  "GET ELEMENT TEXT"     = "GET    /session/:sessionId/element/:elementId/text",
  "GET ELEMENT TAG NAME" = "GET    /session/:sessionId/element/:elementId/name",
  "GET ELEMENT RECT"     = "GET    /session/:sessionId/element/:elementId/rect",
  "IS ELEMENT ENABLED"   = "GET    /session/:sessionId/element/:elementId/enabled",
  "ELEMENT CLICK"        = "POST   /session/:sessionId/element/:elementId/click",
  "ELEMENT CLEAR"        = "POST   /session/:sessionId/element/:elementId/clear",
  "ELEMENT SEND KEYS"    = "POST   /session/:sessionId/element/:elementId/value",

  "GET PAGE SOURCE"      = "GET    /session/:sessionId/source",
  ## "EXECUTE SCRIPT"       = "POST   /session/:sessionId/execute/sync",
  "EXECUTE SCRIPT"       = "POST   /session/:sessionId/execute",
  ## "EXECUTE ASYNC SCRIPT" = "POST   /session/:sessionId/execute/async",
  "EXECUTE ASYNC SCRIPT" = "POST   /session/:sessionId/execute_async",

  ## cookies
  "GET ALL COOKIES"      = "GET    /session/:sessionId/cookie",
  "GET NAMED COOKIE"     = "GET    /session/:sessionId/cookie/:name",
  "ADD COOKIE"           = "POST   /session/:sessionId/cookie",
  "DELETE COOKIE"        = "DELETE /session/:sessionId/cookie/:name",
  "DELETE ALL COOKIES"   = "DELETE /session/:sessionId/cookie",

  "SET TIMEOUT"          = "POST   /session/:sessionId/timeouts",
  "PERFORM ACTIONS"      = "POST   /session/:sessionId/actions",
  "RELEASE ACTIONS"      = "DELETE /session/:sessionId/actions",

  ## alerts
  "DISMISS ALERT"        = "POST   /session/:sessionId/alert/dismiss",
  "ACCEPT ALERT"         = "POST   /session/:sessionId/alert/accept",
  "GET ALERT TEXT"       = "GET    /session/:sessionId/alert/text",
  "SEND ALERT TEXT"      = "POST   /session/:sessionId/alert/text",

  ## screenshots
  "TAKE SCREENSHOT"      = "GET    /session/:sessionId/screenshot",
  "TAKE ELEMENT SCREENSHOT"
                         = "GET    /session/:sessionId/element/:elementId/screenshot",

  ## -------------------------------------------------------------------
  ## Phantom JS specific endpoints

  "STATUS"               = "GET    /session/:sessionId",
  "MOVE MOUSE TO"        = "POST   /session/:sessionId/moveto",
  "CLICK"                = "POST   /session/:sessionId/click",
  "DOUBLECLICK"          = "POST   /session/:sessionId/doubleclick",
  "BUTTONDOWN"           = "POST   /session/:sessionId/buttondown",
  "BUTTONUP"             = "POST   /session/:sessionId/buttonup",
  "GET LOG TYPES"        = "GET    /session/:sessionId/log/types",
  "READ LOG"             = "POST   /session/:sessionId/log",
  "UPLOAD FILE"          = "POST   /session/:sessionId/file",
  "GET ELEMENT LOCATION" = "GET    /session/:sessionId/element/:elementId/location",
  "GET ELEMENT SIZE"     = "GET    /session/:sessionId/element/:elementId/size",
  "SET ELEMENT VALUE"    = "POST   /session/:sessionId/element/:elementId/value"
)
