if !active {
	event_inherited()

	x = view_xview + 16
	y = view_yview + view_height - 48
}
else visible = true

if auth_discord_login && auth_discord_picture != -1 {
	if sprite_get_width(auth_discord_picture) > 1 && !active {
		sprite_index = mskNone
		active = true
	}
}

if (instance_exists(GameCont) && !instance_exists(GenCont) && !UberCont.paused) or instance_exists(Menu) or instance_exists(Vlambeer)
	visible = false
