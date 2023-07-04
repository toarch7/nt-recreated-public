if bossintro {
    if pausespr && sprite_exists(pausespr) {
        draw_sprite_ext(pausespr, 0, view_xview, view_yview, 1, 1, 0, c_white, 1)
    }

    with TopCont {
        if darkness && surface_exists(dark) {
            draw_set_blend_mode(bm_subtract)
            draw_surface(dark, view_xview, view_yview)
            draw_set_blend_mode(bm_normal)
        }
    }

    draw_set_color(c_black)
    draw_set_alpha(0.5)
    draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + view_height, 0)
    draw_set_alpha(1)

    var _w = 36
    draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + 36, 0)
    draw_rectangle(view_xview, view_yview + view_height, view_xview + view_width, view_yview + view_height - 36, 0)
	
    draw_set_color(c_white)
	
    if boss != 4 && boss != 6 && boss != 9 && boss != 7 && boss != 8 {
        draw_sprite(sprBossIntroBackLayer, boss, view_xview + view_width / 2 + bossx * 1.6, view_yview + view_height / 2 - 31)
    }
	
    draw_sprite(sprBossIntro, boss, view_xview + view_width / 2 + bossx, view_yview + view_height / 2 - 31)
	
    if boss == 4 or boss == 6 or boss == 9 or boss == 7 or boss == 8 {
        draw_sprite(sprBossIntroBackLayer, boss, view_xview + view_width / 2 + bossx * 0.5, view_yview + view_height / 2 - 31)
    }
	
    if bossx > 20 or bossx < 5 {
        bossx -= 60
    } else bossx -= 0.5
	
    if bossx < 20 {
        draw_sprite(sprBossNameSplat, splat_index, view_xview + view_width / 2, view_yview + view_height / 2)
		
        if splat_index < 3 {
            splat_index++
        }
		
		var name = scrMenuButtonName(sprBossName, boss)
		
		if loc_exists(name) {
	        draw_set_halign(fa_left)
			draw_set_valign(fa_center)
			
			draw_bigname(view_xview + view_width / 2 + bossnamex, view_yview + view_height / 2, loc(name), c_white, 1)
			
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
	var names = struct_keys(playerinstances),
		length = array_length(names),
		pos = 0
	
	draw_sprite_ext(pausespr, 0, view_xview, view_yview, 1, 1, 0, c_white, 1)
	
    draw_set_color(c_black)

    for (var i = 0; i < length; i++) {
        var pinstance = playerinstances[$ names[i]]
        var prt = sprBigPortrait

        if pinstance.skin {
            prt = sprBigPortraitSkin
        }

        if pinstance.race == 9 && pinstance.hp <= 0 {
            prt = sprPortraitChickenHeadless
        }
		else if pinstance.race == 10 && pinstance.skin && GameCont.area == 5 {
            prt = sprPortraitRebelHooded
        }

        if global.index == i {
            draw_sprite(prt, pinstance.race, view_xview - 160 + splat_index * 45, view_yview + view_height - 28)
        }
		else {
            draw_sprite_ext(prt, pinstance.race, view_xview + view_width + 128 - splat_index * 45 + pos * 36, view_yview + view_height - 24, - 1, 1, 0, c_white, 1)
            pos ++
        }
    }

    draw_set_alpha(0.5)
    draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + view_height, 0)
    draw_set_alpha(1)

    var yoff = (daily_run or global.hardmode) * 4
	
	if loc_exists("PAUSED") {
		draw_set_halign(fa_center)
		draw_set_valign(fa_center)
		
		draw_bigname(view_xview + view_width / 2 + 1, view_yview + 52 + 1 - yoff, loc("PAUSED"), c_white)
		
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
	}
	else {
	    draw_sprite_ext(sprTextPaused, 0, view_xview + view_width / 2 + 1, view_yview + 52 + 1 - yoff, 1, 1, 0, c_black, 1)
	    draw_sprite(sprTextPaused, 0, view_xview + view_width / 2, view_yview + 52 - yoff)
	}
	
    var _w = 36
    draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + _w, 0)
    draw_rectangle(view_xview, view_yview + view_height, view_xview + view_width, view_yview + view_height - _w, 0)

    draw_sprite(sprCharSplat, splat_index, view_xview, view_yview + view_height - 31)
    draw_sprite_ext(sprCharSplat, splat_index, view_xview + view_width, view_yview + view_height - 31, - 1, 1, 0, c_white, 1)

    scrDrawRoadmap(view_xview + view_width / 2, view_yview + view_height / 2, 1000)
}

