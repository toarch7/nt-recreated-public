/// @description rng_choose
/// @param {Enum.RNGStates} state_id
function rng_choose() {
	if (argument_count > 1) {
	    return argument[1 + (rng_next_int(argument[0]) % (argument_count - 1))]
	}
	return undefined
}