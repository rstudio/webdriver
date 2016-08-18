
assert_string <- function(x) {
  stopifnot(
    is.character(x) && length(x) == 1 && !is.na(x)
  )
}

assert_url <- assert_string

assert_count <- function(x) {
  stopifnot(
    is.numeric(x) && length(x) == 1 && !is.na(x) && x == as.integer(x)
  )
}

assert_port <- assert_count
