
endpoints <- list(
  "NEW SESSION"       =   "POST      /session",
  "DELETE SESSION"    =   "DELETE    /session/:session_id",
  "GO"                =   "POST      /session/:session_id/url",
  "GET CURRENT URL"   =   "GET       /session/:session_id/url",
  "BACK"              =   "POST      /session/:session_id/back",
  "FORWARD"           =   "POST      /session/:session_id/forward",
  "REFRESH"           =   "POST      /session/:session_id/refresh",
  "GET TITLE"         =   "GET       /session/:session_id/title"
)
