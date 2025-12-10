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
	if scrUltraCheckPlayerRace(id, Race.Chicken, UltraSkill.HarderToKill) {
        if bleed > 0 bleed = 1
    }

	//
	var _lucky_shot = scr_skill_get(mut_lucky_shot)
    
	if _lucky_shot && random(10) < 1 {
		var _ammo_type = irandom_range(Ammo.Bullets, Ammo.NUM_AMMO_TYPES - 1),
			_ammo_give = round(scrAmmoGetPickupAmount(_ammo_type) / 2) * _lucky_shot
		
		scrPlayerGiveAmmo(id, _ammo_type, _ammo_give, true)
    }

    //
	var _bloodlust = scr_skill_get(mut_bloodlust)
    
	if _bloodlust && random(15) < 1 {
        scrPlayerHeal(id, _bloodlust, true)

        with instance_create(x, y, AnimParticle) {
            sprite_index = sprBloodLust
            image_speed = 0.4

            creator = other.id
        }

        snd_play(sndBloodlustProc)
    }
		
	//
    if scr_skill_get(mut_trigger_fingers) {
		if reload > 0 {
			reload = max(1, floor(reload * 0.6))
			trigger_fingers_shine = 6
		}
		
		if breload > 0 {
			breload = max(1, floor(breload * 0.6))
		}
	}
}

if instance_exists(Player) && place_meeting(x, y, Tangle) {
	repeat scrUltraCheck(Race.Plant, UltraSkill.Killer) {
	    instance_create(x, y, Sapling)
	}
}