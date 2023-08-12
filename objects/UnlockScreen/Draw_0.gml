if !visible exit

var _w = 32

draw_set_color(c_black)
draw_set_alpha(0.6)
draw_rectangle(view_xview, view_yview, (view_xview + view_width), (view_yview + view_height), 0)
draw_set_alpha(1)

if splatimg > 1 {
    draw_sprite(skin ? sprBigPortraitSkin : sprBigPortrait, race, ((view_xview + (view_width / 2)) - 60), (view_yview + view_height) - 48 + addy)
    if addy < 2 addy++
}

draw_set_color(c_black)
draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + _w, 0)
draw_rectangle(view_xview, view_yview + view_height, view_xview + view_width, view_yview + view_height - _w, 0)
draw_set_color(c_white)

draw_sprite(sprSkillSplat, splatimg, (view_xview + (view_width / 2)), ((view_yview + view_height) - 20))

var sprt = skin ? sprBigNameCenteredB : sprBigNameCentered

if addy > 0 {
	var name = scrMenuButtonName(sprt, race)
	
	if loc_exists(name) {
		name = loc(name)
		
		if sprt == sprBigNameCenteredB {
			name += loc_exists("unlockscreen_B") ? " " + loc("unlockscreen_B") : " B"
		}
		
		draw_set_halign(fa_center)
		draw_set_valign(fa_center)
		
		draw_bigname(view_xview + view_width / 2, view_yview + view_height - 62 - addy, name, c_white, 1)
		
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
	}
    else {
		draw_sprite_ext(sprt, race, ((view_xview + 1) + (view_width / 2)), ((view_yview + view_height) - 62) - addy, 1, 1, 0, c_black, 1)
	    draw_sprite_ext(sprt, race, ((view_xview + 1) + (view_width / 2)), (((view_yview + 1) + view_height) - 62) - addy, 1, 1, 0, c_black, 1)
	    draw_sprite_ext(sprt, race, (view_xview + (view_width / 2)), (((view_yview + 1) + view_height) - 62) - addy, 1, 1, 0, c_black, 1)
	    draw_sprite(sprt, race, (view_xview + (view_width / 2)), ((view_yview + view_height) - 62) - addy)
	}
}

if addy > 1 {
	if loc_exists("UNLOCKED!") {
		draw_set_halign(fa_center)
		draw_set_valign(fa_center)
		
		draw_bigname(view_xview + view_width / 2, view_yview + view_height - 24 - addy, loc("UNLOCKED!"), c_white, 1)
		
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
	}
	else {
	    draw_sprite_ext(sprTextUnlocked, 0, ((view_xview + 1) + (view_width / 2)), ((view_yview + view_height) - 24) - addy, 1, 1, 0, c_black, 1)
	    draw_sprite_ext(sprTextUnlocked, 0, ((view_xview + 1) + (view_width / 2)), (((view_yview + 1) + view_height) - 24) - addy, 1, 1, 0, c_black, 1)
	    draw_sprite_ext(sprTextUnlocked, 0, (view_xview + (view_width / 2)), (((view_yview + 1) + view_height) - 24) - addy, 1, 1, 0, c_black, 1)
	    draw_sprite(sprTextUnlocked, 0, (view_xview + (view_width / 2)), ((view_yview + view_height) - 24) - addy)
	}
}
if splatimg < 3 splatimg += 1