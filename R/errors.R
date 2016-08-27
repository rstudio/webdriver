
#' @importFrom httr status_code

report_error <- function(response) {
  if (status_code(response) < 300) {
    invisible(response)
  } else {
    call <- sys.call(-1)
    stop(create_condition(response, "error", call = call))
  }
}

#' @importFrom httr content

create_condition <- function(response,
                             class = c("error", "warning", "message"),
                             call) {

  class <- match.arg(class)

  cont <- content(response)
  json <- fromJSON(
    cont[["value"]][["message"]],
    simplifyVector = FALSE
  )
  message <- json[["errorMessage"]] %||% "WebDriver error"
  status <- cont$status

  structure(
    list(message = message, status = status, call = call),
    class = c("webdriver_error", class, "condition")
  )
}
