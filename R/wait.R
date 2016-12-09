
#' @importFrom utils packageName

session_waitFor <- function(self, private, expr, checkInterval,
                             timeout) {

  "!DEBUG session_waitFor"

  assert_string(expr)
  assert_count(checkInterval)
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
       { check_interval: ' %+% str(checkInterval) %+% ',
         timeout: ' %+% str(timeout) %+% ' }
     );'

  ret <- self$executeScriptAsync(paste0(waitjs, js))

  switch(ret, "error" = NA, "true" = TRUE, "timeout" = FALSE, NA)
}
