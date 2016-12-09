
#' WebDriver session
#'
#' Drive a headless phantom.js browser via the WebDriver protocol.
#' It needs phantom.js running in WebDriver mode.
#'
#' @section Usage:
#' \preformatted{s <- Session$new(host = "127.0.0.1", port = 8910)
#'
#' s$delete()
#' s$status()
#'
#' s$go(url)
#' s$getUrl()
#' s$goBack()
#' s$goForward()
#' s$refresh()
#' s$getTitle()
#' s$getSource()
#' s$takeScreenshot(file = NULL)
#'
#' s$findElement(css = NULL, linkText = NULL,
#'     partialLinkText = NULL, xpath = NULL)
#' s$findElements(css = NULL, linkText = NULL,
#'     partialLinkText = NULL, xpath = NULL)
#'
#' s$executeScript(script, ...)
#' s$executeScriptAsync(script, ...)
#'
#' s$setTimeout(script = NULL, pageLoad = NULL, implicit = NULL)
#'
#' s$moveMouseTo(xoffset = 0, yoffset = 0)
#' s$click(button = c("left", "middle", "right"))
#' s$doubleClick(button = c("left", "middle", "right"))
#' s$mouseButtonDown(button = c("left", "middle", "right"))
#' s$mouseButtonUp(button = c("left", "middle", "right"))
#'
#' s$readLog(type = c("browser", "har"))
#' s$getLogTypes()
#'
#' s$waitFor(expr, checkInterval = 100, timeout = 3000)
#' }
#'
#' @section Arguments:
#'\describe{
#'   \item{s}{A \code{Session} object.}
#'   \item{host}{Host name of phantom.js.}
#'   \item{port}{Port of phantom.js.}
#'   \item{url}{URL to nagivate to.}
#'   \item{file}{File name to save the screenshot to. If \code{NULL}, then
#'     it will be shown on the R graphics device.}
#'   \item{css}{Css selector to find an HTML element.}
#'   \item{linkText}{Find HTML elements based on their \code{innerText}.}
#'   \item{partialLinkText}{Find HTML elements based on their
#'     \code{innerText}. It uses partial matching.}
#'   \item{xpath}{Find HTML elements using XPath expressions.}
#'   \item{script}{For \code{executeScript} and
#'     \code{executeScriptAsync}. JavaScript code to execute. It will be
#'     placed in the body of a function.}
#'   \item{...}{Arguments to the script, they will be put in a list
#'     called arguments. \code{\link{Element}} objects are automatically
#'     transformed to DOM element in JavaScript.}
#'   \item{script}{For \code{setTimeout}. Script execution timeout,
#'     in milliseconds. More below.}
#'   \item{pageLoad}{Page load timeout, in milliseconds. More below.}
#'   \item{implicit}{Implicit wait before calls that find elements, in
#'     milliseconds. More below.}
#'   \item{xoffset}{Horizontal offset for mouse movement, relative to the
#'     current position.}
#'   \item{yoffset}{Vertical offset for mouse movement, relative to the
#'     current position.}
#'   \item{button}{Mouse button. Either one of \code{"left"},
#'     \code{"middle"}, \code{"right"}, or an integer between 1 and 3.}
#'   \item{type}{Log type, a character scalar.}
#'   \item{expr}{A string scalar containing JavaScript code that
#'     evaluates to the condition to wait for.}
#'   \item{checkInterval}{How often to check for the condition, in
#'     milliseconds.}
#'   \item{timeout}{Timeout for the condition, in milliseconds.}
#' }
#'
#' @section Details:
#'
#' \code{Session$new()} creates a new WebDriver session.
#'
#' \code{s$delete()} deletes a WebDriver session.
#'
#' \code{s$status()} returns a status message from the server. It is a
#' named list, and contains version numbers and capabilities.
#'
#' \code{s$go()} navigates to the supplied URL.
#'
#' \code{s$getUrl()} returns the current URL.
#'
#' \code{s$goBack()} is like the web browser's back button. It goes back
#' to the previous page.
#'
#' \code{s$goForward()} is like the web browser's forward button.
#'
#' \code{s$refresh()} is like the web browser's refresh button.
#'
#' \code{s$getTitle()} returns the title of the current page.
#'
#' \code{s$getSource()} returns the complete HTML source of a page,
#' in a character scalar.
#'
#' \code{s$takeScreenshot()} takes a screenshot of the current page.
#' You can save it to a PNG file with the \code{file} argument, or
#' show it on the graphics device (if \code{file} is \code{NULL}).
#'
#' \code{s$findElement()} finds a HTML element using a CSS selector,
#' XPath expression, or the \code{innerHTML} of the element. If multiple
#' elements match, then the first one is returned. The return value
#' is an \code{\link{Element}} object.
#'
#' \code{s$findElements()} finds HTML elements using a CSS selector,
#' XPath expression, or the \code{innerHTML} of the element. All matching
#' elements are returned in a list of \code{\link{Element}} objects.
#'
#' \code{s$executeScript()} executes JavaScript code. It places the code
#' in the body of a function, and then calls the function with the
#' additional arguments. These can be accessed from the function via the
#' \code{arguments} array. Returned DOM elements are automatically
#' converted to \code{\link{Element}} objects, even if they are inside
#' a list (or list of list, etc.).
#'
#' \code{s$executeScriptAsync()} is similar, for asynchronous execution.
#' It place the script in a body of a function, and then calls the function
#' with the additional arguments and a callback function as the last
#' argument. The script must call this callback function when it
#' finishes its work. The first argument passed to the callback function
#' is returned. Returned DOM elements are automatically converted to
#' \code{\link{Element}} objects, even if they are inside a list (or list
#' of list, etc.).
#'
#' \code{s$setTimeout()} sets various timeouts. The \sQuote{script}
#' timeout specifies a time to wait for scripts to run. The
#' sQuote{page load} timeout specifies a time to wait for the page loading
#' to complete. The \sQuote{implicit} specifies a time to wait for the
#' implicit element location strategy when locating elements. Their defaults
#' are different in the standard and in Phantom.js. In Phantom.js the
#' \sQuote{script} and \sQuote{page load} timeouts are set to infinity,
#' and the \sQuote{implicit} waiting time is 200ms.
#'
#' \code{s$moveMouseTo()} moves the mouse cursor by the specified
#' offsets.
#'
#' \code{s$click()} clicks the mouse at its current position, using
#' the specified button.
#'
#' \code{s$doubleClick()} emulates a double click with the specified
#' mouse button.
#'
#' \code{s$button_down()} emulates pressing the specified mouse button
#' down (and keeping it down).
#'
#' \code{s$button_up()} emulates releasing the specified mouse button.
#'
#' \code{s$getLogTypes()} returns the log types supported by the
#' server, in a character vector.
#'
#' \code{s$readLog()} returns the log messages since the last
#' \code{readLog} call, in a data frame with columns \code{timestamp},
#' \code{level} and \code{message}.
#'
#' \code{s$waitFor()} waits until a JavaScript expression evaluates
#' to \code{true}, or a timeout happens. It returns \code{TRUE} is the
#' expression evaluated to \code{true}, possible after some waiting. If
#' the expression has a syntax error or a runtime error happens, it
#' returns \code{NA}.
#'
#' @seealso The WebDriver standard at
#' \url{https://w3c.github.io/webdriver/webdriver-spec.html}.
#'
#' @importFrom R6 R6Class
#' @name Session
NULL

