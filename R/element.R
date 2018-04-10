
#' HTML element
#'
#' @section Usage:
#' \preformatted{e <- s$findElement(css = NULL, linkText = NULL,
#'     partialLinkText = NULL, xpath = NULL)
#'
#' e$findElement(css = NULL, linkText = NULL,
#'     partialLinkText = NULL, xpath = NULL)
#' e$findElements(css = NULL, linkText = NULL,
#'     partialLinkText = NULL, xpath = NULL)
#'
#' e$isSelected()
#' e$getValue()
#' e$setValue(value)
#' e$getAttribute(name)
#' e$getClass()
#' e$getCssValue(name)
#' e$getText()
#' e$getName()
#' e$getData(name)
#' e$getRect()
#' e$isEnabled()
#' e$click()
#' e$clear()
#' e$sendKeys(...)
#' e$moveMouseTo(xoffset = NULL, yoffset = NULL)
#'
#' e$executeScript(script, ...)
#' e$executeScriptAsync(script, ...)
#' }
#'
#' @section Arguments:
#' \describe{
#'   \item{e}{An \code{Element} object.}
#'   \item{s}{A \code{\link{Session}} object.}
#'   \item{css}{Css selector to find an HTML element.}
#'   \item{linkText}{Find \code{<a>} HTML elements based on their
#'     \code{innerText}.}
#'   \item{partialLinkText}{Find \code{<a>} HTML elements based on their
#'     \code{innerText}. It uses partial matching.}
#'   \item{xpath}{Find HTML elements using XPath expressions.}
#'   \item{name}{String scalar, named of attribute, property or css key.
#'     For \code{getData}, the key of the data attribute.}
#'   \item{xoffset}{Horizontal offset for mouse movement, relative to the
#'     position of the element. If at least of of \code{xoffset} and
#'     \code{yoffset} is \code{NULL}, then they are ignored.}
#'   \item{yoffset}{Vertical offset for mouse movement, relative to the
#'     position of the element. If at least of of \code{xoffset} and
#'     \code{yoffset} is \code{NULL}, then they are ignored.}
#'   \item{value}{Value to set, a character string.}
#'   \item{...}{For \code{sendKeys} the keys to send, see
#'     \code{\link{key}}. For \code{executeScript} and
#'     \code{executeScriptAsync} argument to supply to the script.}
#' }
#'
#' @section Details:
#'
#' To create \code{Element} objects, you need to use the \code{findElement}
#' (or \code{findElement}) method of a \code{\link{Session}} object.
#'
#' \code{e$findElement()} finds the \emph{next} HTML element from the
#' current one. You need to specify one of the \code{css}, \code{linkText},
#' \code{partialLinkText} and \code{xpath} arguments. It returns a new
#' \code{Element} object.
#'
#' \code{e$findElements()} finds all matching HTML elements starting from
#' the current element. You need to specify one of the \code{css},
#' \code{linkText}, \code{partialLinkText} and \code{xpath} arguments.
#' It returns a list of newly created \code{Element} objects.
#'
#' \code{e$isSelected()} returns \code{TRUE} is the element is currently
#' selected, and \code{FALSE} otherwise.
#'
#' \code{e$getValue()} returns the value of an input element, it is a
#' shorthand for \code{e$getAttribute("value")}.
#'
#' \code{e$setValue()} sets the value of an input element, it is
#' essentially equivalent to sending keys via \code{e$sendKeys()}.
#'
#' \code{e$getAttribute()} queries an arbitrary HTML attribute. It is
#' does not exist, \code{NULL} is returned.
#'
#' \code{e$getClass()} uses \code{e$getAttribute} to parse the
#' \sQuote{class} attribute into a character vector.
#'
#' \code{e$getCssValue()} queries a CSS property of an element.
#'
#' \code{e$getText()} returns the \code{innerText} on an element.
#'
#' \code{e$getName()} returns the tag name of an element.
#'
#' \code{e$getData()} is a shorthand for querying \code{data-*} attributes.
#'
#' \code{e$getRect()} returns the \sQuote{rectangle} of an element. It is
#' named list with components \code{x}, \code{y}, \code{height} and
#' \code{width}.
#'
#' \code{e$isEnabled()} returns \code{TRUE} if the element is enabled,
#' \code{FALSE} otherwise.
#'
#' \code{e$click()} scrolls the element into view, and clicks the
#' in-view centre point of it.
#'
#' \code{e$clear()} scrolls the element into view, and then attempts to
#' clear its value, checkedness or text content.
#'
#' \code{e$sendKeys()} scrolls the form control element into view, and
#' sends the provided keys to it. See \code{\link{key}} for a list of
#' special keys that can be sent.
#'
#' \code{e$uploadFile()} uploads a file to a \code{<input type="file">}
#' element. The \code{filename} argument can contain a single filename,
#' or multiple filenames, for file inputs that can take multiple files.
#'
#' \code{e$moveMouseTo()} moves the mouse cursor to the element, with
#' the specified offsets. If one or both offsets are \code{NULL}, then
#' it places the cursor on the center of the element. If the element is
#' not on the screen, then is scrolls it into the screen first.
#'
#' \code{e$executeScript()} and \code{e$executeScriptAsync()}
#' call the method of the same name on the \code{\link{Session}} object.
#' The first argument of the script (\code{arguments[0]}) will always
#' hold the element object itself.
#'
#' @name Element
#' @importFrom R6 R6Class
NULL

