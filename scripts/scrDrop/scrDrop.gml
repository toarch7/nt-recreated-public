/// @description scrDrop(ammo,weapon)
/// @param ammo
/// @param weapon
function scrDrop(argument0, argument1) {
    var player = instance_nearest(x, y, Player)

    if !instance_exists(player) or!instance_exists(id) exit
	
    //roll
    random_set_seed(rng_next_int(9))
	
	var confiscate = (player.race == 1 && ultra_get(1)) && !irandom(10)
	
    if GameCont.crown == 5 {
		argument1 += 9
	}
	
	//calculate need
    need = 0

    if skill_get(29) argument1 *= 2.5

    //CROWN OF RISK
    if GameCont.crown == 12 {
        if player.hp >= player.max_hp {
            argument0 *= 1.5
        }
		else argument0 *= 0.5
    }

    if player.ammo[player.wep_type[player.wep]] < player.typ_amax[player.wep_type[player.wep]] * 0.2 need += 0.75
    else if player.ammo[player.wep_type[player.wep]] > player.typ_amax[player.wep_type[player.wep]] * 0.6 need += 0.1
    else need += 0.5

    if player.bwep = 0 need += 0.5
    else if player.ammo[player.wep_type[player.bwep]] < player.typ_amax[player.wep_type[player.bwep]] * 0.2 need += 0.75
    else if player.ammo[player.wep_type[player.bwep]] > player.typ_amax[player.wep_type[player.bwep]] * 0.6 need += 0.1
    else need += 0.5

    //drop items
    if random(100) < argument0 * (need + skill_get(4) * 0.6) {
        if random(player.max_hp) > player.hp && random(3) < (global.hardmode ? 1.5 : 2) && GameCont.crown != 3 {
			instance_create(x + random(4) - 2, y + random(4) - 2, confiscate ? HealthChest : HPPickup)
		}
        else if GameCont.crown != 5 {
			instance_create(x + random(4) - 2, y + random(4) - 2, confiscate ? AmmoChest : AmmoPickup)
		}
	}
	else if argument1 {
        if rng_random(9, 100) < argument1 * (1 + skill_get(4) * 0.6) {
            //drop weps
			if confiscate {
				instance_create(x + orandom(2), y + orandom(2), WeaponChest)
			}
			else {
	            with instance_create(x + random(4) - 2, y + random(4) - 2, WepPickup) {
	                scrWeapons()
	                scrDecideWep(0)
	                name = wep_name[wep]
	                type = wep_type[wep]
	                ammo = 50
	                curse = 0
	                sprite_index = wep_sprt[wep]
	            }
			}
        }
    }

    if UberCont.birthday && random(1) <= 0.05 {
        if !global.party_gun_dropped {
            with instance_create(x + random(4) - 2, y + random(4) - 2, WepPickup) {
                scrWeapons()
                wep = 82
                name = wep_name[wep]
                type = wep_type[wep]
                ammo = 0
                curse = 0
                sprite_index = wep_sprt[wep]
            }

            global.party_gun_dropped = 1
        }
    }
}

global.party_gun_dropped = 0