if lockstep_stop
	exit

var _gunspr = buttgot ? sprAllyGunTB : sprAllyGun,
	_dx = x + lengthdir_x(-wkick, gunangle),
	_dy = y + lengthdir_y(-wkick, gunangle)

if (gunangle <= 180 && sprite_index != spr_appear) {
	draw_sprite_ext(_gunspr, 0, _dx, _dy, 1, right, gunangle, c_white, image_alpha)
}

draw_sprite_ext(sprite_index, -1, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha)

if (GameCont.underwater) draw_sprite(sprPlayerBubble, -1, x, y)

if (gunangle > 180 && sprite_index != spr_appear) {
	draw_sprite_ext(_gunspr, -1, _dx, _dy, 1, right, gunangle, c_white, 1)
}