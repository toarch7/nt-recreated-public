function scrPlayerFiring() {
	if (!scr_weapon_is_valid(wep)) exit
	
	var _type = scr_weapon_get_type(wep),
		_enoughrads = scrCheckRads(wep),
		_enoughammo = scrCheckAmmo(wep)
	
	if (infammo > 0) {
		_enoughrads = true
		_enoughammo = true
	}
	
    if (KeyCont.press_fire[index] && race != Race.Steroids) {
		if (!scr_weapon_is_auto(wep) && reload < 10
			&& ((_type == Ammo.None || _type == Ammo.Bullets || scr_weapon_is_melee(wep)) || can_shoot)
		) {
			clicked = true
		}
	}
	
	if (KeyCont.press_fire[index] && !(_enoughammo && _enoughrads)) {
		if (!_enoughammo) {
			if (wep == wep_blood_launcher || wep == wep_blood_cannon) {
				scrBloodAmmoRefill(wep)
				snd_play_hit_big(sndBloodHurt, 0.2)
		        sleep(40)
		    }
			else {
				scrEmpty()
			}
		}
		else if (!_enoughrads) scrEmptyRads()
		
		clicked = false
	}
	
	if (scrCheckCanShoot(wep) || infammo) {
		if (can_shoot && (clicked || KeyCont.press_fire[index]
			|| (KeyCont.hold_fire[index] && (wep_auto[wep] || race == Race.Steroids)))
		) {
			scrFire(wep)
			clicked = false
			
			with (TutCont) {
				complete_step(TutorialStep.Shooting)
			}
		}
    }
}