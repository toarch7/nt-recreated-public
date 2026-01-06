if lockstep_stop
	exit

var _x = view_xview_center, _y = view_yview_center

// dark overlay
draw_set_alpha(0.7)
draw_set_color(c_black)

draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + view_height, 0)

draw_set_alpha(1)
draw_set_color(c_white)

// roadmap
scrDrawRoadmap(_x - 48, _y - offsety, round(death_pos))

// outcome
draw_align(fa_center, fa_middle)
draw_sprite(sprKilledBySplat, splatimg, _x + 86, _y - offsety - 32)

var _message = loc("GameOver:KilledBy", "KILLED BY")

if GameCont.win {
	_message = loc("GameOver:Time", "COMPLETION TIME")

	draw_set_color(c_uigray)
	draw_text_nt(_x + 86, _y - offsety - 10, GameCont.timer_string)
	draw_set_color(c_white)
}
else {
	// deathcause
	var _cause = GameCont.deathcause
	
	if scr_death_cause_is_valid(_cause) {
		var _sprite = scrDeathCauseGetSprite(_cause)
		if (sprite_exists(_sprite)) draw_sprite(_sprite, -1, _x + 86, _y - offsety)
		//var _text = scrDeathCauseGetName(_cause)
		//if (is_string(_text)) draw_text_nt(_x + 86, _y - offsety + 32, _text)
	}
}

draw_text_nt(_x + 86, _y - offsety - 25, loc(_message))

draw_set_valign(fa_top)

// advance map
if (death_pos < GameCont.waypoints) death_pos ++

// struggle continues
draw_text_nt(_x, view_yview + 48, text)

draw_align()

if (UberCont.letterbox_frame >= 2) {
	splatimg = approach(splatimg, 2, 0.7 * timescale)
}
else splatimg = 0

draw_sprite(sprGameOverCenterSplat, splatimg, _x, view_yview + view_height - 32)

if (offsety > 0) offsety = approach(offsety, 0, 32 * timescale)

with (PauseButton) y = ystart + other.offsety
