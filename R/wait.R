
#' @importFrom utils packageName

session_wait_for <- function(self, private, expr, check_interval,
                             timeout) {

  "!DEBUG session_wait_for"

  assert_string(expr)
  assert_count(check_interval)
  assert_count(timeout)

  ## Assemble all JS code to inject. First the code for the waiting
  ## function, and then we'll call it.

  waitjs <- read_file(system.file(
    package = packageName(),
    "js", "webdriver-wait-for.js"
  ))

  escaped <- gsub('"', '\\\\"', expr)

  js <-
    'var callback = arguments[0];
     webdriver_wait_for(
       "' %+% escaped %+% '",
       callback,
       { check_interval: ' %+% str(check_interval) %+% ',
         timeout: ' %+% str(timeout) %+% ' }
     );'

  ret <- self$execute_script_async(paste0(waitjs, js))

  switch(ret, "error" = NA, "true" = TRUE, "timeout" = FALSE, NA)
}
