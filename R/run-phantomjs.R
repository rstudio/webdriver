
random_port <- function(min = 3000, max = 9000) {
  if (min < max) sample(min:max, 1) else min
}

#' Start up phantomjs on localhost, and a random port
#'
#' Throws and error if phantom cannot be found, or cannot be started. It works
#' with a timeout of five seconds.
#'
#' @param debugLevel Phantom.js debug level, possible values: \code{"INFO"},
#'   \code{"ERROR"}, \code{"WARN"}, \code{"DEBUG"}.
#' @param timeout How long to wait (in milliseconds) for the webdriver
#'   connection to be established to the phantomjs process.
#'
#' @return A list of \code{process}, the \code{callr::process} object, and
#'   \code{port}, the local port where phantom is running.
#'
#' @importFrom callr process
#' @export

run_phantomjs <- function(debugLevel = c("INFO", "ERROR", "WARN", "DEBUG"),
                          timeout = 5000) {

  debugLevel <- match.arg(debugLevel)

  phexe <- find_phantom()
  if (is.null(phexe)) stop("No phantom.js, exiting.")

  host <- "127.0.0.1"
  port <- random_port()

  args <- c(
    "--proxy-type=none",
    sprintf("--webdriver=%s:%d", host, port),
    sprintf("--webdriver-loglevel=%s", debugLevel)
  )

  # The env vars are a workaround for :
  # https://github.com/rstudio/shinytest/issues/165#issuecomment-364935112
  withr::with_envvar(get_phantom_envvars(), {
    ph <- process$new(command = phexe, args = args, supervise = TRUE,
                      stdout = tempfile("webdriver-stdout-", fileext = ".log"),
                      stderr = tempfile("webdriver-stderr-", fileext = ".log"))
  })

  if (! ph$is_alive()) {
    stop(
      "Failed to start phantomjs. Error: ",
      strwrap(ph$read_error_lines())
    )
  }

  ## Wait until has started and answers queries
  url <- paste0("http://", host, ":", port)
  res <- wait_for_http(url, timeout = timeout)
  if (!res) {
    stop(
      "Cannot start phantom.js, or cannot connect to it",
      strwrap(ph$read_error_lines())
    )
  }

  list(process = ph, port = port)
}


# Needed for a weird issue in Debian build of phantomjs:
# https://github.com/rstudio/shinytest/issues/165#issuecomment-364935112
get_phantom_envvars <- local({
  # memoize
  vars <- NULL

  function() {
    if (!is.null(vars)) return(vars)

    vars <<- list()

    phexe <- find_phantom()
    if (is.null(phexe)) stop("No phantom.js, exiting.")

    ph <- process$new(command = phexe, args = "--version", stdout = "|", stderr = "|")
    ph$wait(5000)
    if (ph$is_alive()) {
      ph$kill()
      stop("`phantomjs --version` timed out.")
    }
    if (ph$get_exit_status() != 0 &&
        any(grepl("^QXcbConnection: Could not connect to display", ph$read_error_lines())))
    {
      vars$QT_QPA_PLATFORM <<- "offscreen"
    }

    vars
  }
})
