if lockstep_stop
	exit

wave += timescale

var spr = -1

if (GameCont.area == area_pizza_sewers) {
    spr = sprFog102
}
else if (GameCont.area == area_sewers || UberCont.halloween) {
    spr = sprFog2
}

if spr != -1 {
    var fogx = floor(view_xview / 480) * 480 + 480 - fogscroll,
		fogy = floor(view_yview / 360) * 360

    for (var _x = -1; _x <= 1; _x ++) {
        for (var _y = -1; _y <= 1; _y ++) {
            draw_sprite_ext(spr, 0, fogx + _x * 480, fogy + _y * 360, 1, 1, 0, c_white, FOG_ALPHA)
        }
    }

    if !UberCont.paused {
        fogscroll += timescale * 0.5

        if fogscroll >= 480 {
            fogscroll -= 480
        }
    }
}

with Player {
    if (!visible) continue
	
	var _pinst = scr_playerinstance_find(index),
		_color = ((_pinst != undefined) ? _pinst.color : c_white)
	
	if (!instance_exists(PauseImage)) {
	    var _direction = KeyCont.dir_fire[index]
		
	    if !UberCont.opt_keyboard || index != global.index || is_gamepad(index) {
			var _distance = KeyCont.dis_fire[index]
			
			//if (UberCont.opt_fixsight && (index == global.index)) s = 1
			
			var _x = x + lengthdir_x(16 + _distance, _direction),
				_y = y + lengthdir_y(16 + _distance, _direction),
				_is_active = (is_gamepad(index) || _distance > 16),
				_alpha = min(1, crosshair_alpha)
			
			if (scr_player_is_local(index)) {
				crosshair_alpha = lerp(crosshair_alpha, _is_active ? 5 : 0, 0.4)
			}
			else {
				crosshair_alpha = 1
			}
			
			crosshair_x = lerp(crosshair_x, _x, 0.8)
			crosshair_y = lerp(crosshair_y, _y, 0.8)
			
			if (index != global.index) _alpha *= 0.5
			
	        draw_sprite_ext(sprCrosshair, KeyCont.crosshair[index],
				crosshair_x, crosshair_y, 1, 1, 0, (_color ? _color : c_white), _alpha)
	    }
	}
	
    if (player_count > 1) {
		var _x = clamp(x, view_xview + 8, view_xview + view_width - 8),
			_y = clamp(y, view_yview + 28, view_yview + view_height - 4)
		
        draw_sprite_ext(sprPlayerIndicator, index + 1, _x, _y, 1, 1, 0, _color, 1)
    }
}

if darkness && surface_exists(dark) {// && !instance_exists(PauseImage) {
	gpu_set_blendmode(bm_subtract)
	draw_surface_ext(dark, view_xview, view_yview, 1, 1, 0, c_white, 1)
	gpu_set_blendmode(bm_normal)
}

if instance_exists(Player) {
	with Revive {
	    var _x = clamp(x, view_xview + 30, view_xview + view_width - 30),
			_y = clamp(y - 16, view_yview + 6, view_yview + view_height - 6)
		
	    draw_sprite(sprFaintedBar, 0, _x, _y)
		
		    _x -= 16
	    _y -= 5
		
	    if alarm[4] {
	        draw_set_color(merge_color(c_red, c_black, 0.5 + sin(GameCont.tottimer / 4) * 0.25))
	        draw_rectangle(_x + 2, _y + 2, _x + 2 + alarm[4] / 300 * 28, _y + 6, 0)
	    }
		else if alarm[5] {
	        draw_set_color(c_red)
	        draw_rectangle(_x + 2, _y + 2, _x + alarm[5] / 30 * 28, _y + 6, 0)
	    }
		
	    _x += 16
	    _y += 5
		
	    draw_set_color(c_white)
	}
}

if !scrGameIsGenerationScreen() {
    if (!instance_exists(NothingSpiral)) {
		with (Spiral) {
	        draw_sprite_ext(sprite_index, -1, view_xview + x, view_yview + y, (image_xscale * 10), (image_yscale * 10), (image_angle + 45), c_white, 1)
	        draw_sprite_ext(sprite_index, -1, view_xview + x, view_yview + y, (image_xscale * 10), (image_yscale * 10), (image_angle + 45), c_black, (0.8 - image_xscale))
	    }
	}
	
	draw_align(fa_center, fa_middle)

    with (PopupText) if (visible) {
		var _x = clamp(x, view_xview + 20, view_xview + view_width - 20)
			_y = median(y, view_yview + 5, view_yview + view_height - 5)
		
		draw_set_color(c_white)
		draw_text_nt(_x, _y, mytext)
	}
	
	with (LevelUp) draw_sprite(sprite_index, -1, x, y)
	
	draw_align()
}

with Portal {
    if !(x > view_xview && y > view_yview && x < view_xview + view_width && y < view_yview + view_height) {
        draw_sprite(sprPortalindicator, 0,
			clamp(x, view_xview + 10, view_xview + view_width - 10),
			clamp(y, view_yview + 10, view_yview + view_height - 10))
    }
}

with (UnlockScreen) if (visible) {
	event_user(0)
}
