if lockstep_stop
	exit

if ((GameCont.tottimer - starttimer < 30) || !scr_can_hit(other.id) || other.bleed) exit

hp = clamp(ceil(other.hp / 2), 1, max_hp)

with other {
	scr_hit_self(max(1, floor(hp * 0.5), HitId.PlayerRevive))
	
    hp = round(hp / 2)
	
	motion_add(point_direction(other.x, other.y, x, y), 4)
    if (speed > 4) speed = 4
}

with Corpse {
    if sprite_index == other.spr_dead {
        instance_destroy()
		break
    }
}

var _player = id
instance_change(Player, 0)

with _player {
    repeat 2 {
		var _distance_max = 64, _instance = noone
		
		with WepPickup {
			var _distance = distance_to_object(other)
			
	        if (!curse && _distance_max < _distance) {
				_distance_max = _distance
				_instance = id
			}
		}
		
		if instance_exists(_instance) {
			if (wep) scrSwapWeps()
			wep = _instance.wep
			instance_destroy(_instance)
		}
	}
	
	nexthurt = current_frame + 30
    sprite_index = spr_hurt
    image_index = 0
	
	motion_add_m(point_direction(other.x, other.y, x, y), 4)
	
    spirit = scr_skill_get(mut_strong_spirit)
	
    if spirit {
        can_spirit = 1
        spirit_index = 0
    }
	
    reload = 1
    breload = 1
	
    snd_play(snd_lowh)
}

image_alpha = 1
mask_index = mskPlayer
visible = 1

if race == Race.BigDog {
    mask_index = mskScrapBoss
}