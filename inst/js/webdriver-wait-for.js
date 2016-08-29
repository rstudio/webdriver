
// Originally taken from
// https://github.com/ariya/phantomjs/blob/master/examples/waitfor.js
// and then greatly simplified for our purposes.

function webdriver_wait_for(expr, options) {

    var start = new Date().getTime(),
	check_interval = options.check_interval || 100,
	timeout = options.timeout || 3000,
	on_ready = options.on_ready || "",
	on_timeout = options.on_timeout || "";

    var interval = setInterval(function() {

	if (expr()) {
	    clearInterval(interval);
	    on_ready();

	} else if (new Date().getTime() - start >= timeout) {
	    clearInterval(interval);
	    on_timeout();
	}

    }, check_interval);
};
