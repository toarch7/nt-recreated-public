if !active
	exit

var spr = auth_discord_picture,

	s = 1,

	xs = 32 / sprite_get_width(spr),
	ys = 32 / sprite_get_height(spr)

if instance_exists(GameCont) {
	s = 0.35

	xs *= s
	ys *= s
}

draw_sprite_ext(spr, 0, 2, view_height - 2, xs, ys, 0, c_white, 1)

draw_set_font(fntSmall)
draw_set_halign(fa_left)

draw_set_color(c_white)
draw_text_shadow(40 * s, view_height - 14, auth_discord_username)

draw_set_font(fntM1)