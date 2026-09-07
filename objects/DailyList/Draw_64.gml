if lockstep_stop
	exit

var keys = viewtype == "weekly" ? weeklykeys : dailykeys
var typehistory = history[$ viewtype]
var yy = 48
var len = array_length(keys)
var kills = history.kills[viewtype == "weekly"]

var perpage = 6
var maxpages = ceil(len / perpage)

if (instance_exists(Menu)) {
    if (alpha < 0.8) {
		if (alpha >= 0.5) {
			alpha += 0.1
		}
		else {
			alpha = 0.5
		}
	}
	
    draw_set_color(c_black)
    draw_set_alpha(alpha)
    draw_rectangle(0, 0, view_width, view_height, 0)
    draw_set_alpha(1)
    draw_set_color(c_white)
}
else {
    draw_align(fa_center, fa_middle)
	
	/// @loc:token [R:MainMenu] RunHistory:daily "DAILY"
	/// @loc:token [R:MainMenu] RunHistory:weekly "WEEKLY"
	var _viewtype_string = loc(
		"R:MainMenu", "RunHistory:" + string_lower(viewtype), string_upper(viewtype))
    
	draw_text_bigname(view_width / 2, 16, _viewtype_string, c_uigray)
	
    draw_align()
}

if (!array_length(keys)) {
    draw_align(fa_center, fa_middle)
    draw_text_nt(view_width / 2, view_height / 2, loc("R:MainMenu:RunHistoryEmpty", "@wRUN HISTORY IS EMPTY"))
    draw_align()
    exit
}

var avg = kills / len

draw_align(fa_center, fa_top)
/// @loc:token [R:MainMenu] RunHistoryScoreAVG "@dSCORE AVG."
draw_text_nt(view_width div 2, 27, loc("R:MainMenu:RunHistoryScoreAVG", "@dAVG. SCORE") + ":" + string(avg))

#region Page controls

draw_text_nt(view_width / 2, view_height - 18, string(page + 1) + "/" + string(maxpages))

var touchr = 0,
    touchl = 0

if maxpages > 1 {
    var mx = device_mouse_x_to_gui(0)
    var my = device_mouse_y_to_gui(0)

    draw_sprite_ext(sprDailyArrow, 0, view_width / 2 - 96, view_height - 16, 1, 1, 0, c_white, 1)
    draw_sprite_ext(sprDailyArrow, 1, view_width / 2 + 96, view_height - 16, 1, 1, 0, c_white, 1)

    if mouse_check_button_pressed(mb_left) {
        if point_in_circle(mx, my, view_width / 2 - 96, view_height - 16, 16) {
            snd_play(sndClick)
            touchl = 1
        }
		else if point_in_circle(mx, my, view_width / 2 + 96, view_height - 16, 16) {
            snd_play(sndClick)
            touchr = 1
        }
    }

    if touchr or gamepad_button_check_pressed(0, gp_padr) or scr_keyboard_check_pressed(vk_right) {
        page ++
		
		snd_play(sndClick)
		time = 0

        if page >= maxpages {
            page = 0
        }
    }
	else if touchl or gamepad_button_check_pressed(0, gp_padl) or scr_keyboard_check_pressed(vk_left) {
        page --
		
		snd_play(sndClick)
		time = 0

        if page < 0 {
            page = maxpages - 1

            if page < 0 {
                page = 0
            }
        }
    }
}

var pg = page * perpage
var maxpg = pg + perpage

if (maxpg > len) maxpg = len

#endregion

time ++

