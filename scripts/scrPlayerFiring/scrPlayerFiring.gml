function scrPlayerFiring() {
	var enoughrads = scrCheckRads(wep),
		enoughammo = scrCheckAmmo(wep),
	
    if infammo > 0 {
		enoughrads = true
		enoughammo = true
	}
	
    if KeyCont.press_fire[p] && race != 7 && !wep_auto[wep] && ((wep_type[wep] == 0 or wep_type[wep] == 1) or can_shoot) && reload < 10
        clicked = true
	
	if KeyCont.press_fire[index] && (!enoughammo or !enoughrads) {
		if !enoughammo {
			if wep == wep_blood_launcher or wep == wep_blood_cannon {
				scrBloodAmmoRefill(wep)
		        last_hit = wep_sprt[wep]
				
		        sleep(40)
		    }
			else scrEmpty()
		}
		else if !enoughrads
			scrEmptyRads()
		
		clicked = false
	}
	
	if scrCheckCanShoot(wep) or infammo {
		if can_shoot && (clicked or KeyCont.press_fire[index] or (KeyCont.hold_fire[index] && (wep_auto[wep] or race == 7))) {
	        scrFire(wep)
			clicked = 0
		}
    }
}