function scrPlayerFire() {
	var enoughrads = scrCheckRads(wep),
		enoughammo = scrCheckAmmo(wep),
	
    if infammo > 0 {
		enoughammo = true
		enoughrads = true
	}
	
    if KeyCont.press_fire[p] && race != 7 && !wep_auto[wep] && ((wep_type[wep] == 0 or wep_type[wep] == 1) or can_shoot) && reload < 10
        clicked = 1
	
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
	
    var yvmobilepopping = (race == 6 && is_mobile(index) && KeyCont.activeforever[index] && KeyCont.press_fire[index])
    
	if scrCheckCanShoot(wep) && (!yvmobilepopping or !scrYVCanPop(wep)) {
		if can_shoot && (clicked or KeyCont.press_fire[index] or (!yvmobilepopping && KeyCont.hold_fire[index] && (wep_auto[wep] or race == 7))) {
	        scrFire(wep)
			clicked = 0
		}
    }
}