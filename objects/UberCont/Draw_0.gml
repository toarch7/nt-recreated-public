letterbox_frame = approach(letterbox_frame, letterbox ? 3 : 0, timescale)

if bossintro {
    if (pausespr && sprite_exists(pausespr)) {
        draw_sprite_ext(pausespr, 0, view_xview, view_yview, 1, 1, 0, c_white, 1)
    }
	
	//
    draw_set_color(c_black)
    draw_set_alpha(0.7)
    draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + view_height, 0)
    draw_set_alpha(1)
	
	//
    draw_set_color(c_white)
	
	if (letterbox_frame != 0) scrDrawLetterbox(letterbox_frame)
	
    if boss != 4 && boss != 6 && boss != 9 && boss != 7 && boss != 8 {
        draw_sprite(sprBossIntroBackLayer, boss, view_xview + view_width / 2 + bossx * 1.6, view_yview)// - 31)
    }
	
    draw_sprite(sprBossIntro, boss, view_xview + view_width / 2 + bossx, view_yview)// - 31)
	
    if boss == 4 || boss == 6 || boss == 9 || boss == 7 || boss == 8 {
        draw_sprite(sprBossIntroBackLayer, boss, view_xview + view_width / 2 + bossx * 0.5, view_yview)// - 31)
    }
	
    if bossx > 20 || bossx < 5 {
        bossx -= 60
    }
	else {
		bossx -= 0.5
	}
	
    if bossx < 20 {
        draw_sprite(sprBossNameSplat, splatindex, view_xview + view_width / 2, view_yview + view_height / 2)
		
        if splatindex < 3 {
            splatindex++
        }
		
		var name = scrMenuButtonName(sprBossName, boss)
		
		if loc_exists(name) {
	        draw_set_halign(fa_left)
			draw_set_valign(fa_middle)
			
			draw_text_bigname(view_xview + view_width / 2 + bossnamex, view_yview + view_height / 2, loc(name), c_white, 1)
			
			draw_set_halign(fa_left)
			draw_set_valign(fa_top)
		}
		else {
			draw_sprite_ext(sprBossName, boss, view_xview + view_width / 2 + 1 + bossnamex, view_yview + view_height / 2, 1, 1, 0, c_black, 1)
	        draw_sprite_ext(sprBossName, boss, view_xview + view_width / 2 + 1 + bossnamex, view_yview + view_height / 2 + 1, 1, 1, 0, c_black, 1)
	        draw_sprite_ext(sprBossName, boss, view_xview + view_width / 2 + 1 + bossnamex, view_yview + view_height / 2 + 1, 1, 1, 0, c_black, 1)
	        draw_sprite(sprBossName, boss, view_xview + view_width / 2 + bossnamex, view_yview + view_height / 2)
		}
		
        if bossx < 5 {
            bossnamex += 20
        }
		else bossnamex += 0.5
    }
}
else if paused && sprite_exists(pausespr) {
	draw_sprite_ext(pausespr, 0, view_xview, view_yview, 1, 1, 0, c_white, 1)
	
	scrMenuDrawPlayersOrdered(view_xview, view_yview, scrCampfireMenuDrawRacePortrait)
	
	//
	draw_set_alpha(0.7)
    draw_set_color(c_black)
    draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + view_height, 0)
    draw_set_alpha(1)
	draw_set_color(c_white)
    
	//
    var yoff = (scrGameIsEventRun() || scrGameIsHardmode()) ? 4 : 0
	
	if loc_exists("PAUSED") {
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		
		draw_text_bigname(view_xview + view_width / 2 + 1, view_yview + 52 + 1 - yoff, loc("PAUSED"), c_white)
		
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
	}
	else {
	    draw_sprite_ext(sprPaused, 0, view_xview + view_width / 2 + 1, view_yview + 52 + 1 - yoff, 1, 1, 0, c_black, 1)
	    draw_sprite(sprPaused, 0, view_xview + view_width / 2, view_yview + 52 - yoff)
	}
	
    draw_sprite(sprCharSplat, splatindex, view_xview, view_yview + view_height - 31)
    draw_sprite_ext(sprCharSplat, splatindex, view_xview + view_width, view_yview + view_height - 31, -1, 1, 0, c_white, 1)

    scrDrawRoadmap(view_xview + view_width / 2, view_yview + view_height / 2, 1000)
	
	if pause_portrait_anim != 0 {
		var _amount = min(pause_portrait_anim, 180)
			
		if (_amount == -2) pause_portrait_anim = 0
		else if (_amount == 90) pause_portrait_anim = -2
		else pause_portrait_anim = 90
	}
}

if (!bossintro && letterbox_frame != 0) {
	scrDrawLetterbox(letterbox_frame)
}

if opt_gamepad && instance_exists(ParButton) {
	with ParButton {
		if object_index == SkillIcon || object_index == CrownIcon || object_index == UltraIcon {
			if selected draw_gamepad_button(gp_face1, 0, bbox_right, bbox_top)
		}
	}
}

//scrDrawRoadmap(mouse_x, mouse_y + 16, 0)
//draw_sprite(sprMap, 0, mouse_x, mouse_y + 32)