/// @description rng_rnd(slot,min,max)
/// @param slot
/// @param min
/// @param max
function rng_rnd(argument0, argument1, argument2) {
    return rng_next_float(argument0) * (argument2 - argument1) + argument1
}