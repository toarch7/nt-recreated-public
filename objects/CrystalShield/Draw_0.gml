if lockstep_stop
	exit

var yoff = 0, _juggernaut = scrUltraCheckPlayerRace(creator, Race.Crystal, UltraSkill.Juggernaut)

if instance_exists(creator) && sprite_index != spr_disappear {
	shieldright = 1

	if creator.hspeed < 0 {
		shieldright = -1
	}

	yoff = -3

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
		
		if !creator.speed {
			draw_sprite_ext(_back_idle, walk, x, y + 6, shieldright, 1, 0, c_white, 1)
		}
		else {
			draw_sprite_ext(_back_walk, walk, x, y + 6, shieldright, 1, 0, c_white, 1)
			walk += 0.4
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
			draw_sprite_ext(_front_idle, walk, x, y + 4, shieldright, 1, 0, c_white, 1)
		}
		else {
			draw_sprite_ext(_front_walk, walk, x, y + 4, shieldright, 1, 0, c_white, 1)
		}
	}
	
	if creator.index == global.index {
		if scr_skill_get(mut_throne_butt) {
			var _f = instance_nearest(mouse_x, mouse_y, Floor)
			var _px = _f.x + _f.sprite_width / 2
			var _py = _f.y + _f.sprite_height / 2

			draw_set_alpha(0.5)
			draw_sprite(creator.spr_idle, creator.image_index, _px, _py)
			draw_set_alpha(0.3)
			draw_sprite(spr_idle, 3, _px, _py)
			draw_set_alpha(1)
		}
	}
}