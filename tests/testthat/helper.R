
start_web_server <- function(dir) {

  Sys.unsetenv("R_TESTS")

  Rexe <- if (is_windows()) "Rterm.exe" else "R"
  Rbin <- file.path(R.home("bin"), Rexe)

  host <- Sys.getenv("SERVR_HOST", "127.0.0.1")
  port <- as.numeric(Sys.getenv("SERVR_PORT", random_port()))

  rcmd <- sprintf(
    "servr::httd('%s', browser = FALSE, host = '%s', port = %d)",
    dir, host, port
  )

  cmd <- c(Rbin, "-q", "-e", rcmd)

  ws <- callr::process$new(cmd[1], cmd[-1], supervise = TRUE,
                           stdout = "|", stderr = "|")

  if (! ws$is_alive()) {
    stop(
      "Failed to start servr web server. Error: ",
      strwrap(ws$read_error_lines())
    )
  }

  baseurl <- sprintf("http://%s:%d", host, port)
  url <- function(x) paste0(baseurl, x)

  ## Wait until it answers requests
  res <- wait_for_http(url("/check.html"))
  if (!res) {
    stop(
      "Cannot start web server, or cannot connect to it",
      strwrap(ws$read_error_lines())
    )
  }

  list(process = ws, port = port, baseurl = baseurl, url = url)
}

webdir <- tryCatch(
  file.path(
    rprojroot::find_package_root_file(),
    "tests", "testthat", "web"
  ),
    error = function(e) "web"
)

server <- start_web_server(webdir)
phantom <- run_phantomjs()
