
#' Start up phantomjs on localhost, and a random port
#'
#' Throws and error if phantom cannot be found, or cannot be started.
#' It works with a timeout of five seconds.
#'
#' @param debug_level Phantom.js debug level, possible values:
#'   \code{"INFO"}, \code{"ERROR"}, \code{"WARN"}, \code{"DEBUG"}.
#' @return A list of \code{process}, the \code{processx::process} object,
#'   and \code{port}, the local port where phantom is running.
#'
#' @importFrom processx process
#' @export

run_phantomjs <- function(debug_level = c("INFO", "ERROR", "WARN", "DEBUG")) {

  debug_level <- match.arg(debug_level)

  phexe <- find_phantom()
  if (is.null(phexe)) stop("No phantom.js, exiting.")

  host <- "127.0.0.1"
  port <- random_port()

  cmd <- sprintf(
    "%s --proxy-type=none --webdriver=%s:%d --webdriver-loglevel=%s",
    shQuote(phexe), host, port, debug_level
  )
  ph <- process$new(commandline = cmd)

  if (! ph$is_alive()) {
    stop(
      "Failed to start phantomjs. Error: ",
      strwrap(ph$read_error_lines())
    )
  }

  ## Wait until has started and answers queries
  url <- paste0("http://", host, ":", port)
  res <- wait_for_http(url)
  if (!res) {
    stop(
      "Cannot start phantom.js, or cannot connect to it",
      strwrap(ph$read_error_lines())
    )
  }

  list(process = ph, port = port)
}
