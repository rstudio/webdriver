
start_web_server <- function(dir) {

  Sys.unsetenv("R_TESTS")

  Rexe <- if (is_windows()) "R.exe" else "R"
  Rbin <- file.path(R.home("bin"), Rexe)

  host <- Sys.getenv("SERVR_HOST", "127.0.0.1")
  port <- as.numeric(Sys.getenv("SERVR_PORT", random_port()))

  rcmd <- sprintf(
    "servr::httd('%s', browser = FALSE, host = '%s', port = %d)",
    dir, host, port
  )

  cmd <- paste(Rbin, "-q -e", shQuote(rcmd))

  ws <- processx::process$new(commandline = cmd)

  if (! ws$is_alive()) {
    stop(
      "Failed to start servr web server. Error: ",
      strwrap(ws$read_error_lines())
    )
  }

  baseurl <- sprintf("http://%s:%d", host, port)
  url <- function(x) paste0(baseurl, x)
  list(process = ws, port = port, baseurl = baseurl, url = url)
}

stop_web_server <- function(server) {
  server$process$kill()
}

start_phantomjs <- function() {

  phexe <- find_phantom()
  if (is.null(phexe)) stop("No phantom.js, exiting")

  host <- Sys.getenv("WEBDRIVER_HOST", "127.0.0.1")
  port <- as.numeric(Sys.getenv("WEBDRIVER_PORT", random_port()))

  cmd <- sprintf(
    "%s --proxy-type=none --webdriver=%s:%d",
    shQuote(phexe), host, port
  )
  ph <- processx::process$new(commandline = cmd)

  if (! ph$is_alive()) {
    stop(
      "Failed to start phantomjs. Error: ",
      strwrap(ph$read_error_lines())
    )
  }

  ## Need to wait for phantomjs to initialize
  Sys.sleep(1)

  list(process = ph, port = port)
}

check_external <- function(x) {
  if (Sys.which(x) == "") {
    stop("Cannot start '", x, "', make sure it is in the path")
  }
}

random_port <- function(min = 3000, max = 9000) {
  if (min < max) sample(min:max, 1) else min
}

stop_phantomjs <- function(phantom) {
  phantom$process$kill()
}