#' @export

Session <- R6Class(
  "Session",
  public = list(

    initialize = function(host = "127.0.0.1", port = 8910)
      session_initialize(self, private, host, port),

    delete = function()
      session_delete(self, private),

    getStatus = function()
      session_getStatus(self, private),

    go = function(url)
      session_go(self, private, url),

    getUrl = function()
      session_getUrl(self, private),

    goBack = function()
      session_goBack(self, private),

    goForward = function()
      session_goForward(self, private),

    refresh = function()
      session_refresh(self, private),

    getTitle = function()
      session_getTitle(self, private),

    getSource = function()
      session_getSource(self, private),

    takeScreenshot = function(file = NULL)
      session_takeScreenshot(self, private, file = file),

    ## Elements ------------------------------------------------

    findElement = function(css = NULL, linkText = NULL,
      partialLinkText = NULL, xpath = NULL)
      session_findElement(self, private, css, linkText,
                           partialLinkText, xpath),

    findElements = function(css = NULL, linkText = NULL,
      partialLinkText = NULL, xpath = NULL)
      session_findElements(self, private, css, linkText,
                            partialLinkText, xpath),

    getActiveElement = function()
      session_getActiveElement(self, private),

    ## Windows -------------------------------------------------

    getWindow = function()
      session_getWindow(self, private),

    getAllWindows = function()
      session_getAllWindows(self, private),

    ## Execute script ------------------------------------------

    executeScript = function(script, ...)
      session_executeScript(self, private, script, ...),

    executeScriptAsync = function(script, ...)
      session_executeScriptAsync(self, private, script, ...),

    ## Timeouts ------------------------------------------------

    setTimeout = function(script = NULL, pageLoad = NULL,
      implicit = NULL)
      session_setTimeout(self, private, script, pageLoad, implicit),

    ## Move mouse, clicks --------------------------------------

    moveMouseTo = function(xoffset, yoffset)
      session_moveMouseTo(self, private, xoffset, yoffset),

    click = function(button = c("left", "middle", "right"))
      session_click(self, private, button),

    doubleClick = function(button = c("left", "middle", "right"))
      session_doubleClick(self, private, button),

    mouseButtonDown = function(button = c("left", "middle", "right"))
      session_mouseButtonDown(self, private, button),

    mouseButtonUp = function(button = c("left", "middle", "right"))
      session_mouseButtonUp(self, private, button),

    ## Logs ----------------------------------------------------

    getLogTypes = function()
      session_getLogTypes(self, private),

    readLog = function(type = "browser")
      session_readLog(self, private, type),

    ## Polling for a condition ---------------------------------

    waitFor = function(expr, checkInterval = 100, timeout = 3000)
      session_waitFor(self, private, expr, checkInterval, timeout)
  ),

  private = list(

    host = NULL,
    port = NULL,
    sessionId = NULL,
    parameters = NULL,
    numLogLinesShown = 0,

    makeRequest = function(endpoint, data = NULL, params = NULL,
      headers = NULL)
      session_makeRequest(self, private, endpoint, data, params, headers)
  )
)


