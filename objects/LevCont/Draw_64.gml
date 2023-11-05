if lockstep_stop
	exit

if instance_exists(Player) && !instance_exists(Cinematic)
    scrDrawHUD()

draw_set_halign(fa_center)
draw_set_valign(fa_center)

with SkillText {
    if !disappear or disappear % 2 == 0 {
		draw_text_nt(x, y, "@d" + loc(txt))
	}
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)

if UberCont.opt_griller && !instance_exists(CrownIcon) && !instance_exists(UltraIcon) && !overgrilled {
	var press = mouse_ui_clicked(),
		change = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left),
		
		mx = device_mouse_x_to_gui(0),
		my = device_mouse_y_to_gui(0),
		
		step = 32,
		count = (view_width - (step * 2)) div 32,
		pagemax = maxskill div count
	
	if grillpage == -1
		change = 1
	
	if grillpadchange != 0 && change == 0
		change = grillpadchange
	
	grillpadchange = 0
	
	if press {
		if point_in_circle(mx, my, 16, view_height - 18, 20) {
			change = -1
		}
		else if point_in_circle(mx, my, view_width - 16, view_height - 18, 20) {
			change = 1
		}
	}
	
	draw_sprite_ext(sprDailyListArrow, 0,              24, view_height - 18, 1, 1, 0, c_ultra, 1)
	draw_sprite_ext(sprDailyListArrow, 1, view_width - 24, view_height - 18, 1, 1, 0, c_ultra, 1)
	
	if change != 0 {
		with SkillIcon
			instance_destroy()
		
		grillpage += change
		
		snd_play(sndClick)
		
		if grillpage < 0
			grillpage = pagemax
		else if grillpage > pagemax
			grillpage = 0
		
		var dx = view_xview + view_width / 2,
			dy = view_yview + view_height - 20,
			page = grillpage, _num = 0
		
		for(var i = 0; i < count; i ++) {
			with instance_create(i * 32, dy, SkillIcon) {
				var tries = 1
				
				do {
					skill = (i + (page * count)) % (mut_heavy_heart) + tries
					
					if (++ tries) > 99 {
						instance_destroy()
						break
					}
				}
				until skill > 0 && !skill_get(skill) && !instance_exists_var_notme(SkillIcon, "skill", skill)
				
				if skill < 0 {
					skill = mut_heavy_heart + skill
				}
				
				if skill < 0 or skill > mut_heavy_heart
					instance_destroy()
				
				num = i
			}
		}
		
		if change > 0 {
			print("Change!", change)
			
			with SkillIcon
				num = -- i
		}
	}
	
	if !instance_exists(SkillIcon) {
		with instance_create(view_width / 2, view_yview + view_height - 20, SkillIcon) {
			mut = mut_last_wish
		}
		
		overgrilled = true
	}
}