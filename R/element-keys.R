
#' This is the list in the standard:
#' https://w3c.github.io/webdriver/webdriver-spec.html#keyboard-actions
#' Our list was last updated on 2016-09-30
#' I removed the keys that can be transmitted in a simpler way.
#'
#' TODO: check what is actually supported by the various drivers.
#' A fun task. :)
#' @noRd
NULL

#' Special keys, so that we can refer to them with an easier syntax
#'
#' @examples
#' \dontrun{
#' el$sendKeys("xyz")
#' el$sendKeys("x", "y", "z")
#' el$sendKeys("username", key$enter, "password", key$enter)
#'
#' ## Sending CTRL+A
#' el$sendKeys(key$control, "a")
#'
#' ## Note that modifier keys (control, alt, shift, meta) are sticky,
#' ## they remain in effect in the rest of the sendKeys() call. E.g.
#' ## this sends CTRL+X and CTRL+S
#' el$sendKeys(key$control, "x", "s")
#'
#' ## You will need multiple calls to release control and send CTRL+X S
#' el$sendKeys(key$control, "x")
#' el$sendKeys("s")
#' }
#'
#' @export

key <- list(
  "unidentified"  = "\uE000",
  "cancel"        = "\ue001",
  "help"          = "\ue002",
  "backspace"     = "\ue003",
  "tab"           = "\ue004",
  "clear"         = "\ue005",
  "return"        = "\ue006",
  "enter"         = "\ue007",
  "shift"         = "\ue008",
  "control"       = "\ue009",
  "alt"           = "\ue00a",
  "pause"         = "\ue00b",
  "escape"        = "\ue00c",
  "pageup"        = "\ue00e",
  "pagedown"      = "\ue00f",
  "end"           = "\ue010",
  "home"          = "\ue011",
  "arrowleft"     = "\ue012",
  "arrowup"       = "\ue013",
  "arrowright"    = "\ue014",
  "arrowdown"     = "\ue015",
  "insert"        = "\ue016",
  "delete"        = "\ue017",
  "f1"            = "\ue031",
  "f2"            = "\ue032",
  "f3"            = "\ue033",
  "f4"            = "\ue034",
  "f5"            = "\ue035",
  "f6"            = "\ue036",
  "f7"            = "\ue037",
  "f8"            = "\ue038",
  "f9"            = "\ue039",
  "f10"           = "\ue03a",
  "f11"           = "\ue03b",
  "f12"           = "\ue03c",
  "meta"          = "\ue03d",
  "zenkakuhankak" = "\ue040",
  "shift"         = "\ue050",
  "control"       = "\ue051",
  "alt"           = "\ue052",
  "meta"          = "\ue053",
  "pageup"        = "\ue054",
  "pagedown"      = "\ue055",
  "end"           = "\ue056",
  "home"          = "\ue057",
  "arrowleft"     = "\ue058",
  "arrowup"       = "\ue059",
  "arrowright"    = "\ue05a",
  "arrowdown"     = "\ue05b",
  "insert"        = "\ue05c",
  "delete"        = "\ue05d"
)

#' Send keys to element
#'
#' @param self object
#' @param private private object
#' @param ... see examples at \code{\link{key}}
#'
#' @keywords internal

element_sendKeys <- function(self, private, ...) {

  keys <- list(...)
  if (any(vapply(keys, is.null, TRUE))) {
    stop("NULL key in send_key, probably a typo")
  }

  "!DEBUG element_sendKeys `private$id`"
  response <- private$session_private$makeRequest(
    "ELEMENT SEND KEYS",
    list(value = I(paste(keys, collapse = ""))),
    params = list(elementId = private$id)
  )

  invisible(self)
}