session_initialize <- function(self, private, host, port) {

  "!DEBUG session_initialize `host`:`port`"
  assert_string(host)
  assert_port(port)

  private$host <- host
  private$port <- port
  private$numLogLinesShown <- 0

  response <- private$makeRequest(
    "NEW SESSION",
    list(
      desiredCapabilities = list(
        browserName = "phantomjs",
        driverName  = "ghostdriver"
      )
    )
  )

  private$sessionId = response$sessionId %||% stop("Got no sessionId")
  private$parameters = response$value

  ##  reg.finalizer(self, function(e) e$delete(), TRUE)

  ## Set implicit timeout to zero. According to the standard it should
  ## be zero, but phantomjs uses about 200 ms
  self$setTimeout(implicit = 0)

  ## Set initial windows size to something sane
  self$getWindow()$setSize(992, 744)

  invisible(self)
}


session_delete <- function(self, private) {

  "!DEBUG session_delete"
  if (! is.null(private$sessionId)) {
    response <- private$makeRequest(
      "DELETE SESSION",
      list()
    )
  }

  private$sessionId <- NULL

  invisible()
}

session_getStatus <- function(self, private) {
  "!DEBUG session_getStatus"
  response <- private$makeRequest(
    "STATUS"
  )

  response$value
}

session_go <- function(self, private, url) {

  "!DEBUG session_go `url`"
  assert_url(url)

  private$makeRequest(
    "GO",
    list("url" = url)
  )

  invisible(self)
}


