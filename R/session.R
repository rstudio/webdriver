
#' WebDriver session
#'
#' Drive a headless phantom.js browser via the WebDriver protocol.
#' It needs phantom.js running in WebDriver mode.
#'
#' @section Usage:
#' \preformatted{s <- session$new(host = "localhost", port = 8910)
#'
#' s$delete()
#' s$status()
#'
#' s$go(url)
#' s$get_url()
#' s$go_back()
#' s$go_forward()
#' s$refresh()
#' s$get_title()
#' s$get_source()
#' s$take_screenshot(file = NULL)
#'
#' s$find_element(css = NULL, link_text = NULL,
#'     partial_link_text = NULL, xpath = NULL)
#' s$find_elements(css = NULL, link_text = NULL,
#'     partial_link_text = NULL, xpath = NULL)
#'
#' s$execute_script(script, ...)
#' s$execute_script_async(script, ...)
#'
#' s$set_timeout(script = NULL, page_load = NULL, implicit = NULL)
#'
#' s$move_mouse_to(xoffset = 0, yoffset = 0)
#' s$click(button = c("left", "middle", "right"))
#' s$double_click(button = c("left", "middle", "right"))
#' s$mouse_button_down(button = c("left", "middle", "right"))
#' s$mouse_button_up(button = c("left", "middle", "right"))
#'
#' s$read_log(type = c("browser", "har"))
#' s$get_log_types()
#'
#' s$wait_for(expr, check_interval = 100, timeout = 3000)
#' }
#'
#' @section Arguments:
#'\describe{
#'   \item{s}{A \code{session} object.}
#'   \item{host}{Host name of phantom.js.}
#'   \item{port}{Port of phantom.js.}
#'   \item{url}{URL to nagivate to.}
#'   \item{file}{File name to save the screenshot to. If \code{NULL}, then
#'     it will be shown on the R graphics device.}
#'   \item{css}{Css selector to find an HTML element.}
#'   \item{link_text}{Find HTML elements based on their \code{innerText}.}
#'   \item{partial_link_text}{Find HTML elements based on their
#'     \code{innerText}. It uses partial matching.}
#'   \item{xpath}{Find HTML elements using XPath expressions.}
#'   \item{script}{For \code{execute_script} and
#'     \code{execute_script_async}. JavaScript code to execute. It will be
#'     placed in the body of a function.}
#'   \item{...}{Arguments to the script, they will be put in a list
#'     called arguments. \code{\link{element}} objects are automatically
#'     transformed to DOM element in JavaScript.}
#'   \item{script}{For \code{set_timeout}. Script execution timeout,
#'     in milliseconds. More below.}
#'   \item{page_load}{Page load timeout, in milliseconds. More below.}
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
#'   \item{check_interval}{How often to check for the condition, in
#'     milliseconds.}
#'   \item{timeout}{Timeout for the condition, in milliseconds.}
#' }
#'
#' @section Details:
#'
#' \code{s$new()} creates a new WebDriver session.
#'
#' \code{s$delete()} deletes a WebDriver session.
#'
#' \code{s$status()} returns a status message from the server. It is a
#' named list, and contains version numbers and capabilities.
#'
#' \code{s$go()} navigates to the supplied URL.
#'
#' \code{s$get_url()} returns the current URL.
#'
#' \code{s$go_back()} is like the web browser's back button. It goes back
#' to the previous page.
#'
#' \code{s$go_forward()} is like the web browser's forward button.
#'
#' \code{s$refresh()} is like the web browser's refresh button.
#'
#' \code{s$get_title()} returns the title of the current page.
#'
#' \code{s$get_source()} returns the complete HTML source of a page,
#' in a character scalar.
#'
#' \code{s$take_screenshot()} takes a screenshot of the current page.
#' You can save it to a PNG file with the \code{file} argument, or
#' show it on the graphics device (if \code{file} is \code{NULL}).
#'
#' \code{s$find_element()} finds a HTML element using a CSS selector,
#' XPath expression, or the \code{innerHTML} of the element. If multiple
#' elements match, then the first one is returned. The return value
#' is an \code{\link{element}} object.
#'
#' \code{s$find_elements()} finds HTML elements using a CSS selector,
#' XPath expression, or the \code{innerHTML} of the element. All matching
#' elements are returned in a list of \code{\link{element}} objects.
#'
#' \code{s$execute_script()} executes JavaScript code. It places the code
#' in the body of a function, and then calls the function with the
#' additional arguments. These can be accessed from the function via the
#' \code{arguments} array. Returned DOM elements are automatically
#' converted to \code{\link{element}} objects, even if they are inside
#' a list (or list of list, etc.).
#'
#' \code{s$execute_script_async()} is similar, for asynchronous execution.
#' It place the script in a body of a function, and then calls the function
#' with the additional arguments and a callback function as the last
#' argument. The script must call this callback function when it
#' finishes its work. The first argument passed to the callback function
#' is returned. Returned DOM elements are automatically converted to
#' \code{\link{element}} objects, even if they are inside a list (or list
#' of list, etc.).
#'
#' \code{s$set_timeout()} sets various timeouts. The \sQuote{script}
#' timeout specifies a time to wait for scripts to run. The
#' sQuote{page load} timeout specifies a time to wait for the page loading
#' to complete. The \sQuote{implicit} specifies a time to wait for the
#' implicit element location strategy when locating elements. Their defaults
#' are different in the standard and in Phantom.js. In Phantom.js the
#' \sQuote{script} and \sQuote{page load} timeouts are set to infinity,
#' and the \sQuote{implicit} waiting time is 200ms.
#'
#' \code{s$move_mouse_to()} moves the mouse cursor by the specified
#' offsets.
#'
#' \code{s$click()} clicks the mouse at its current position, using
#' the specified button.
#'
#' \code{s$double_click()} emulates a double click with the specified
#' mouse button.
#'
#' \code{s$button_down()} emulates pressing the specified mouse button
#' down (and keeping it down).
#'
#' \code{s$button_up()} emulates releasing the specified mouse button.
#'
#' \code{s$get_log_types()} returns the log types supported by the
#' server, in a character vector.
#'
#' \code{s$read_log()} returns the log messages since the last
#' \code{read_log} call, in a data frame with columns \code{timestamp},
#' \code{level} and \code{message}.
#'
#' \code{s$wait_for()} waits until a JavaScript expression evaluates
#' to \code{true}, or a timeout happens. It returns \code{TRUE} is the
#' expression evaluated to \code{true}, possible after some waiting.
#'
#' @seealso The WebDriver standard at
#' \url{https://w3c.github.io/webdriver/webdriver-spec.html}.
#'
#' @importFrom R6 R6Class
#' @name session
NULL

