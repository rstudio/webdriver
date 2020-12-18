
random_port <- function(min = 3000, max = 9000) {
  found <- FALSE

  # base::serverSocket was added in R 4.0, and it can be used to check if a port
  # is available before we actually return it. If the function isn't available,
  # we'll just return a random port without checking.
  serverSocket <- get0("serverSocket", as.environment("package:base"),
                       inherits = FALSE)

  if (is.null(serverSocket)) {
    port <- if (min < max) sample(min:max, 1) else min
    return(port)
  }

  # Try up to 20 ports
  n_ports <- min(20, max - min + 1)
  test_ports <- if (min < max) sample(min:max, n_ports) else min
  for (port in test_ports) {
    open_error <- FALSE
    tryCatch(
      {
        s <- serverSocket(port)
        close(s)
      },
      error = function(e) {
        open_error <<- TRUE
      }
    )

    if (!open_error) {
      return(port)
    }
  }

  stop("Unable to find an available port.")
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
    ph <- process$new(
      command = phexe,
      args = args,
      supervise = TRUE,
      stdout = tempfile("webdriver-stdout-", fileext = ".log"),
      stderr = "2>&1"
    )
  })

  if (! ph$is_alive()) {
    stop(
      "Failed to start phantomjs. stdout + stderr:\n",
      paste(collapse = "\n", "> ", readLines(ph$get_output_file()))
    )
  }

  ## Wait until has started and answers queries
  url <- paste0("http://", host, ":", port)
  res <- wait_for_http(url, timeout = timeout)
  if (!res) {
    ph$kill()
    stop(
      "phantom.js started, but cannot connect to it on port ", port,
      ". stdout + stderr:\n",
      paste(collapse = "\n", "> ", readLines(ph$get_output_file()))
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
