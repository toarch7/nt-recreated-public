if !active
	exit

var spr = auth_discord_picture,

	s = 1,

	xs = 34 / sprite_get_width(spr),
	ys = 34 / sprite_get_height(spr)

if instance_exists(GameCont) {
	s = 0.5

	xs *= s
	ys *= s
}

draw_sprite_ext(spr, 0, 2, view_height, xs, ys, 0, c_white, 1)

draw_set_font(fntSmall)

draw_set_halign(fa_left)
draw_set_valign(fa_bottom)

draw_text_nt(38 * s, view_height - 6, "@s" + auth_discord_username)

draw_set_valign(fa_top)

draw_set_font(fntM1)