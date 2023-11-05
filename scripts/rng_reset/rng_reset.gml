function rng_reset() {
    with GameCont {
        for (var i = 0; i <= 12; i ++)
            global.rng_state[i] = global.seed + area + subarea + loops
		
        if area == 106 {
            global.rng_state[0] = subarea + 24
        }
    }
}