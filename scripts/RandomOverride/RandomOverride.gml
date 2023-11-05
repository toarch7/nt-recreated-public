#macro __randomize randomize
#macro __random_set_seed random_set_seed
#macro __random random
#macro __random_range random_range
#macro __irandom irandom
#macro __irandom_range irandom_range

#macro randomize randomize_wrapper
#macro random_set_seed random_set_seed_wrapper
#macro random random_wrapper
#macro random_range random_range_wrapper
#macro irandom irandom_wrapper
#macro irandom_range irandom_range_wrapper
#macro choose choose_wrapper

global.random_state = 1

function randomize_wrapper() {
	var _seed = __randomize()
	
	global.random_state = _seed
	random_set_seed(_seed)
	
	return _seed
}

function random_set_seed_wrapper(_seed) {
	_seed = real(_seed)
	
	global.random_state = _seed
	
	__random_set_seed(_seed)
}

function rng_next() {
	global.random_state = (global.random_state * 48271 + RNG_SECRET) mod rng_m;
	return global.random_state;
}

function random_wrapper(val) {
	return rng_next() / rng_m * val;
}
function random_range_wrapper(a, b) {
	return ((rng_next() / rng_m) * (b - a)) + a
}

function irandom_wrapper(val) {
	return floor((rng_next() / rng_m) * (ceil(val) + 1))
}

function irandom_range_wrapper(a, b) {
	a = floor(a)
	return ((rng_next() / rng_m) * (ceil(b) - a + 1)) + a
}

function choose_wrapper() {
	return argument[floor((rng_next() / rng_m) * argument_count)]
}