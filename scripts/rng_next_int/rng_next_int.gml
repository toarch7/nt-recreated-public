/// @description rng_next_int
/// @param {Enum.RNGStates} state
function rng_next_int(_state) {
	//print("NEXT INT", debug_get_callstack(99)[1], _state, global.rng_state[_state])
    global.rng_state[_state] = (rng_a * global.rng_state[_state] + rng_c) % rng_m;
    return global.rng_state[_state]
}