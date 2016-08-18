
`%||%` <- function(l, r) if (is.null(l)) r else l

update <- function(original, new) {

  if (length(new)) {
    assert_named(original)
    assert_named(new)
    original[names(new)] <- new
  }

  original
}
