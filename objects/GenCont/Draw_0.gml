if lockstep_stop
	exit

if !instance_exists(Cinematic) {
    scrDrawSpiral()

    var gen = string(scrAddZero(round((instance_number(Floor) / goal) * 100), 2)) + "%"

    draw_set_color(make_color_rgb(125, 131, 141))
    draw_set_halign(fa_center)
    draw_text_shadow(view_xview + view_width / 2, view_yview + view_height / 2 - 54, textgenerating + gen)
    draw_text_nt(view_xview + view_width / 2, view_yview + view_height / 2 + 24, "@s" + loc(string(tip)))
    draw_set_halign(fa_left)
    draw_set_color(c_white)

    scrDrawRoadmap(view_xview + view_width / 2, view_yview + view_height / 2, GameCont.waypoints)
}