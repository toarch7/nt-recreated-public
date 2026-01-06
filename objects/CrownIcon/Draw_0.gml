if lockstep_stop
	exit

if !isset("appeary") {
    appeary = num * 32
} else if appeary {
    appeary = lerp(appeary, 0, 0.8)

    if !appeary {
        appeary = 0
        snd_play_pitch(sndCrownAppear, 0.9 + random(0.1))
    }
}

draw_set_color(c_uidark)

var _tint = selected ? c_white : c_gray,
	_x = x, _y = y + appeary - sign(selected),
	txt2;

draw_sprite_ext(sprite_index, crown, _x, _y, 1, 1, 0, _tint, 1)
if (crown == crwn_haste) scrDrawClock(_x - 1, _y - 2, _tint)

draw_set_halign(fa_center)
draw_set_valign(fa_middle)

txt2 = "@w" + loc("Crowns", crown, "Name", scr_crown_get_name(crown)) + "#"
	 + "@s" + loc("Crowns", crown, "Text", scr_crown_get_text(crown)) + "@s"

if selected && !appeary {
    draw_text_nt(round(view_width / 2 + 1), round(view_height - 61 - selected), txt2)
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)

if selected && selected < 3 {
    selected++
}