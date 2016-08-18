
assert_string <- function(x) {
  stopifnot(
    is.character(x) && length(x) == 1 && !is.na(x)
  )
}

assert_url <- assert_string

assert_filename <- assert_string

assert_count <- function(x) {
  stopifnot(
    is.numeric(x) && length(x) == 1 && !is.na(x) && x == as.integer(x)
  )
}

assert_port <- assert_count

assert_session <- function(x) {
  stopifnot(
    inherits(x, "session")
  )
}

assert_named <- function(x) {
  stopifnot(
    !is.null(names(x)) && all(names(x) == "")
  )
}