session_getUrl <- function(self, private) {

  "!DEBUG session_getUrl"
  response <- private$makeRequest(
    "GET CURRENT URL"
  )

  response$value
}


session_goBack <- function(self, private) {

  "!DEBUG session_goBack"
  private$makeRequest(
    "BACK"
  )

  invisible(self)
}


session_goForward <- function(self, private) {

  "!DEBUG session_goForward"
  private$makeRequest(
    "FORWARD"
  )

  invisible(self)
}


session_refresh <- function(self, private) {

  "!DEBUG session_refresh"
  private$makeRequest(
    "REFRESH"
  )

  invisible(self)
}


session_getTitle <- function(self, private) {
  "!DEBUG session_getTitle"
  response <- private$makeRequest(
    "GET TITLE"
  )

  response$value
}


session_findElement <- function(self, private, css, linkText,
                                 partialLinkText, xpath) {

  "!DEBUG session_findElement `css %||% linkText %||% partialLinkText %||% xpath`"
  find_expr <- parse_find_expr(css, linkText, partialLinkText, xpath)

  response <- private$makeRequest(
    "FIND ELEMENT",
    list(
      using = find_expr$using,
      value = find_expr$value
    )
  )

  Element$new(
    id = response$value$ELEMENT,
    session = self,
    session_private = private
  )
}


parse_find_expr <- function(css, linkText, partialLinkText, xpath) {

  if (is.null(css) + is.null(linkText) + is.null(partialLinkText) +
      is.null(xpath) != 3) {
    stop(
      "Specify one of 'css', 'linkText', ",
      "'partialLinkText' and 'xpath'"
    )
  }

  if (!is.null(css)) {
    list(using = "css selector", value = css)

  } else if (!is.null(linkText)) {
    list(using = "link text", value = linkText)

  } else if (!is.null(partialLinkText)) {
    list(using = "partial link text", value = partialLinkText)

  } else if (!is.null(xpath)) {
    list(using = "xpath", value = xpath)
  }
}


session_findElements <- function(self, private, css, linkText,
                                  partialLinkText, xpath) {
  "!DEBUG session_findElements `css %||% linkText %||% partialLinkText %||% xpath`"
  find_expr <- parse_find_expr(css, linkText, partialLinkText, xpath)

  response <- private$makeRequest(
    "FIND ELEMENTS",
    list(
      using = find_expr$using,
      value = find_expr$value
    )
  )

  lapply(response$value, function(el) {
    Element$new(
      id = el$ELEMENT,
      session = self,
      session_private = private
    )
  })
}


session_getActiveElement <- function(self, private) {

  "!DEBUG session_getActiveElement"
  response <- private$makeRequest(
    "GET ACTIVE ELEMENT"
  )

  Element$new(
    id = response$value$ELEMENT,
    session = self,
    session_private = private
  )
}


session_getSource <- function(self, private) {
  "!DEBUG session_getSource"
  response <- private$makeRequest(
    "GET PAGE SOURCE"
  )

  response$value
}

#' @importFrom showimage show_image

session_takeScreenshot <- function(self, private, file) {

  "!DEBUG session_takeScreenshot"
  if (!is.null(file)) assert_filename(file)

  response <- private$makeRequest(
    "TAKE SCREENSHOT"
  )

  handle_screenshot(response, file)

  invisible(self)
}

#' @importFrom base64enc base64decode

handle_screenshot <- function(response, file) {

  if (is.null(output <- file)) {
    output <- tempfile(fileext = ".png")
    on.exit(unlink(output))
  }

  writeBin(
    base64decode(response$value),
    output
  )

  ## if 'file' was NULL, then show it on the graphics device
  if (is.null(file)) show_image(output)
}


