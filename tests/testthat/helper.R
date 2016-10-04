
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
  run_phantomjs()
}

check_external <- function(x) {
  if (Sys.which(x) == "") {
    stop("Cannot start '", x, "', make sure it is in the path")
  }
}

stop_phantomjs <- function(phantom) {
  phantom$process$kill()
}
