function scrPlayerProcTakeDamage(_amount) {
	totdamagetaken += _amount
	
	if scr_skill_get(mut_sharp_teeth) {
		var _left = view_xview,
			_top = view_yview,
			_right = _left + view_width,
			_bottom = _top + view_height,
			_player = id
		
        with enemy {
            if x > _left && x < _right && y > _top && y < _bottom {
                target = other.id
				
                if instance_exists(target) && team == team_enemy {
                    with instance_create(x, y, SharpTeeth) {
                        damage = _amount * 2
                        target = other.id
						creator = _player
                    }
                }
            }
        }
    }
	
	if race == Race.Crystal && totdamagetaken >= 100 && !scr_race_is_skin_unlocked(Race.Crystal, SkinLetter.C) {
		if (totdamagetaken >= 100) scrRaceUnlockSkin(Race.Crystal, SkinLetter.C)
	}
	else if (race == Race.Rogue) {
		var _sprite = (bskin == SkinLetter.C) ? sprRogueExplosionC : sprRogueExplosion
		
		with (scr_damage_create(x, y, PopoExplosion)) {
			mask_index = mskExplosion
			sprite_index = _sprite
		}
		
		repeat (scr_ultra_get(Race.Rogue, UltraSkill.SuperBlastArmor) * 3) {
			with (scr_damage_create(x + orandom(2), y + orandom(2), PopoExplosion)) {
				mask_index = mskExplosion
				sprite_index = _sprite
			}
		}
		
		snd_play(sndIDPDNadeExplo)
	}
	else if (race == Race.BigDog) {
		UberCont.ctot_uniq[Race.BigDog] += _amount
	}
	else if (race == Race.Cuz) {
		if (cuz_ammo < cuz_ammo_max) {
			if (scr_skill_get(mut_throne_butt)) {
				cuz_ammo = cuz_ammo_max
			}
			else cuz_ammo ++
		}
	}
}


