function scrReal(n) {
	try {
	    return (is_undefined(n) || string_length(n) == 0) ? 0 : real(n)
	}
	catch(e) { /* ... */ }
	
	return 0
}

function scrRealExt(n, _default = undefined) {
	try {
	    return (is_undefined(n) || string_length(n) == 0) ? _default : real(n)
	}
	catch(e) { /* ... */ }
	
	return _default
}