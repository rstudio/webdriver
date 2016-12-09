
default_headers <- c(
  "Accept"       = "application/json",
  "Content-Type" = "application/json",
  "User-Agent"   = "R webdriver"
)

#' @importFrom jsonlite toJSON
#' @importFrom httr GET POST DELETE add_headers

session_makeRequest <- function(self, private, endpoint, data, params,
                                 headers) {

  "!DEBUG session_makeRequest `endpoint`"
  headers <- update(default_headers, as.character(headers))

  ep <- parse_endpoint(endpoint, private, params)

  url <- paste0(
    "http://",
    private$host,
    ":",
    private$port,
    ep$endpoint
  )

  json <- if (!is.null(data)) toJSON(data)

  response <- if (ep$method == "GET") {
    GET(url, add_headers(.headers = headers))

  } else if (ep$method == "POST") {
    POST(url, add_headers(.headers = headers), body = json)

  } else if (ep$method == "DELETE") {
    DELETE(url, add_headers(.headers = headers))

  } else {
    stop("Unexpected HTTP verb, internal webdriver error")
  }

  report_error(response)

  parse_response(response)
}

parse_endpoint <- function(endpoint, params, xparams) {

  if (! endpoint %in% names(endpoints)) {
    stop("Unknown webdriver API endpoint, internal error")
  }

  template <- endpoints[[endpoint]]

  colons <- re_match_all(template, ":[a-zA-Z0-9_]+")$.match[[1]]

  for (col in colons) {
    col1 <- substring(col, 2)
    value <- xparams[[col1]] %||% params[[col1]] %||%
      stop("Unknown API parameter: ", col)
    template <- gsub(col, value, template, fixed = TRUE)
  }

  if (substring(template, 1, 1) != "/") {
    method <- gsub("^([^/ ]+)\\s*/.*$", "\\1", template)
    template <- gsub("^[^/]+/", "/", template)

  } else {
    method <- "GET"
  }

  list(method = method, endpoint = template)
}

#' @importFrom httr headers content
#' @importFrom jsonlite fromJSON

parse_response <- function(response) {

  "!DEBUG parse_response"
  content_type <- headers(response)$`content-type`

  if (is.null(content_type) || length(content_type) == 0) {
    ""

  } else if (grepl("^application/json", content_type, ignore.case = TRUE)) {
    fromJSON(content(response, as = "text"), simplifyVector = FALSE)

  } else {
    content(response, as = "text")
  }
}


toJSON <- function(x, ..., auto_unbox = TRUE) {
  # I(x) is so that length-1 atomic vectors get put in [] when auto_unbox is
  # TRUE.
  jsonlite::toJSON(I(x), auto_unbox = auto_unbox, ...)
}