draw_align()
for (var i = pg; i < maxpg; i++) {
    var anim = clamp(time - (i - pg), 0, 3)
	
	var run_id = keys[i],
		run = typehistory[$ run_id],
		has_skills = array_length(run.skills),
		has_ultra = is_array(run[$ "ultra_hud"]) || variable_struct_exists(run, "ultra")
	
    var str = month_name_short(run.month) + ". " + string_pad_zeroes(run.day, 1) + " " + scrAreaGetMapName(run.area, run.subarea, run.loop, false, false)
	
    draw_sprite(sprDailyHistorySplat, anim, view_width / 2, yy + 3)
	
	if (anim >= 1) draw_text_nt(27, yy + 2 - 6 * (has_skills || has_ultra), str)
	
	if anim >= 2 {
	    if (variable_struct_exists(run, "deathcause") || is_string(run.killed_by)) {
	        var spr;
			
			if (variable_struct_exists(run, "deathcause")) {
				spr = scrDeathCauseGetSprite(run.deathcause)
			}
			else {
				spr = asset_get_index(run.killed_by)
		        if (!sprite_exists(spr)) spr = mskNone
			}
			
			/**/ if (spr == sprNothing2Idle) spr = sprKilledByThrone2
			else if (spr == sprNothingMiddle) spr = sprKilledByThrone
			
	        draw_sprite_ext(spr, frame, view_width - 96, yy + 3, 0.7, 0.7, 0, c_white, 1)
	    }
		
	    draw_sprite(sprKillsIcon, 0, view_width - 72, yy + 3)
	    draw_text_nt(view_width - 56, yy, string(run.kills))
		
		var _extra_weps = run[$ "extra_weps"]
		
		if (is_array(_extra_weps) && array_length(_extra_weps)) {
			var _wep_list = array_union([ run.wep, run.bwep ], _extra_weps),
				_count = array_length(_wep_list),
				_dx = view_width * 0.5 - _count * 3 + 10,
				_dy = yy - _count * 2 + 6
			
			for(var i = 0; i < _count; ++i) {
				draw_set_alpha(i >= 2 ? power(0.8, i - 2) : 1)
				self.__draw_weapon(_wep_list[i], _dx + i, _dy)
				
				_dx += 5
				_dy += 3
			}
			
			draw_set_alpha(1)
			
	        draw_sprite_ext(
				sprLoadoutCrown, run.crown,
				
				view_width div 2 + min(3, _count) - 12,
				yy + min(3, _count) * 0.5 + 2,
				
				0.5, 0.5, 0, c_white, 1)
		}
	    else if (run.bwep) {
	        self.__draw_weapon(run.bwep, view_width / 2 + 10 + 4, yy + 4)
	        self.__draw_weapon(run.wep, view_width / 2 + 10 - 4, yy - 2)
			
	        draw_sprite_ext(sprLoadoutCrown, run.crown,
				view_width div 2 - 4, yy, 0.5, 0.5, 0, c_white, 1)
	    }
		else {
	        draw_sprite_ext(sprLoadoutCrown, run.crown,
				view_width div 2 - 4, yy + 3, 0.5, 0.5, 0, c_white, 1)
	        
			self.__draw_weapon(run.wep, view_width div 2 + 10, yy + 3)
	    }
		
	    draw_sprite(sprMapIcon, scr_race_get_skin_subimage(run.race, run.skin), 14, yy + 4)
	}
	
	if anim >= 3 {
	    var skills = run.skills,
			len = array_length(skills),
			px = 0
		
		if (is_array(run[$ "ultra_hud"])) {
			var ultras = run.ultra_hud,
				ultra_count = array_length(ultras)
			
			for(var i = 0; i < ultra_count; ++i) {
				draw_sprite_ext(sprEGIconHUD, ultras[i], 30 + px * 8, yy + 10, 0.5, 0.5, 0, c_white, 1)
				px ++
			}
		}
		else if (variable_struct_exists(run, "ultra")) {
			var _img = run.race * 3 + run.ultra
			draw_sprite_ext(sprEGIconHUD, _img, 30 + px * 8, yy + 10, 0.5, 0.5, 0, c_white, 1)
			px ++
		}
		
	    for (var j = 0; j < len; j++) {
	        var skill = skills[j]
			
	        draw_sprite_ext(sprSkillIconHUD, skill, 30 + px * 8, yy + 10, 0.5, 0.5, 0, c_white, 1)
			
	        if skill == run.patienceskill {
	            draw_sprite_ext(sprPatienceIconHUD, 0, 30 + px * 8, yy + 10, 0.5, 0.5, 0, c_white, 1)
	        }
			
	        px ++
	    }
	}

    yy += 30 - (3 - anim)

    if yy >= view_height - 32
        break
}

frame += 0.4