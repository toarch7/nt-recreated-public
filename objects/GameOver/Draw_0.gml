if lockstep_stop
	exit

var xx = view_xview + view_width / 2,
	yy = view_yview + view_height / 2

//GAME OVER
draw_set_color(c_black)
draw_set_alpha(0.7)
draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + view_height, 0)
draw_set_alpha(1)
draw_set_color(c_white)

///ROADMAP
scrDrawRoadmap(xx - 48, yy - offsety, round(death_pos))
///

draw_set_halign(fa_center)
draw_set_valign(fa_center)


draw_sprite(sprScoreSplat, 2, xx + 86, yy - offsety - 25)


var msg = "KILLED BY"

if GameCont.win {
	msg = "COMPLETION TIME"

	draw_set_color(c_uigray)
	draw_text_shadow(xx + 86, yy - offsety - 10, GameCont.time)
	draw_set_color(c_white)
}
if GameCont.last_hit > 0 {
    draw_sprite(GameCont.last_hit, - 1, xx + 86, yy - offsety)
}

draw_text_shadow(xx + 86, yy - offsety - 25, loc(msg))

draw_set_valign(fa_top)

if death_pos < GameCont.waypoints {
    death_pos++
}

draw_set_color(c_black)
draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + 32, 0)
draw_rectangle(view_xview, view_yview + view_height, view_xview + view_width, view_yview + view_height - 32, 0)

draw_set_color(c_white)

draw_text_shadow(xx, view_yview + 48, text)

if UberCont.continued_run {
    draw_set_font(fntSmall)
    draw_set_alpha(0.1)
	
	var str = "continued"
	
	if global.recontinues > 0
		str = "continued x" + string(global.recontinues)
	
    draw_text(xx, view_yview + 59, str)
    
	draw_set_alpha(1)
    draw_set_font(fntM1)
}

draw_set_halign(fa_left)

draw_sprite(sprGameOverCenterSplat, 2, xx, view_yview + view_height - 32)

if offsety offsety -= 32

with PauseButton {
    y = ystart + other.offsety
}
