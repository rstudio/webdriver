
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

  if (is.character(cont)) {
    # In rare cases the error content is just a string. This can happen, for
    # example, when there is a problem loading execute_script.js.
    # https://github.com/rstudio/shinytest/issues/165
    message <- cont
    # Need to manually set status code for UnknownError. From:
    # https://github.com/detro/ghostdriver/blob/873c9d6/src/errors.js#L135
    status <- 13L

    } else {
    json <- fromJSON(
      cont[["value"]][["message"]],
      simplifyVector = FALSE
    )
    message <- json[["errorMessage"]] %||% "WebDriver error"
    status <- cont$status
  }


  structure(
    list(message = message, status = status, call = call),
    class = c("webdriver_error", class, "condition")
  )
}
