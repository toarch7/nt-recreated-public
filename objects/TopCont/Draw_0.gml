if lockstep_stop
	exit

wave += 1

var spr = -1

if GameCont.area == 102 {
    spr = sprFog102
}
else if (GameCont.area == 2 or UberCont.halloween) {
    spr = sprFog2
}

if spr != -1 {
    var fogx = floor(view_xview / 480) * 480 + 480 - fogscroll,
		fogy = floor(view_yview / 360) * 360

    for (var xx = -1; xx <= 1; xx ++) {
        for (var yy = -1; yy <= 1; yy ++) {
            draw_sprite_ext(spr, 0, fogx + xx * 480, fogy + yy * 360, 1, 1, 0, c_white, FOG_ALPHA)
        }
    }

    if !UberCont.paused {
        fogscroll += 0.5

        if fogscroll >= 480 {
            fogscroll -= 480
        }
    }
}

with Player {
    if visible {
		var pinst = playerinstance_get(index),
			col = c_white
		
		if pinst != undefined
			col = pinst.color
		
		if !instance_exists(PauseImage) {
	        var ang = KeyCont.dir_fire[index]
			
	        if !UberCont.opt_keyboard or index != global.index or is_gamepad(index) {
	            draw_sprite_ext(sprCrosshair, KeyCont.crosshair[index], x + lengthdir_x(64, ang), y + lengthdir_y(64, ang), 1, 1, 0, col, index == global.index ? 1 : 0.5)
	        }
		}
		
        if KeyCont.players > 1 {
			var _x = clamp(x, view_xview + 8, view_xview + view_width - 8),
				_y = clamp(y - 8, view_yview + 16, view_yview + view_height - 4)
			
            draw_sprite_ext(sprPlayerIndicatorB, index, _x, _y, 1, 1, 0, col, 1)
        }
    }
}

if darkness && !instance_exists(PauseImage) {
	if global.time % 5 == 0 && surface_exists(dark) &&
	(surface_get_width(dark) != view_width or surface_get_height(dark) != view_height) {
		surface_resize(dark, view_width, view_height)
	}
	
	if !instance_exists(GenCont) && !UberCont.paused {
        scrDarkness()
    }

    gpu_set_blendmode(bm_subtract)

    if surface_exists(dark)
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


if !instance_exists(MenuGen) {
    if !instance_exists(NothingSpiral) {
		with Spiral {
	        draw_sprite_ext(sprite_index, - 1, view_xview + x, view_yview + y, image_xscale * 5, image_yscale * 5, image_angle, c_white, 1)
	        draw_sprite_ext(sprite_index, - 1, view_xview + x, view_yview + y, image_xscale * 5, image_yscale * 5, image_angle, c_black, 0.8 - image_xscale)
	    }
	}
	
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)

    with PopupText {
        if !visible
			continue
		
		var _x = clamp(x, view_xview + 20, view_xview + view_width - 20)
			_y = median(y, view_yview + 5, view_yview + view_height - 5)
		
        draw_set_color(c_white)
        draw_text_nt(_x, _y, loc(mytext))
    }

    with LevelUp {
        draw_sprite(sprite_index, - 1, x, y)
    }

    draw_set_halign(fa_left)
    draw_set_valign(fa_top)
}

with WepSwap
	draw_self()

if instance_exists(Portal) {
    with Portal {
        if !(x > view_xview && y > view_yview && x < view_xview + view_width && y < view_yview + view_height) {
            draw_sprite(sprPortalindicator, 0, clamp(x, view_xview + 10, view_xview + view_width - 10), clamp(y, view_yview + 10, view_yview + view_height - 10))
        }
    }
}