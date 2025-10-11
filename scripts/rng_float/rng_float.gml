/// @description rng_float
/// @param {Enum.RNGStates}
/// @param number
function rng_float(_state, _number) {
    return rng_next_float(_state) * _number
}