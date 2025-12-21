if lockstep_stop
	exit

image_blend = hover ? c_white : c_uigray

var _img = min(3, floor(splat + 1)),
	_side = (_img > 1 ? -1 : 1)

draw_sprite_ext(sprBossNameSplat, _img, x - 10 * _side, y - (_img > 1 ? 5 : 3),
	image_xscale * _side, image_yscale, image_angle, image_blend, image_alpha)

draw_sprite_ext(sprite_index, image_index, x, y - hover,
	image_xscale, image_yscale, image_angle, image_blend, image_alpha)

if (hover) {
	draw_align(fa_right, fa_middle)
	draw_set_color(_img == 3 ? c_white : c_silver)
	var _string = $"{loc("ACHIEVEMENTS")}\n@s{unlocks}/{achievementmax} ({floor(progress * 100)}%)"
	draw_text_nt(x - 20, y + _img - 3, _string)
	draw_set_color(c_white)
	draw_align()
}