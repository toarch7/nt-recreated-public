function scrSwapWeps() {
    //SWAP DA WEPS
    var twep = wep,
	    tcurse = curse,
	    treload = reload,
	    twkick = wkick,
	    twepflip = wepflip,
	    twepangle = wepangle,
	    tcan_shoot = can_shoot
	
    wep = bwep
    curse = bcurse
    reload = breload
    wkick = bwkick
    wepflip = bwepflip
    wepangle = bwepangle
    can_shoot = bcan_shoot

    bwkick = twkick
    bcurse = tcurse
    bcan_shoot = tcan_shoot
    bwepflip = twepflip
    bwepangle = twepangle
    breload = treload
    bwep = twep
    clicked = 0

    if reload > 0 can_shoot = 0
    else can_shoot = 1

    if !wep_mele[wep] {
		wepangle = 0
	}
	else if wepangle == 0 {
		wepangle = choose(120, - 120)
	}
	
    drawempty = 30

    if instance_exists(TutCont) && TutCont.pos == 2 && !TutCont.doin {
        TutCont.alarm[0] = 30
        TutCont.doin = 1
    }
	
	if instance_exists(SwapstickAttack) && index == global.index {
		with SwapstickAttack
			scrSwapstickUpdateSprite(other.id)
	}
}