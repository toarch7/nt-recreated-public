var _gunspr = scr_weapon_get_sprite(wep),
	_gunframe = current_frame * 0.4

if (wep == wep_minigun) _gunspr = sprGoldMinigun

back = (gunangle > 0 && gunangle < 180) ? 1 : -1

if (sprite_exists(_gunspr) && back) {
	draw_sprite_ext(_gunspr, _gunframe % sprite_get_number(_gunspr),
		x, y, image_xscale, image_yscale * right, gunangle, image_blend, image_alpha)
}

draw_sprite_ext(sprite_index, image_index, x, y,
	image_xscale * right, image_yscale, image_angle, image_blend, image_alpha)

if (sprite_exists(_gunspr) && !back) {
	draw_sprite_ext(_gunspr, _gunframe % sprite_get_number(_gunspr),
		x, y, image_xscale, image_yscale * right, gunangle, image_blend, image_alpha)
}
