//GAME OVER
draw_set_color(c_black)
draw_set_alpha(0.7)
draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + view_height, 0)
draw_set_alpha(1)
draw_set_color(c_white)

///ROADMAP
scrDrawRoadmap(view_xview + view_width / 2 - 48, view_yview + view_height / 2 - offsety, round(death_pos))
///

draw_set_halign(fa_center)
draw_set_valign(fa_center)


draw_sprite(sprScoreSplat, 2, view_xview + view_width / 2 + 86, view_yview + view_height / 2 - offsety - 25)

if GameCont.last_hit > 0 {
    draw_sprite(GameCont.last_hit, - 1, view_xview + view_width / 2 + 86, view_yview + view_height / 2 - offsety)
}

draw_text_shadow(view_xview + view_width / 2 + 86, view_yview + view_height / 2 - offsety - 25, loc("KILLED BY"))

draw_set_valign(fa_top)

if death_pos < GameCont.waypoints {
    death_pos++
}

/*
if kills < 200 && !GameCont.loops && UberCont.daily_run {
    draw_text_nt(view_xview + view_width / 2, view_yview - view_height + 72, "@rNOT ENOUGH KILLS")
}
*/

draw_set_color(c_black)
draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + 32, 0)
draw_rectangle(view_xview, view_yview + view_height, view_xview + view_width, view_yview + view_height - 32, 0)

draw_set_color(c_white)

draw_text_shadow(view_xview + view_width / 2, view_yview + 48, text)

if UberCont.continued_run {
    draw_set_font(fontSmall)
    draw_set_alpha(0.1)
    draw_text(view_xview + view_width / 2, view_yview + 59, "continued")
    draw_set_alpha(1)
    draw_set_font(fntL)
}

draw_set_halign(fa_left)

draw_sprite(sprGameOverCenterSplat, 2, view_xview + view_width / 2, view_yview + view_height - 32)

if offsety offsety -= 32

with PauseButton {
    y = ystart + other.offsety
}

/*if instance_exists(CoopController) {
	draw_set_halign(fa_right)
	
	var txt = ""
	
	with CoopController {
		if errorcount {
			txt = "@w" + string(errorcount) + " @sFATAL ERRORS"
			
			if errorcount > errormax {
				if global.time % 30 > 15 {
					txt += " #@yNEW BEST!"
				} else txt += " #@sNEW BEST!"
			}
		}
	}
	
	draw_text_nt(view_xview + view_width + 9, view_yview + view_height - 30, txt)
	
	draw_set_halign(fa_left)
}*/