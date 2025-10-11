/// @description rng_choose
/// @param {Enum.RNGStates} state_id
function rng_choose() {
    return argument[rng_next_int(argument[0]) % argument_count]
}