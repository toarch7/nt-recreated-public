if lockstep_stop
	exit

if !can_pick or !other.visible exit

if KeyCont.press_pick[p] && other.id == instance_nearest(x, y, WepPickup) {
    if !curse or (curse && other.curse) or !bwep {
        instance_create(x, y, WepSwap)

        if other.wep == 115 {
            snd_play(sndGuitarPickup)
        }
		else {
            scrWeapons()
            if string_count("GOLD", wep_name[other.wep]) snd_play(sndGoldPickup)
            else snd_play(sndWeaponPickup)
        }

        if instance_exists(TutCont) && TutCont.pos == 1 && !TutCont.doin {
            TutCont.alarm[0] = 30
            TutCont.doin = 1
        }

        if !bwep {
            bcurse = curse
            bwep = wep
        }
		else {
            with instance_create(other.x, other.y, WepPickup) {
                scrWeapons()
                wep = other.wep
                name = wep_name[wep]
                type = wep_type[wep]
                curse = other.curse
                sprite_index = wep_sprt[wep]
                ammo = 0
            }
        }

        wep = other.wep
        curse = other.curse

        can_shoot = 1
        reload = 0

        if curse {
            snd_play(sndCursedPickup)
        }

        snd_play(wep_swap[wep])

        dir = instance_create(x, y, PopupText)
        dir.mytext = string(loc(wep_name[wep])) + "!"

        if wep_type[wep] != 0 and wep != 24 and wep != 36 and wep != 53 wepangle = 0
        else if wepangle = 0 wepangle = choose(120, - 120)

        with other
        instance_destroy()
    }
	else if curse {
		snd_play(sndCursedReminder)
	}
	
	if index == global.index {
		with WepstickAttack
			scrWepstickUpdateSprite(other.id)
	}
}

if other.ammo and wep_type[other.wep] {
    if GameCont.crown != 13 {
        ammo[wep_type[other.wep]] += typ_ammo[wep_type[other.wep]] * 2
        if ammo[wep_type[other.wep]] > typ_amax[wep_type[other.wep]] ammo[wep_type[other.wep]] = typ_amax[wep_type[other.wep]]

        if is_me {
            dir = instance_create(x, y, PopupText)
            dir.mytext = "+" + loc_sfmt("% " + loc(typ_name[wep_type[other.wep]]), typ_ammo[wep_type[other.wep]] * 2)
            if ammo[wep_type[other.wep]] = typ_amax[wep_type[other.wep]] dir.mytext = loc_sfmt("MAX %", loc(typ_name[wep_type[other.wep]]))
        }

        other.ammo = 0
    }
	else { //CROWN OF PROTECTION
        amount = 1 + skill_get(9)
        hp += amount
        if hp > max_hp hp = max_hp

        if is_me {
            with instance_create(x, y, PopupText) {
                mytext = "+" + string(other.amount) + " HP"
                if other.hp >= other.max_hp mytext = "MAX HP"
            }
        }

        instance_create(x, y, HealFX)

        other.ammo = 0
    }
}