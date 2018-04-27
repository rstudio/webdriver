
#' @importFrom httr status_code

report_error <- function(response) {
  if (status_code(response) < 300) {
    invisible(response)
  } else {
    call <- sys.call(-1)

    cond <- create_condition(response, "error", call = call)

    # Sometimes the message from create_condition can be very long and will be
    # truncated when printed. This prints the maximum possible amount.
    if (nchar(cond$message) > getOption("warning.length")) {
      old_options <- options(warning.length = 8170)
      on.exit(options(old_options))
    }

    stop(cond)
  }
}

#' @importFrom httr content

create_condition <- function(response,
                             class = c("error", "warning", "message"),
                             call) {

  class <- match.arg(class)

  message <- NULL
  status <- NULL

  if (grepl("^application/json", headers(response)[["content-type"]])) {
    try({
      cont <- content(response)
      # This can error if `cont` doesn't include the fields we want.
      json <- fromJSON(
        cont[["value"]][["message"]],
        simplifyVector = FALSE
      )
      message <- json[["errorMessage"]] %||% "WebDriver error"
      status <- cont$status
    })
  }

  # We can end up in this block if:
  # * The error content is just a string, or raw HTML. This can happen, for
  #   example, when there is a problem loading execute_script.js.
  #   https://github.com/rstudio/shinytest/issues/165
  #   https://github.com/rstudio/shinytest/issues/190
  # * The `cont` object was JSON, but did not include the needed fields.
  if (is.null(status)) {
    message <- content(response, "text")
    # Need to manually set status code for UnknownError. From:
    # https://github.com/detro/ghostdriver/blob/873c9d6/src/errors.js#L135
    status <- 13L
  }


  structure(
    list(message = message, status = status, call = call),
    class = c("webdriver_error", class, "condition")
  )
}
