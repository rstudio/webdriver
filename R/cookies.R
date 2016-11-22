
session_get_all_cookies <- function(self, private) {
  "!DEBUG get_all_cookies"
  private$make_request(
    "GET ALL COOKIES"
  )$value
}

## TODO: Phantom does not have this. So we query all cookies and select the
## requested one.

session_get_cookie <- function(self, private, name) {
  "!DEBUG get cookie `name`"
  assert_string(name)
  private$make_request(
    "GET ALL COOKIES"
  )
}

session_add_cookie <- function(self, private, name, value, domain, expiry) {
  "!DEBUG add_cookie `name`"
  assert_string(name)
  if (!is.null(domain)) assert_string(domain)
  if (!is.null(expiry)) {
    ## TODO
  }

  if (is.null(domain)) domain <- self$get_url
  if (is.null(expiry)) {
    expiry <- as.numeric(Sys.time() + as.difftime(60, units = "mins"))
  }
  
  cookie <- list(value = value, domain = domain, expiry = expiry)

  private$make_request(
    "ADD COOKIE",
    list(name = name, cookie = drop_nulls(cookie))
  )

  invisible(self)
}

session_delete_cookie <- function(self, private, name) {
  "!DEBUG delete_cookie `name`"
  assert_string(name)

  private$make_request(
    "DELETE COOKIE",
    params = list(name = name)
  )

  invisible(self)
}

session_delete_all_cookies <- function(self, private) {
  "!DEBUG delete_all_cookies"
  private$make_request(
    "DELETE ALL COOKIES"
  )

  invisible(self)
}