Element <- R6Class(
  "Element",
  public = list(

    initialize = function(id, session, session_private)
      element_initialize(self, private, id, session, session_private),

    findElement = function(css = NULL, linkText = NULL,
      partialLinkText = NULL, xpath = NULL)
      element_findElement(self, private, css, linkText,
                           partialLinkText, xpath),

    findElements = function(css = NULL, linkText = NULL,
      partialLinkText = NULL, xpath = NULL)
      element_findElements(self, private, css, linkText,
                            partialLinkText, xpath),

    isSelected = function()
      element_isSelected(self, private),

    getValue = function()
      element_getValue(self, private),

    setValue = function(value)
      element_setValue(self, private, value),

    getAttribute = function(name)
      element_getAttribute(self, private, name),

    getClass = function()
      element_getClass(self, private),

    getCssValue = function(name)
      element_getCssValue(self, private, name),

    getText = function()
      element_getText(self, private),

    getName = function()
      element_getName(self, private),

    getData = function(name)
      element_getData(self, private, name),

    getRect = function()
      element_getRect(self, private),

    isEnabled = function()
      element_id_enabled(self, private),

    click = function()
      element_click(self, private),

    clear = function()
      element_clear(self, private),

    sendKeys = function(...)
      element_sendKeys(self, private, ...),

    uploadFile = function(filename)
      element_uploadFile(self, private, filename),

    moveMouseTo = function(xoffset = NULL, yoffset = NULL)
      element_moveMouseTo(self, private, xoffset, yoffset),

    executeScript = function(script, ...)
      element_executeScript(self, private, script, ...),

    executeScriptAsync = function(script, ...)
      element_executeScriptAsync(self, private, script, ...)
  ),

  private = list(
    id = NULL,
    session = NULL,
    session_private = NULL
  )
)


element_initialize <- function(self, private, id, session,
                               session_private) {

  assert_string(id)
  assert_session(session)

  private$id <- id
  private$session <- session
  private$session_private <- session_private

  invisible(self)
}


element_findElement <- function(self, private, css, linkText,
                                 partialLinkText, xpath) {

  "!DEBUG element_findElement `css %||% linkText %||% partialLinkText %||% xpath`"
  find_expr <- parse_find_expr(css, linkText, partialLinkText, xpath)

  response <- private$session_private$makeRequest(
    "FIND ELEMENT FROM ELEMENT",
    list(
      using = find_expr$using,
      value = find_expr$value
    ),
    list(elementId = private$id)
  )

  Element$new(
    id = response$value$ELEMENT,
    session = private$session,
    session_private = private$session_private
  )
}


element_findElements <- function(self, private, css, linkText,
                                  partialLinkText, xpath) {

  "!DEBUG element_findElements `css %||% linkText %||% partialLinkText %||% xpath`"
  find_expr <- parse_find_expr(css, linkText, partialLinkText, xpath)

  response <- private$session_private$makeRequest(
    "FIND ELEMENTS FROM ELEMENT",
    list(
      using = find_expr$using,
      value = find_expr$value
    ),
    list(elementId = private$id)
  )

  lapply(response$value, function(el) {
    Element$new(
      id = el$ELEMENT,
      session = private$session,
      session_private = private$session_private
    )
  })
}


element_isSelected <- function(self, private) {

  "!DEBUG element_isSelected `private$id`"
  response <- private$session_private$makeRequest(
    "IS ELEMENT SELECTED",
    params = list(elementId = private$id)
  )

  response$value
}

element_getValue <- function(self, private) {
  "!DEBUG element_getValue `private$id`"
  self$getAttribute("value")
}

element_setValue <- function(self, private, value) {

  "!DEBUG element_setValue `private$id`"
  assert_string(value)

  private$session_private$makeRequest(
    "SET ELEMENT VALUE",
    list(value = I(value)),
    params = list(elementId = private$id)
  )

  invisible(self)
}

