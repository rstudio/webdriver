

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
