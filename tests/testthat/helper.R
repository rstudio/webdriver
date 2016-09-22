
start_web_server <- function(dir) {

  Rbin <- file.path(R.home("bin"), "R")

  port <- random_port()

  rcmd <- paste0(
    "servr::httd('", dir, "', browser = FALSE, port = ", port, ")")

  cmd <- paste(Rbin, "-q -e", shQuote(rcmd))

  ws <- processx::process$new(commandline = cmd)

  if (! ws$is_alive()) {
    stop(
      "Failed to start phantomjs. Error: ",
      strwrap(ws$read_error_lines())
    )
  }

  baseurl <- paste0("http://127.0.0.1:", port)
  url <- function(x) paste0(baseurl, x)
  list(process = ws, port = port, baseurl = baseurl, url = url)
}

stop_web_server <- function(server) {
  server$process$kill()
}

start_phantomjs <- function() {
  check_external("phantomjs")
  port <- random_port()

  cmd <- paste0("phantomjs --proxy-type=none --webdriver=127.0.0.1:", port)
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
