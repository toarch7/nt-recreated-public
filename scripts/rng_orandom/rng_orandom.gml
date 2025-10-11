/// @description rng_orandom
/// @param {Enum.RNGStates} state
/// @param number
function rng_orandom(_state, _number) {
    return rng_range(_state, -_number, _number)
}