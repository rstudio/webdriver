# 1.0.6

* Better display of error messages. (#60)

* Resolved #59: `run_phantomjs()` now checks that a port is available before telling PhantomJS to start and listen on that port. It also provides more informative error messages if unable to connect. (#62)

# 1.0.5

* Make sure stdout and stderr output is recorded.

* Try to find locally-install phantomjs first.

* `Session$new()` now checks that the phantomjs binary was built with ghostdriver support.


# 1.0.3

First public release.
