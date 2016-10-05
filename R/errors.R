
#' @importFrom httr status_code

report_error <- function(self, private, response) {

  if (private$type == "chromedriver") {
    ## chromedriver does not return proper HTTP errors, but
    ## it just sets 'status' in the result
    cont <- content(response)
    if (is.null(cont$status) || !identical(as.integer(cont$status), 0L)) {
      call <- sys.call(-1)
      stop(create_condition(response, "error", call = call))
    } else {
      invisible(response)
    }

  } else {
    if (status_code(response) < 300) {
      invisible(response)
    } else {
      call <- sys.call(-1)
      stop(create_condition(response, "error", call = call))
    }
  }
}

#' @importFrom httr content

create_condition <- function(response,
                             class = c("error", "warning", "message"),
                             call) {

  class <- match.arg(class)

  cont <- content(response)
  msg <- tryCatch(
    fromJSON(
      cont[["value"]][["message"]],
      simplifyVector = FALSE
    )[["errorMessage"]],
    error = function(e) cont[["value"]][["message"]]
  )
  message <- msg %||% "WebDriver error"
  status <- cont$status

  structure(
    list(message = message, status = status, call = call),
    class = c("webdriver_error", class, "condition")
  )
}
