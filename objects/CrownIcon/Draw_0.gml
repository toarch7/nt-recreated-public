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
	_x = x, _y = y + appeary - sign(selected)

draw_sprite_ext(sprite_index, crown, _x, _y, 1, 1, 0, _tint, 1)
if (crown == crwn_haste) scrDrawClock(x - 1, y - 2, _tint)

draw_set_halign(fa_center)
draw_set_valign(fa_middle)

var txt2 = string("@w" + string(loc(crown_name[crown]))) + "#@s" + string(loc(crown_text[crown]))

if selected && !appeary {
    draw_text_nt(view_width / 2 + 1, view_height - 61 - selected, txt2)
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)

if selected && selected < 3 {
    selected++
}