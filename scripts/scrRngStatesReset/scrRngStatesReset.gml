function scrRngStatesReset() {
    with GameCont {
        var _number = global.seed
		_number += area * 80687
		_number += subarea * 56041
		_number += loops * 90023
		
		levseed = _number
		
		for (var i = 0; i < RNGStates.NUM_RNG_STATES; i ++) {
			global.rng_state[i] = (_number + (79379 * i)) % 0x7fffffff
		}
		
        if area == Area.HQ {
            global.rng_state[0] = subarea + 24
        }
		
		random_set_seed(global.seed)
    }
}