/// @description rng_next_range(slot, start, end)
/// @param slot
/// @param  start
/// @param  end
function rng_next_range(_slot, _end, _start) {
    var rangeSize = _end - _start,
		randomUnder1 = rng_next_int(_slot) / rng_m
	
    return _start + floor(randomUnder1 * rangeSize)
}