element_getAttribute <- function(self, private, name) {

  "!DEBUG element_getAttribute `private$id` `name`"
  assert_string(name)

  response <- private$session_private$makeRequest(
    "GET ELEMENT ATTRIBUTE",
    params = list(elementId = private$id, name = name)
  )

  response$value
}


element_getClass <- function(self, private) {

  "!DEBUG element_getClass `private$id`"
  class <- self$getAttribute("class")
  strsplit(class, "\\s+")[[1]]
}

element_getCssValue <- function(self, private, name) {

  "!DEBUG element_getCssValue `private$id` `name`"
  assert_string(name)

  response <- private$session_private$makeRequest(
    "GET ELEMENT CSS VALUE",
    params = list(elementId = private$id, property_name = name)
  )

  response$value
}


element_getText <- function(self, private) {

  "!DEBUG element_getText `private$id`"
  response <- private$session_private$makeRequest(
    "GET ELEMENT TEXT",
    params = list(elementId = private$id)
  )

  response$value
}

element_getData <- function(self, private, name) {

  "!DEBUG element_getData `private$id` `name`"
  assert_string(name)
  self$getAttribute(paste0("data-", name))
}

element_getName <- function(self, private) {

  "!DEBUG element_getName `private$id`"
  response <- private$session_private$makeRequest(
    "GET ELEMENT TAG NAME",
    params = list(elementId = private$id)
  )

  response$value
}

## GET ELEMENT RECT is not implemented by phantomjs, but we can
## emulate it with two other endpoints: location and size

element_getRect <- function(self, private) {

  "!DEBUG element_getRect `private$id`"
  response1 <- private$session_private$makeRequest(
    "GET ELEMENT LOCATION",
    params = list(elementId = private$id)
  )

  response2 <- private$session_private$makeRequest(
    "GET ELEMENT SIZE",
    params = list(elementId = private$id)
  )

  list(
    x = response1$value$x,
    y = response1$value$y,
    width = response2$value$width,
    height = response2$value$height
  )
}


element_id_enabled <- function(self, private) {

  "!DEBUG element_id_enabled `private$id`"
  response <- private$session_private$makeRequest(
    "IS ELEMENT ENABLED",
    params = list(elementId = private$id)
  )

  response$value
}


element_click <- function(self, private) {

  "!DEBUG element_click `private$id`"
  response <- private$session_private$makeRequest(
    "ELEMENT CLICK",
    params = list(elementId = private$id)
  )

  invisible(private$session)
}


element_clear <- function(self, private) {

  "!DEBUG element_clear `private$id`"
  response <- private$session_private$makeRequest(
    "ELEMENT CLEAR",
    params = list(elementId = private$id)
  )

  invisible(self)
}


element_uploadFile <- function(self, private, filename) {
  # The file upload endpoint requires a CSS selector to pick out the element,
  # so try to contsruct a selector for this element.
  selector <- NULL

  # Attempt id
  id <- self$getAttribute("id")
  if (length(id) > 0 && nzchar(id))
    selector <- paste0("#", id)

  # Attempt name
  if (is.null(selector)) {
    name <- self$getAttribute("name")
    if (length(name) > 0 && nzchar(name))
      selector <- paste0("input[type=file,name=", name, "]")
  }

  # Check that file exists and isn't a directory
  filename <- normalizePath(filename, mustWork = FALSE)
  if (!all(file.exists(filename))) {
    bad_files <- filename[!file.exists(filename)]
    stop(paste(bad_files, collapse = ", "), " not found.")
  }
  if (!all(utils::file_test("-f", filename))) {
    bad_files <- filename[!utils::file_test("-f", filename)]
    stop(bad_files, " is not a regular file.")
  }

  if (is.null(selector))
    stop("File input element must have an id or name attribute.")

  private$session_private$makeRequest(
    "UPLOAD FILE",
    data = list(
      selector = selector,
      filepath = as.list(filename)
    )
  )
}

element_moveMouseTo <- function(self, private, xoffset, yoffset) {

  "!DEBUG element_moveMouseTo `private$id` `xoffset`, `yoffset`"

  if (!is.null(xoffset)) assert_count(xoffset)
  if (!is.null(yoffset)) assert_count(yoffset)

  private$session_private$makeRequest(
    "MOVE MOUSE TO",
    list(
      element = private$id,
      xoffset = xoffset,
      yoffst = yoffset
    )
  )

  invisible(self)
}

element_executeScript <- function(self, private, script, ...) {
  "!DEBUG element_executeScript `private$id`"
  private$session$executeScript(script, self, ...)
}

element_executeScriptAsync <- function(self, private, script, ...) {
  "!DEBUG element_executeScriptAsync `private$id`"
  private$session$executeScript(script, self, ...)
}
