#macro FOG_ALPHA 0.1

darkness = 0

dark = -1

if instance_exists(Player) {
    if GameCont.area && GameCont.area != 106 && round(GameCont.area / 2) == GameCont.area / 2 {
        darkness = 1
    }
}

if darkness {
    dark = surface_create(view_width, view_height)
	
    surface_set_target(dark)
    draw_clear(c_white)
    surface_reset_target()
}

col = merge_color(c_ltgray, c_white, 0.7)
crosshair = save_get_value("visual", "crosshair", 0)

gameovertime = 0
wave = 0
fogscroll = 0
drawcontrols = 1

daily_time = "24:00:00"

if UberCont.daily_run {
    daily_time = scrTime(UberCont.daily_time)
}

alarm[0] = 1

instance_create(0, 0, SubTopCont)

