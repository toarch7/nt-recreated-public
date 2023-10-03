/// @description Bars & local mode switch

draw_set_color(c_black)
draw_rectangle(0, -4, view_width, 36, 0)
draw_rectangle(0, view_height - 36, view_width, view_height + 4, 0)
draw_set_color(c_white)



var mx = device_mouse_x_to_gui(0),
	my = device_mouse_y_to_gui(0),
	str = loc("RUN HISTORY")

var pointed = point_in_rectangle(mx, my, 32, view_height - 36, view_width - 32, view_height)

if pointed {
	if !history_pointed {
		history_pointed = true
		snd_play(sndHover)
	}
	
	if mouse_ui_clicked() {
		snd_play(sndMenuScores)
		
		if !instance_exists(DailyList) {
			with instance_create(0, 0, DailyList)
				depth = other.depth - 1
		}
	}
}
else if history_pointed
	history_pointed = false

scrDrawAlignCenter()
draw_bigname(view_width / 2, view_height - 18 - pointed, str, pointed ? c_white : c_uigray)
scrDrawAlignDefault()

draw_sprite_ext(sprDailyListArrow, 0, 48 - pointed, view_height - 18 - pointed, 1, 1, 0, pointed ? c_white : c_uigray, 1)
draw_sprite_ext(sprDailyListArrow, 1, view_width - 48 + pointed, view_height - 18 - pointed, 1, 1, 0, pointed ? c_white : c_uigray, 1)