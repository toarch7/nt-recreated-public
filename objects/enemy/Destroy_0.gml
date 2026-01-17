if givekill && instance_exists(GameCont) {
    GameCont.kills ++
}

if (instance_number(enemy) == 2) {
	with (Player) snd_play_hit_big(sndLastEnemy, 0.2)
}

if corpse {
    with instance_create(x, y, CorpseActive) {
        size = other.size
        mask_index = other.mask_index
        motion_add(other.direction, other.speed)
        speed += max(0, -other.hp / 5)
        sprite_index = other.spr_dead
        image_xscale = other.right

        if instance_exists(Player) {
            if scr_skill_get(mut_impact_wrists) speed += 8
        }

        if speed > 16 speed = 16

        if size > 0 {
            speed /= size
        }
    }
}

snd_play(snd_dead)

sleep(20 + size * 15)

scrRadDrop(x, y, raddrop + scrPlayerCountRace(Race.Melting))

if hp > 0 exit

with Player {
    //
	if scr_player_ultra_get(id, Race.Chicken, UltraSkill.HarderToKill) {
        if bleed > 0 bleed = 1
    }

	//
	var _lucky_shot = scr_skill_get(mut_lucky_shot)
    
	if _lucky_shot && random(10) < 1 {
		var _ammo_type = irandom_range(Ammo.Bullets, Ammo.NUM_AMMO_TYPES - 1),
			_ammo_give = scrAmmoGetPickupAmount(_ammo_type) * _lucky_shot
		
		scrPlayerGiveAmmo(id, _ammo_type, _ammo_give, true)
		
		with instance_create(x, y, AnimParticle) {
			sprite_index = sprLuckyShot
			creator = other.id
		}
		
		snd_play(sndLuckyShotProc)
    }

    //
	var _bloodlust = scr_skill_get(mut_bloodlust)
    
	if _bloodlust && random(15) < 1 {
        scrPlayerHeal(id, _bloodlust, true)

        with instance_create(x, y, AnimParticle) {
            sprite_index = sprBloodLust
            creator = other.id
        }

        snd_play(sndBloodlustProc)
    }
		
	//
    if scr_skill_get(mut_trigger_fingers) {
		if (reload > 0 || !can_shoot) {
			reload = floor(reload * 0.6)
			trigger_fingers_shine = 6
			
			if (!reload) {
				can_shoot = true
				scrPlayerGunReloadFX(wep)
				reload = true
			}
		}
		
		if (breload > 0 || !bcan_shoot) {
			breload = floor(breload * 0.6)
			trigger_fingers_shine = 6
			
			if (!breload) {
				bcan_shoot = true
				scrPlayerGunReloadFX(bwep)
				breload = 0
			}
		}
		
		var _extra_count = array_length(extra_weps)
		for(var i = _extra_count - 1; i >= 0; --i) {
			if (extra_weps_reload[i] <= 0 || extra_weps_can_shoot[i]) continue
			
			extra_weps_reload[i] = floor(extra_weps_reload[i] * (1 - power(0.4, i + 1)))
			trigger_fingers_shine = 6
			
			if (!extra_weps_reload[i]) {
				extra_weps_can_shoot[i] = true
				scrPlayerGunReloadFX(extra_weps[i])
				extra_weps_reload[i] = 0
			}
		}
	}
}

if instance_exists(Player) && place_meeting(x, y, Tangle) {
	repeat scr_ultra_get(Race.Plant, UltraSkill.Killer) {
	    instance_create(x, y, Sapling)
	}
}