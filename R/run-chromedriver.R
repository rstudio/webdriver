
#' Start up chromedriver on localhost, and a random port
#'
#' Throws an error if chromedriver cannot be found, or cannot be
#' started. It works with a timeout of five seconds.
#'
#' @return A list of \code{process}, the \code{processx::process} object,
#'   and \code{port}, the local port where chromedriver is running.
#'
#' @importFrom processx process
#' @export

run_chromedriver <- function() {
  if (Sys.which("chromedriver") == "") {
    stop("chromedriver must in the path")
  }

  host <- "127.0.0.1"
  port <- random_port()

  cmd <- sprintf("chromedriver --port=%d", port)

  cd <- process$new(commandline = cmd)
  if (! cd$is_alive()) {
    stop(
      "Failed to start phantomjs. Error: ",
      strwrap(cd$read_error_lines())
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

  list(process = cd, port = port)
}