#' @export

session <- R6Class(
  "session",
  public = list(

    initialize = function(host = "localhost", port = 8910)
      session_initialize(self, private, host, port),

    delete = function()
      session_delete(self, private),

    get_status = function()
      session_get_status(self, private),

    go = function(url)
      session_go(self, private, url),

    get_url = function()
      session_get_url(self, private),

    go_back = function()
      session_go_back(self, private),

    go_forward = function()
      session_go_forward(self, private),

    refresh = function()
      session_refresh(self, private),

    get_title = function()
      session_get_title(self, private),

    get_source = function()
      session_get_source(self, private),

    take_screenshot = function(file = NULL)
      session_take_screenshot(self, private, file = file),

    ## Elements ------------------------------------------------

    find_element = function(css = NULL, link_text = NULL,
      partial_link_text = NULL, xpath = NULL)
      session_find_element(self, private, css, link_text,
                           partial_link_text, xpath),

    find_elements = function(css = NULL, link_text = NULL,
      partial_link_text = NULL, xpath = NULL)
      session_find_elements(self, private, css, link_text,
                            partial_link_text, xpath),

    get_active_element = function()
      session_get_active_element(self, private),

    ## Windows -------------------------------------------------

    get_window = function()
      session_get_window(self, private),

    get_all_windows = function()
      session_get_all_windows(self, private),

    ## Execute script ------------------------------------------

    execute_script = function(script, ...)
      session_execute_script(self, private, script, ...),

    execute_script_async = function(script, ...)
      session_execute_script_async(self, private, script, ...),

    ## Timeouts ------------------------------------------------

    set_timeout = function(script = NULL, page_load = NULL,
      implicit = NULL)
      session_set_timeout(self, private, script, page_load, implicit),

    ## Move mouse, clicks --------------------------------------

    move_mouse_to = function(xoffset, yoffset)
      session_move_mouse_to(self, private, xoffset, yoffset),

    click = function(button = c("left", "middle", "right"))
      session_click(self, private, button),

    double_click = function(button = c("left", "middle", "right"))
      session_double_click(self, private, button),

    mouse_button_down = function(button = c("left", "middle", "right"))
      session_mouse_button_down(self, private, button),

    mouse_button_up = function(button = c("left", "middle", "right"))
      session_mouse_button_up(self, private, button),

    ## Logs ----------------------------------------------------

    get_log_types = function()
      session_get_log_types(self, private),

    read_log = function(type = "browser")
      session_read_log(self, private, type),

    ## Polling for a condition ---------------------------------

    wait_for = function(expr, check_interval = 100, timeout = 3000)
      session_wait_for(self, private, expr, check_interval, timeout)
  ),

  private = list(

    host = NULL,
    port = NULL,
    session_id = NULL,
    parameters = NULL,
    num_log_lines_shown = 0,

    make_request = function(endpoint, data = NULL, params = NULL,
      headers = NULL)
      session_make_request(self, private, endpoint, data, params, headers)
  )
)


