if lockstep_stop
	exit

scrDrawSpiral()

var inst = playerinstance_get(global.index),
	yoff = dailylistfavor

if inst == undefined
	exit

if global.coop {
    var picks = struct_keys(playerinstances),
        n = 0
	
    for (var i = array_length(picks) - 1; i >= 0; i--) {
        var _inst = playerinstance_get(picks[i])

        if _inst.index == global.index or _inst.race == 0
            continue

        var _prt = _inst.skin ? sprBigPortraitSkin : sprBigPortrait,
			_ind = _inst.index, px = ports_x[_ind] - n * 24
		
        draw_sprite_ext(
			_prt, _inst.race,
			
			view_xview + px + view_width + 16,
			view_yview + view_height - 24,
			
			-1, 1,
			0, c_gray, 1)
        
		ports_x[_ind] = lerp(ports_x[_ind], 0, 0.8)

        n ++
    }
}

draw_set_color(c_black)
draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + widescreen, 0)
draw_rectangle(view_xview, view_yview + view_height, view_xview + view_width, view_yview + view_height - widescreen - 0.25, 0)
draw_set_color(c_white)

with CharSelect {
    x = view_xview + 16 + 20 * pos
    y = view_yview + view_height - 32
	
	var c = c_gray,
		spr = sprCharSelectLocked
	
	if selected
		c = c_white
	
	if UberCont.cgot[num] or other.weekly
		spr = sprCharSelect
	
    draw_sprite_ext(spr, num, x, y + yoff + 16, 1, 1, 0, c, 1)
}

with CharSelect {
    if UberCont.cgot[num] && UberCont.ctot_dead[num] <= 0 && num != 0
        draw_sprite(sprNew, - 1, x - 6, y + yoff + 6)
}

with GoButton {
	x = view_xview + view_width - 24 + yoff * 4
    y = view_yview + view_height - 12
	
	event_perform(ev_draw, 0)
}