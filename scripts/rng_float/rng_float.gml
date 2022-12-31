/// @description rng_random(slot, number)
/// @param slot
/// @param  number
function rng_float(argument0, argument1) {
    return min(argument1, rng_next_int(argument0) * argument1)



}