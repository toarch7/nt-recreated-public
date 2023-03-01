/// @description rng_next_range(slot, start, end)
/// @param slot
/// @param  start
/// @param  end
function rng_next_range(argument0, argument1, argument2) {
    _slot = argument0
    _end = argument1
    _start = argument2

    rangeSize = _end - _start;
    randomUnder1 = rng_next_int(_slot) / rng_m;
    return _start + floor(randomUnder1 * rangeSize)



}