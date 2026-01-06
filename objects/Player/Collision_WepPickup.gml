if lockstep_stop
	exit

if !(can_pick && other.visible) exit

if ((other.autopick && (!other.speed || other.slowreturn == 2)) || KeyCont.press_pick[index]) && other.id == instance_nearest(x, y, WepPickup) {
    if (!curse || other.curse
		|| array_length(extra_weps) < max_extra_weps
		|| !scr_weapon_is_valid(bwep)
	) {
        if (!other.autopick) {
	        with (instance_create(x, y, WepSwap)) target = other.id
			
			if (other.wep == wep_guitar) {
	            snd_play(sndGuitarPickup)
	        }
			else if (other.wep == wep_electric_guitar) {
	            snd_play(sndSwapElectricGuitar)
	        }
			else {
	            if (scr_weapon_is_golden(other.wep)) {
					snd_play(sndGoldPickup)
				}
				else {
					snd_play(sndWeaponPickup)
				}
			}
		}
		else {
			instance_create(other.x + orandom(3), other.y + orandom(2), WepSwap)
			if (other.slowreturn == 2) {
				snd_play_hit(wep_swap[other.wep])
			}
			else snd_play(sndPickupDisappear, 1.2)
		}
		
		with (TutCont) complete_step(TutorialStep.PickingUp)
		
        if scr_weapon_is_valid(bwep) {
			if max_extra_weps && array_length(extra_weps) < max_extra_weps {
				scrExtraWepStoreCurrent()
			}
			else {
				with scrWeaponPickupCreate(other.x, other.y, wep) {
					curse = other.curse
				}
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
		
		scrUnlocksPlayerEquipment(id)
		
		GameCont.haspickedweps = true
        
        if (!other.autopick) {
			snd_play(wep_swap[wep])
			
			var _name = loc("Weapons", wep, "Name", scr_weapon_get_name(wep))
			scrPopupCreate(x, y, loc_fmt("HUD:GotWeapon", "%!", _name))
		}
		
		if scr_weapon_is_melee(wep) {
			wepangle = choose(120, -120)
		}
		else wepangle = 0
		
        instance_destroy(other)
    }
	else {
		if (curse) snd_play(sndCursedReminder)
		other.autopick = false
	}
	
	if (index == global.index) {
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