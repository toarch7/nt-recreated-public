function scrRngStatesReset() {
    with GameCont {
        var _number = (global.seed + area * 80687 + subarea * 56041 + loops * 90023) % 0x7fffffff
		
		random_set_seed(_number)
		
		for (var i = RNGStates.Generation; i < RNGStates.NUM_RNG_STATES; i ++) {
			global.rng_state[i] = (_number + (79379 * i)) % 0x7fffffff
		}
		
        if area == area_hq {
            global.rng_state[0] = subarea + 24
        }
		
		levseed = global.rng_state[RNGStates.Generation]
    }
}