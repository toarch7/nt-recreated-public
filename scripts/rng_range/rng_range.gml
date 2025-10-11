/// @description rng_range
/// @param {Enum.RNGStates} state
/// @param min
/// @param max
function rng_range(_state, _min, _max) {
    return rng_next_float(_state) * (_max - _min) + _min
}