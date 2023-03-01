/// @description rng_next_int(slot)
/// @param slot
function rng_next_int(argument0) {
    global.rng_state[argument0] = (rng_a * global.rng_state[argument0] + rng_c) % rng_m;
    return global.rng_state[argument0]



}