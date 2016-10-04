
random_port <- function(min = 3000, max = 9000) {
  if (min < max) sample(min:max, 1) else min
}

#' Start up phantomjs on localhost, and a random port
#'
#' Throws and error if phantom cannot be found, or cannot be started.
#' It works with a timeout of five seconds.
#' 
#' @return A list of \code{process}, the \code{processx::process} object,
#'   and \code{port}, the local port where phantom is running.
#'
#' @importFrom processx process
#' @export

run_phantomjs <- function() {

  phexe <- find_phantom()
  if (is.null(phexe)) stop("No phantom.js, exiting.")

  host <- "127.0.0.1"
  port <- random_port()

  cmd <- sprintf(
    "%s --proxy-type=none --webdriver=%s:%d",
    shQuote(phexe), host, port
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
