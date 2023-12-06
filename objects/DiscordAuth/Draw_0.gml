if active
	exit

y -= hover

if sprite_index == sprButtonDiscord { // this is bad but i cant help it
	image_blend = c_black

	y ++
	draw_self()

	x ++
	draw_self()

	y --
	draw_self()

	x --
}

image_blend = hover ? c_white : c_uigray

draw_set_color(image_blend)

draw_set_halign(fa_left)
draw_set_valign(fa_middle)

var str = "LINK ACCOUNT"

if auth_discord_login && auth_discord_picture == -1
	str = "LOADING" + string_repeat(".", (get_timer() / 333333) % 4)

draw_text_shadow(x + 24, y, str)

draw_set_valign(fa_top)

draw_self()

y += hover