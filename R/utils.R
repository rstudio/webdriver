
`%||%` <- function(l, r) if (is.null(l)) r else l

update_list <- function(original, new) {

  if (length(new)) {
    if (length(original)) assert_named(original)
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

random_port <- function(min = 3000, max = 9000) {
  if (min < max) sample(min:max, 1) else min
}

unbox_list <- function(lst){
  lapply(lst, function(x){
    if(is.list(x)){
      unbox_list(x)
    }else{
      test_class <- !inherits(x, c("AsIs", "scalar"))
      if(is.atomic(x) && length(x) == 1L && test_class){
        unbox(x)
      }else{
        x
      }
    }
  })
}
