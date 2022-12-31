/// RNG Class
/*
#macro rng_m 2147483648
#macro rng_a 1103515245
#macro rng_c 12345

function Random(seed) constructor {
	self.seed = seed
	state = seed
	
	static next_int = function() {
		return self.state = (rng_a * self.state + rng_c) % rng_m;
	}
	
	static next_float = function () {
		return self.next_int() / (rng_m - 1)
	}
	
	static range = function (_start, _end) {
		return self.next_float() * (_start - _end) + start
	}
	
	static irange = function (_start, _end) {
		return round(self.range(_start, _end))
	}
	
	static choose = function () {
		return argument[self.irange(argument_count - 1)]
	}
}

*/