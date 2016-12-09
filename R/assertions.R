
is_string <- function(x) {
  is.character(x) && length(x) == 1 && !is.na(x)
}

assert_string <- function(x) {
  stopifnot(is_string(x))
}

assert_url <- assert_string

assert_filename <- assert_string

assert_count <- function(x) {
  stopifnot(
    is.numeric(x),
    length(x) == 1,
    !is.na(x),
    x == as.integer(x),
    x >= 0
  )
}

assert_port <- assert_count

assert_window_size <- assert_count

assert_window_position <- assert_count

assert_timeout <- assert_count

assert_session <- function(x) {
  stopifnot(
    inherits(x, "Session")
  )
}

assert_named <- function(x) {
  stopifnot(
    length(names(x)) == length(x) && all(names(x) != "")
  )
}

assert_unnamed <- function(x) {
  stopifnot(
    is.null(names(x)) || all(names(x) == "")
  )
}

assert_mouse_button <- function(x) {
  if (is.numeric(x)) {
    x <- as.integer(x)
    stopifnot(identical(x, 1L) || identical(x, 2L) || identical(x, 3L))

  } else if (is.character(x)) {
    stopifnot(is_string(x), x %in% c("left", "middle", "right"))

  } else {
    stop("Mouse button must be 1, 2, 3, \"left\", \"middle\" or \"right\"")
  }
}
