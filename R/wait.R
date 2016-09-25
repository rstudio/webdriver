
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

  js <-
    "var callback = arguments[0];
     webdriver_wait_for(
       function() { return (" %+% expr %+% "); },
       { check_interval: " %+% str(check_interval) %+% ",
         timeout: " %+% str(timeout) %+% ",
         on_ready:   function() { callback(true); },
         on_timeout: function() { callback(false); } }
     );"

  self$execute_script_async(paste0(waitjs, js))
}
