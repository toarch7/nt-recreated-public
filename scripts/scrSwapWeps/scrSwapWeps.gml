/// @function scrSwapWeps
/// @param swap_extra=true
function scrSwapWeps(_swap_extra = true) {
	if _swap_extra && array_length(extra_weps) {
		scrExtraWepStoreCurrent()
	}
	
	var _t_wep = wep,
	    _t_curse = curse,
	    _t_reload = reload,
	    _t_wkick = wkick,
	    _t_wepflip = wepflip,
	    _t_wepangle = wepangle,
	    _t_can_shoot = can_shoot
	
    wep = bwep
    curse = bcurse
    reload = breload
    wkick = bwkick
    wepflip = bwepflip
    wepangle = bwepangle
    can_shoot = bcan_shoot

    bwkick = _t_wkick
    bcurse = _t_curse
    bcan_shoot = _t_can_shoot
    bwepflip = _t_wepflip
    bwepangle = _t_wepangle
    breload = _t_reload
    bwep = _t_wep
    clicked = false
	can_shoot = (reload <= 0)
    
    if !scr_weapon_is_melee(wep) {
		wepangle = 0
	}
	else if wepangle == 0 {
		wepangle = choose(120, -120)
	}
	
    drawempty = 30
	
	with (TutCont) complete_step(TutorialStep.Swapping)
	
	if instance_exists(WepstickAttack) && index == global.index {
		with (WepstickAttack) scrWepstickUpdateSprite(other.id)
	}
	
	if _swap_extra && array_length(extra_weps) {
		bwep = array_shift(extra_weps)
		bcurse = array_shift(extra_weps_curse)
		breload = array_shift(extra_weps_reload)
		bwkick = array_shift(extra_weps_wkick)
		bwepflip = array_shift(extra_weps_wepflip)
		bwepangle = array_shift(extra_weps_wepangle)
		bcan_shoot = array_shift(extra_weps_can_shoot)
	}
}