#' @importFrom jsonlite unbox

session_initialize <- function(self, private, host, port) {

  assert_string(host)
  assert_port(port)

  private$host <- host
  private$port <- port
  private$num_log_lines_shown <- 0

  response <- private$make_request(
    "NEW SESSION",
    list(
      desiredCapabilities = list(
        browserName = unbox("phantomjs"),
        driverName  = unbox("ghostdriver")
      )
    )
  )

  private$session_id = response$sessionId %||% stop("Got no session_id")
  private$parameters = response$value

  reg.finalizer(self, function(e) e$delete(), TRUE)

  invisible(self)
}


session_delete <- function(self, private) {

  if (! is.null(private$session_id)) {
    response <- private$make_request(
      "DELETE SESSION",
      list()
    )
  }

  private$session_id <- NULL

  invisible()
}

session_get_status <- function(self, private) {
  response <- private$make_request(
    "STATUS"
  )

  response$value
}

session_go <- function(self, private, url) {

  assert_url(url)

  private$make_request(
    "GO",
    list("url" = unbox(url))
  )

  invisible(self)
}


session_get_url <- function(self, private) {

  response <- private$make_request(
    "GET CURRENT URL"
  )

  response$value
}


session_go_back <- function(self, private) {

  private$make_request(
    "BACK"
  )

  invisible(self)
}


session_go_forward <- function(self, private) {

  private$make_request(
    "FORWARD"
  )

  invisible(self)
}


session_refresh <- function(self, private) {

  private$make_request(
    "REFRESH"
  )

  invisible(self)
}


session_get_title <- function(self, private) {
  response <- private$make_request(
    "GET TITLE"
  )

  response$value
}


session_find_element <- function(self, private, css, link_text,
                                 partial_link_text, xpath) {

  find_expr <- parse_find_expr(css, link_text, partial_link_text, xpath)

  response <- private$make_request(
    "FIND ELEMENT",
    list(
      using = unbox(find_expr$using),
      value = unbox(find_expr$value)
    )
  )

  element$new(
    id = response$value$ELEMENT,
    session = self,
    session_private = private
  )
}


parse_find_expr <- function(css, link_text, partial_link_text, xpath) {

  if (is.null(css) + is.null(link_text) + is.null(partial_link_text) +
      is.null(xpath) != 3) {
    stop(
      "Specify one of 'css', 'link_text', ",
      "'partial_link_text' and 'xpath'"
    )
  }

  if (!is.null(css)) {
    list(using = "css selector", value = css)

  } else if (!is.null(link_text)) {
    list(using = "link text", value = link_text)

  } else if (!is.null(partial_link_text)) {
    list(using = "partial link text", value = partial_link_text)

  } else if (!is.null(xpath)) {
    list(using = "xpath", value = xpath)
  }
}


session_find_elements <- function(self, private, css, link_text,
                                  partial_link_text, xpath) {
  find_expr <- parse_find_expr(css, link_text, partial_link_text, xpath)

  response <- private$make_request(
    "FIND ELEMENTS",
    list(
      using = unbox(find_expr$using),
      value = unbox(find_expr$value)
    )
  )

  lapply(response$value, function(el) {
    element$new(
      id = el$ELEMENT,
      session = self,
      session_private = private
    )
  })
}


