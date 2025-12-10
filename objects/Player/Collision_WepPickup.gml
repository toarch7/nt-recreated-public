if lockstep_stop
	exit

if !(can_pick && other.visible) exit

if KeyCont.press_pick[index] && other.id == instance_nearest(x, y, WepPickup) {
    if curse == other.curse || !scr_weapon_is_valid(bwep) {
        with (instance_create(x, y, WepSwap)) target = other.id
		
        if other.wep == wep_guitar {
            snd_play(sndGuitarPickup)
        }
		else {
            if scr_weapon_is_golden(other.wep) {
				snd_play(sndGoldPickup)
			}
			else snd_play(sndWeaponPickup)
        }
		
		with TutCont {
	        if pos == 1 && !step_complete {
	            step_complete = true
	            alarm[0] = 30
	        }
		}

        if scr_weapon_is_valid(bwep) {
			with scrWeaponPickupCreate(other.x, other.y, wep) {
				curse = other.curse
			}
        }
		else {
			bcurse = curse
			bwep = wep
        }
		
        wep = other.wep
        curse = other.curse
		
        can_shoot = true
        reload = 0
		
        if (curse) snd_play(sndCursedPickup)
        
        snd_play(wep_swap[wep])
		
		// TODO: localized string
		scrPopupCreate(x, y, loc(wep_name[wep]) + "!")
		
		if scr_weapon_is_melee(wep) {
			wepangle = choose(120, -120)
		}
		else wepangle = 0
		
        instance_destroy(other)
    }
	else if (curse) snd_play(sndCursedReminder)
	
	if index == global.index {
		with (WepstickAttack) scrWepstickUpdateSprite(other.id)
	}
}

if other.ammo && scr_weapon_get_type(other.wep) != Ammo.None {
    if scrCrownCheck(crwn_protection) {
		var _amount = 1 + scr_skill_get(mut_second_stomach)
		
		scrPlayerHeal(id, _amount, true)
        instance_create(x, y, HealFX)

        other.ammo = 0
	}
	else {
		var _type = scr_weapon_get_type(other.wep)
		scrPlayerGiveAmmo(id, _type, scrAmmoGetPickupAmount(_type) * 2, true)
    }
	
	other.ammo = 0
}