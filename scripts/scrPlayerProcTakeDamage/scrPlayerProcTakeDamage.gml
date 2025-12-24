function scrPlayerProcTakeDamage(_amount) {
	var _has_inframes = (nexthurt > current_frame)
	
	totdamagetaken += _amount
	
	if scr_skill_get(mut_sharp_teeth) && _amount {
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
	else if (race == Race.Rogue && !_has_inframes) {
		var _sprite = (bskin == SkinLetter.C) ? sprRogueExplosionC : sprRogueExplosion
		
		with (scr_damage_create(x, y, PopoExplosion)) {
			mask_index = mskExplosion
			sprite_index = _sprite
		}
		
		var _super_blast_armor = scr_ultra_get(Race.Rogue, UltraSkill.SuperBlastArmor)
		if (_super_blast_armor) {
			var _ang = random_angle
			
			repeat (_super_blast_armor * 3) {
				var _x = x + ldrx(32, _ang) + orandom(2),
					_y = y + ldry(32, _ang) + orandom(2)
				
				with (scr_damage_create(_x, _y, PopoExplosion)) {
					mask_index = mskExplosion
					sprite_index = _sprite
				}
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