session_getWindow <- function(self, private) {

  "!DEBUG session_getWindow"
  response <- private$makeRequest(
    "GET WINDOW HANDLE"
  )

  Window$new(
    id = response$value,
    session = self,
    session_private = private
  )
}

session_getAllWindows <- function(self, private) {

  "!DEBUG session_getAllWindows"
  response <- private$makeRequest(
    "GET WINDOW HANDLES"
  )

  lapply(response$value, function(id) {
    Window$new(
      id = id,
      session = self,
      session_private = private
    )
  })
}

prepare_execute_args <- function(...) {
  args <- list(...)
  assert_unnamed(args)

  lapply(args, function(x) {
    if (inherits(x, "Element") && inherits(x, "R6")) {
      list(ELEMENT = x$.__enclos_env__$private$id)
    } else {
      x
    }
  })
}

parse_script_response <- function(self, private, value) {
  if (is.list(value) && length(value) == 1 && !is.null(names(value)) &&
      names(value) == "ELEMENT" && is.character(value[[1]]) &&
      length(value[[1]]) == 1) {
    ## Single element
    Element$new(value[[1]], self, private)

  } else if (is.list(value)) {
    ## List of things, look if one of them is an element
    lapply(value, parse_script_response, self = self, private = private)

  } else {
    ## Do not touch
    value
  }
}

session_executeScript <- function(self, private, script, ...) {

  "!DEBUG session_executeScript"

  assert_string(script)

  args <- prepare_execute_args(...)

  response <- private$makeRequest(
    "EXECUTE SCRIPT",
    list(script = script, args = args)
  )

  parse_script_response(self, private, response$value)
}

session_executeScriptAsync <- function(self, private, script, ...) {

  "!DEBUG session_executeScriptAsync"

  assert_string(script)

  args <- prepare_execute_args(...)

  response <- private$makeRequest(
    "EXECUTE ASYNC SCRIPT",
    list(script = script, args = args)
  )

  parse_script_response(self, private, response$value)
}

session_setTimeout <- function(self, private, script, pageLoad,
                                implicit) {

  "!DEBUG session_setTimeout"

  if (!is.null(script)) {
    assert_timeout(script)
    private$makeRequest(
      "SET TIMEOUT",
      list(type = "script", ms = script)
    )
  }

  if (!is.null(pageLoad)) {
    assert_timeout(pageLoad)
    private$makeRequest(
      "SET TIMEOUT",
      list(type = "page load", ms = pageLoad)
    )
  }

  if (!is.null(implicit)) {
    assert_timeout(implicit)
    private$makeRequest(
      "SET TIMEOUT",
      list(type = "implicit", ms = implicit)
    )
  }

  invisible(self)
}

session_moveMouseTo <- function(self, private, xoffset, yoffset) {

  "!DEBUG session_moveMouseTo"

  assert_count(xoffset)
  assert_count(yoffset)

  private$makeRequest(
    "MOVE MOUSE TO",
    list(xoffset = xoffset, yoffset = yoffset)
  )

  invisible(self)
}

session_button <- function(self, private, type, button) {
  "!DEBUG session_button `type` `button`"

  assert_mouse_button(button)

  private$makeRequest(
    toupper(type),
    list(button = button)
  )

  invisible(self)
}

session_click <- function(self, private, button) {
  "!DEBUG session_click `button`"
  session_button(self, private, "click", button)
}

session_doubleClick <- function(self, private, button) {
  "!DEBUG session_doubleClick `button`"
  session_button(self, private, "doubleclick", button)
}

session_mouseButtonDown <- function(self, private, button) {
  "!DEBUG session_mouseButtonDown `button`"
  session_button(self, private, "buttondown", button)
}

session_mouseButtonUp <- function(self, private, button) {
  "!DEBUG session_mouseButtonUp `button`"
  session_button(self, private, "buttonup", button)
}