session_get_active_element <- function(self, private) {

  response <- private$make_request(
    "GET ACTIVE ELEMENT"
  )

  element$new(
    id = response$value$ELEMENT,
    session = self,
    session_private = private
  )
}


session_get_source <- function(self, private) {
  response <- private$make_request(
    "GET PAGE SOURCE"
  )

  response$value
}

#' @importFrom jsonlite base64_dec
#' @importFrom showimage show_image

session_take_screenshot <- function(self, private, file) {

  if (!is.null(file)) assert_filename(file)

  response <- private$make_request(
    "TAKE SCREENSHOT"
  )

  handle_screenshot(response, file)

  invisible(self)
}


handle_screenshot <- function(response, file) {

  if (is.null(output <- file)) {
    output <- tempfile(fileext = ".png")
    on.exit(unlink(output))
  }

  writeBin(
    base64_dec(response$value),
    output
  )

  ## if 'file' was NULL, then show it on the graphics device
  if (is.null(file)) show_image(output)
}


session_get_window <- function(self, private) {

  response <- private$make_request(
    "GET WINDOW HANDLE"
  )

  window$new(
    id = response$value,
    session = self,
    session_private = private
  )
}

session_get_all_windows <- function(self, private) {

  response <- private$make_request(
    "GET WINDOW HANDLES"
  )

  lapply(response$value, function(id) {
    window$new(
      id = id,
      session = self,
      session_private = private
    )
  })
}

prepare_execute_args <- function(...) {
  args <- list(...)
  for (i in seq_along(args)) {
    x <- args[[i]]
    if (inherits(x, "element") && inherits(x, "R6")) {
      args[[i]] <- list(ELEMENT = unbox(x$.__enclos_env__$private$id))
    } else {
      args[[i]] <- unbox(x)
    }
  }
  args
}

parse_script_response <- function(self, private, value) {
  if (is.list(value) && length(value) == 1 && names(value) == "ELEMENT" &&
      is.character(value[[1]]) && length(value[[1]]) == 1) {
    ## Single element
    element$new(value[[1]], self, private)

  } else if (is.list(value)) {
    ## List of things, look if one of them is an element
    lapply(value, parse_script_response, self = self, private = private)

  } else {
    ## Do not touch
    value
  }
}

session_execute_script <- function(self, private, script, ...) {

  assert_string(script)

  args <- prepare_execute_args(...)

  response <- private$make_request(
    "EXECUTE SCRIPT",
    list(script = unbox(script), args = args)
  )

  parse_script_response(self, private, response$value)
}

session_execute_script_async <- function(self, private, script, ...) {

  assert_string(script)

  args <- prepare_execute_args(...)

  response <- private$make_request(
    "EXECUTE ASYNC SCRIPT",
    list(script = unbox(script), args = args)
  )

  parse_script_response(self, private, response$value)
}

session_set_timeout <- function(self, private, script, page_load,
                                implicit) {

  if (!is.null(script)) {
    assert_timeout(script)
    private$make_request(
      "SET TIMEOUT",
      list(type = unbox("script"), ms = unbox(script))
    )
  }

  if (!is.null(page_load)) {
    assert_timeout(page_load)
    private$make_request(
      "SET TIMEOUT",
      list(type = unbox("page load"), ms = unbox(page_load))
    )
  }

  if (!is.null(implicit)) {
    assert_timeout(implicit)
    private$make_request(
      "SET TIMEOUT",
      list(type = unbox("implicit"), ms = unbox(implicit))
    )
  }

  invisible(self)
}

session_move_mouse_to <- function(self, private, xoffset, yoffset) {

  assert_count(xoffset)
  assert_count(yoffset)

  private$make_request(
    "MOVE MOUSE TO",
    list(xoffset = unbox(xoffset), yoffset = unbox(yoffset))
  )

  invisible(self)
}

session_button <- function(self, private, type, button) {
  assert_mouse_button(button)

  private$make_request(
    toupper(type),
    list(button = unbox(button))
  )

  invisible(self)
}

session_click <- function(self, private, button) {
  session_button(self, private, "click", button)
}

session_double_click <- function(self, private, button) {
  session_button(self, private, "doubleclick", button)
}

session_mouse_button_down <- function(self, private, button) {
  session_button(self, private, "buttondown", button)
}

session_mouse_button_up <- function(self, private, button) {
  session_button(self, private, "buttonup", button)
}
