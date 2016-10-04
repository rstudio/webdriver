
#' @importFrom curl new_handle new_pool multi_add multi_run

wait_for_http <- function(url, timeout = 5000, interval = 100) {

  end <- Sys.time() + timeout / 1000.0

  try_1 <- function(timeout) {
    h <- new_handle(url = url, connecttimeout = timeout)
    m <- new_pool()
    multi_add(h, pool = m)
    out <- tryCatch(
      multi_run(timeout = timeout, pool = m),
      error = function(e) { print (e) ; FALSE }
    )
    if (identical(out, FALSE)) return(FALSE)
    out$success == 1
  }

  remaining <- end - Sys.time()
  while (remaining > 0) {
    if (try_1(as.numeric(remaining))) return(TRUE)
    Sys.sleep(interval / 1000.0)
    remaining <- end - Sys.time()
  }

  FALSE
}
