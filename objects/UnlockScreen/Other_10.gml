/// @description Draw
var _w = 32, _race = race, _bskin = bskin

draw_set_color(c_black)
draw_set_alpha(0.6)
draw_rectangle(view_xview, view_yview, (view_xview + view_width), (view_yview + view_height), 0)
draw_set_alpha(1)

if splatimg > 1 {
	var _img = scr_race_get_skin_subimage(_race, _bskin)
    draw_sprite(sprBigPortrait, _img, view_xview_center - 60, view_yview + view_height - 10 + addy)
    if addy < 2 addy ++
}

draw_set_color(c_black)
draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + _w, 0)
draw_rectangle(view_xview, view_yview + view_height, view_xview + view_width, view_yview + view_height - _w, 0)
draw_set_color(c_white)

draw_sprite(sprMutationSplat, splatimg, (view_xview + (view_width / 2)), ((view_yview + view_height) - 20))

var _sprite = -1

/**/ if (_bskin == SkinLetter.A) _sprite = sprBigNameCentered
else if (_bskin == SkinLetter.B) _sprite = sprBigNameCenteredB

if addy > 0 {
	var _xpos = view_xview_center,
		_ypos = view_yview + view_height - 92 - addy,
		_name = scrMenuButtonName(sprBigNameCentered, _race)
	
	if (!sprite_exists(_sprite) || is_string(_name)) {
		if (_bskin > SkinLetter.A) _name += " " + scr_race_get_skin_letter(_bskin)
		
		draw_align(fa_center, fa_middle)
		draw_text_bigname(_xpos, _ypos + 8, _name, c_white, 1, 1)
		draw_align()
	}
    else {
		draw_sprite_ext(_sprite, _race, _xpos + 1, _ypos + 0, 1, 1, 0, c_black, 1)
	    draw_sprite_ext(_sprite, _race, _xpos + 0, _ypos + 1, 1, 1, 0, c_black, 1)
	    draw_sprite_ext(_sprite, _race, _xpos + 1, _ypos + 1, 1, 1, 0, c_black, 1)
	    draw_sprite_ext(_sprite, _race, _xpos + 0, _ypos + 0, 1, 1, 0, c_white, 1)
	}
}

if addy > 1 {
	var _xpos = view_xview_center,
		_ypos = view_yview + view_height - 62 - addy
	
	if loc_exists("Unlock:Unlocked") {
		draw_align(fa_center, fa_middle)
		draw_text_bigname(_xpos, _ypos + 10, loc("Unlock:Unlocked", "UNLOCKED!"), c_white, 1, 1)
		draw_align()
	}
	else {
	    draw_sprite_ext(sprTextUnlocked, 0, _xpos + 1, _ypos + 0, 1, 1, 0, c_black, 1)
	    draw_sprite_ext(sprTextUnlocked, 0, _xpos + 0, _ypos + 1, 1, 1, 0, c_black, 1)
	    draw_sprite_ext(sprTextUnlocked, 0, _xpos + 1, _ypos + 1, 1, 1, 0, c_black, 1)
	    draw_sprite_ext(sprTextUnlocked, 0, _xpos + 0, _ypos + 0, 1, 1, 0, c_white, 1)
	}
}

if can_continue {
	draw_align(fa_center, fa_middle)
	
	var _pointed = (device_mouse_y_to_gui(0) >= (gui_h - LETTERBOX_SIZE)),
		_color = (addy2 || _pointed) ? c_white : c_uigray
	
	if (pointed != _pointed) {
		if (_pointed) snd_play(sndHover)
		pointed = _pointed
	}
	
	draw_text_bigname(view_xview_center, view_yview + view_height - 16 - addy2 - _pointed, loc("GameOver:Unlock", "CONTINUE"), _color)
	draw_align()
	
	if (addy2 > 0) addy2 = approach(addy2, 0, 2)
}

if (splatimg < 3) splatimg += 1