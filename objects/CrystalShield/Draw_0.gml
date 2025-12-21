if lockstep_stop
	exit

var yoff = 0, _juggernaut = scr_player_ultra_get(creator, Race.Crystal, UltraSkill.Juggernaut)

if instance_exists(creator) && sprite_index != spr_disappear {
	shieldright = 1

	if creator.hspeed < 0 {
		shieldright = -1
	}

	yoff = -2

	if _juggernaut {
		var _back_idle = sprCrystalShieldIdleBack,
			_back_walk = sprCrystalShieldWalkBack,
			_skin = creator.bskin
		
		if (_skin == SkinLetter.B) {
			_back_idle = sprCrystalShieldBIdleBack
			_back_walk = sprCrystalShieldBWalkBack
		}
		else if (_skin == SkinLetter.C) {
			_back_idle = sprCrystalShieldCIdleBack
			_back_walk = sprCrystalShieldCWalkBack
		}
		
		if creator.speed != 0 {
			draw_sprite_ext(_back_walk, walk, x, y + 2, shieldright, 1, 0, c_white, 1)
		}
		else {
			draw_sprite_ext(_back_idle, walk, x, y + 2, shieldright, 1, 0, c_white, 1)
		}
	}
}

draw_sprite(sprite_index, -1, x + (time >= 28 ? orandom(time / 28) : 0), y + yoff)

if instance_exists(creator) {
	if _juggernaut && sprite_index != spr_disappear {
		var _front_idle = sprCrystalShieldIdleFront,
			_front_walk = sprCrystalShieldWalkFront,
			_skin = creator.bskin
		
		if (_skin == SkinLetter.B) {
			_front_idle = sprCrystalShieldBIdleFront
			_front_walk = sprCrystalShieldBWalkFront
		}
		else if (_skin == SkinLetter.C) {
			_front_idle = sprCrystalShieldCIdleFront
			_front_walk = sprCrystalShieldCWalkFront
		}
		
		if creator.speed != 0 {
			draw_sprite_ext(_front_walk, walk, x, y, shieldright, 1, 0, c_white, 1)
		}
		else {
			draw_sprite_ext(_front_idle, walk, x, y, shieldright, 1, 0, c_white, 1)
		}
	}
	
	if (teleporting && scr_player_is_local(creator.index) && !is_keyboard(creator.index)) {
		draw_set_alpha(0.5)
		draw_sprite(creator.spr_idle, creator.image_index, teleport_x, teleport_y)
		
		draw_set_alpha(0.3)
		draw_sprite(spr_idle, 3, teleport_x, teleport_y)
		
		draw_set_alpha(1)
	}
}