
`%||%` <- function(l, r) if (is.null(l)) r else l

update <- function(original, new) {

  if (length(new)) {
    assert_named(original)
    assert_named(new)
    original[names(new)] <- new
  }

  original
}

read_file <- function(x) {
  readChar(x, file.info(x)$size)
}

`%+%` <- function(l, r) {
  assert_string(l)
  assert_string(r)
  paste0(l, r)
}

str <- function(x) {
  as.character(x)
}

is_windows <- function() .Platform$OS.type == "windows"

is_osx     <- function() Sys.info()[['sysname']] == 'Darwin'

is_linux   <- function() Sys.info()[['sysname']] == 'Linux'

dir_exists <- function(path) utils::file_test('-d', path)
