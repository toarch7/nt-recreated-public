function scrPlayerProcTakeDamage(_amount = 0) {
	if skill_get(Mut.SharpTeeth) {
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
		
		lsthealth = hp
    }
	
	if race == Race.Rogue {
		with scr_projectile_create(x, y, PopoExplosion) image_rescale(0.5)
		
		repeat scrUltraCheck(race, UltraSkill.SuperBlastArmor) * 3 {
			with scr_projectile_create(
				x + orandom(2), y + orandom(2), PopoExplosion
			) {
				image_rescale(0.5)
			}
		}
		
		snd_play(sndIDPDNadeExplo)
	}
	else if race == Race.BigDog {
		UberCont.ctot_uniq[Race.BigDog] += _amount
	}
}