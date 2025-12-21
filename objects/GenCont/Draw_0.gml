if lockstep_stop
	exit

if instance_exists(Cinematic)
	exit

scrDrawSpiral()

var _text_generating = loc("GENERATING...")

with Player {
	if scr_player_is_local(index) && race == Race.Venuz && GameCont.level >= 10 {
	    _text_generating = loc("VERIFYING...")
	}
}

var _progress = instance_number(Floor) / goal,
	_percentage = string_pad_zeroes(round(_progress * 100), 2) + "%"

draw_set_color(#7d838d)
draw_set_halign(fa_center)

var _cx = view_xview_center,
	_cy = view_yview_center

draw_text_nt(_cx, _cy - 54, $"{_text_generating} {_percentage}")
draw_text_nt(_cx, _cy + 24, "@s" + loc(string(tip)))

draw_set_halign(fa_left)
draw_set_color(c_white)

scrDrawRoadmap(_cx, _cy, GameCont.waypoints)