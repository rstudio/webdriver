
# webdriver

> ‘WebDriver’ Client for ‘PhantomJS’

<!-- badges: start -->

[![R-CMD-check](https://github.com/rstudio/webdriver/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rstudio/webdriver/actions)
[![](https://www.r-pkg.org/badges/version/webdriver)](https://www.r-pkg.org/pkg/webdriver)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/webdriver)](https://www.r-pkg.org/pkg/webdriver)
[![Coverage
Status](https://img.shields.io/codecov/c/github/rstudio/webdriver/main.svg)](https://codecov.io/github/rstudio/webdriver?branch=main)
<!-- badges: end -->

A client for the ‘WebDriver’ ‘API’. It allows driving a (probably
headless) web browser, and can be used to test web applications,
including ‘Shiny’ apps. In theory it works with any ‘WebDriver’
implementation, but it was only tested with ‘PhantomJS’.

## Installation

``` r
install.packages("webdriver")
```

## Usage

``` r
library(webdriver)
```

### PhantomJS

webdriver uses PhantomJS as a headless web browser. (In theory in works
with other WebDriver clients as well.) You can use the
`install_phantomjs()` function to download and install PhantomJS on your
system. Alternatively an installation that is in the PATH is sufficient.

The `run_phantomjs()` function starts PhantomJS, and waits until it is
ready to serve queries. It returns a process object that you can
terminate manually, and the port on which PhantomJS is listening.

``` r
pjs <- run_phantomjs()
pjs
```

    ## $process
    ## PROCESS 'phantomjs', running, pid 17405.
    ##
    ## $port
    ## [1] 6795

### Sessions

Use the `Session` class to connection to a running PhantomJS process.
One process can save multiple sessions, and the sessions are independent
of each other.

``` r
ses <- Session$new(port = pjs$port)
```

Once a session is established, you can manipulate the headless web
browser through it:

``` r
ses$go("https://r-pkg.org/pkg/callr")
ses$getUrl()
```

    ## [1] "https://r-pkg.org/pkg/callr"

``` r
ses$getTitle()
```

    ## [1] "callr @ METACRAN"

You can also take a screenshot of the whole web page, and show it on R’s
graphics device, or save it to a PNG file:

``` r
ses$takeScreenshot()
```

![](man/figures/screenshot-1.png)

### HTML elements

The `Session` object has two methods to find HTML elements on the
current web page, which can then be further manipulated: `findElement()`
and `findElements()`. They work with CSS or XPATH selectors, and also
with (possibly partial) HTML text.

``` r
install <- ses$findElement(".install-package")
install$getName()
```

    ## [1] "div"

``` r
install$getText()
```

    ## [1] "install.packages(\"callr\")"

If you have an HTML element that can receive keyboard keys, you can use
the `sendKeys()` method to send them. The `key` list helps with sending
special, characters, e.g. `key$enter` corresponds to pressing ENTER. For
example we can type into a search box:

``` r
search <- ses$findElement("#cran-input")
search$sendKeys("html", key$enter)
ses$getUrl()
```

    ## [1] "https://r-pkg.org/search.html?q=html"

``` r
ses$getTitle()
```

    ## [1] "METACRAN search results"

``` r
ses$takeScreenshot()
```

![](man/figures/screenshot-2.png)

### JavaScript

The `executeScript()` method of a `Session` object runs arbitrary
JavaScript in the headless browser. It puts the supplied code into the
body of a JavaScript function, and the function will receive the
additional arguments, in its `arguments` array. `Element` objects as
arguments are automatically converted to the corresponding DOM elements
in the browser.

The JavaScript function can return values to R. Returned HTML elements
are automatically converted to `Element` objects.

``` r
ses$executeScript("return 42 + 'foobar';")
```

    ## [1] "42foobar"

``` r
search2 <- ses$executeScript("return document.getElementById('cran-input');")
search2$getName()
```

    ## [1] "input"

`Element` objects also have an `executeScript()` method, which works the
same way as the `Session` method, but it automatically supplies the HTML
element as the first argument of the JavaScript function.

`executeScript()` works synchronously. If you need asynchronous
execution, you can use the `executeScriptAsync()` function.

## License

MIT © Mango Solutions, RStudio
