if lockstep_stop
	exit

if instance_exists(Player) && !instance_exists(Cinematic) {
	scrDrawPlayerHUD(scrPlayerFindLocal())
}

draw_set_halign(fa_center)
draw_set_valign(fa_middle)

with SkillText {
    if !disappear or disappear % 2 == 0 {
		draw_text_nt(x, y, "@d" + loc(txt))
	}
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)

if UberCont.opt_griller && !instance_exists(CrownIcon) && !instance_exists(UltraIcon) && !overgrilled {
	var _press = mouse_ui_clicked(),
		_change = scr_keyboard_check_pressed(vk_right) - scr_keyboard_check_pressed(vk_left),
		
		_mx = device_mouse_x_to_gui(0),
		_my = device_mouse_y_to_gui(0),
		
		_step = 32,
		_count = (view_width - (_step * 2)) div 32,
		_pagemax = maxskill div _count
	
	// simulate initial input
	if (grillpage == -1) _change = 1
	
	if (grillpadchange != 0 && _change == 0) {
		_change = grillpadchange
	}
	
	grillpadchange = 0
	
	if _press {
		if point_in_circle(_mx, _my, 16, view_height - 18, 20) {
			_change = -1
		}
		else if point_in_circle(_mx, _my, view_width - 16, view_height - 18, 20) {
			_change = 1
		}
	}
	
	draw_sprite_ext(sprDailyArrow, 0, 24, view_height - 18, 1, 1, 0, c_ultra, 1)
	draw_sprite_ext(sprDailyArrow, 1, view_width - 24, view_height - 18, 1, 1, 0, c_ultra, 1)
	
	if _change != 0 {
		instance_destroy(SkillIcon)
		
		grillpage += _change
		
		snd_play(sndClick)
		
		if grillpage < 0 {
			grillpage = _pagemax
		}
		else if grillpage > _pagemax {
			grillpage = 0
		}
		
		var _dx = view_xview + view_width / 2,
			_dy = view_yview + view_height - 20,
			_page = grillpage, _num = 0
		
		for(var i = 0; i < _count; i ++) {
			with instance_create(i * 32, _dy, SkillIcon) {
				var _tries = 1
				
				do {
					skill = (i + (_page * _count)) % (maxskill) + _tries
					
					if (++ _tries) > 99 {
						instance_destroy()
						break
					}
				}
				until skill > 0 && !scr_skill_get(skill) && !instance_exists_var_notme(SkillIcon, "skill", skill)
				
				if (skill < 0) skill = maxskill + skill
				
				if (skill < 0 || skill > maxskill) instance_destroy()
				
				num = i
			}
		}
		
		if (_change > 0) {
			with (SkillIcon) num = i--
		}
	}
	
	if !instance_exists(SkillIcon) {
		with instance_create(view_width / 2, view_yview + view_height - 20, SkillIcon) {
			mut = mut_last_wish
		}
		
		overgrilled = true
	}
	
	event_user(0)
}