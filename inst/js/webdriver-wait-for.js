
// Originally taken from
// https://github.com/ariya/phantomjs/blob/master/examples/waitfor.js
// and then greatly simplified for our purposes.

function webdriver_wait_for(expr, callback, options) {

    var start = new Date().getTime(),
	check_interval = options.check_interval || 100,
	timeout = options.timeout || 3000;

    var interval = setInterval(function() {

	var val;

	try {
	    val = eval(expr);

	} catch(Error) {
	    callback("error");
	};

	if (val) {
	    clearInterval(interval);
	    callback("true");

	} else if (new Date().getTime() - start >= timeout) {
	    clearInterval(interval);
	    callback("timeout");
	}

    }, check_interval);
};
