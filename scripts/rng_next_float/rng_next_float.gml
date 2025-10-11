/// @description rng_next_float
/// @param {Enum.RNGStates} state_id
function rng_next_float(_state) {
    return rng_next_int(_state) / (rng_m - 1)
}