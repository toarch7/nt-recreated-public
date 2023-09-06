if lockstep_stop
	exit

if !isset("appeary") {
    appeary = num * 32
}
else if appeary {
    appeary = lerp(appeary, 0, .7)

    if !appeary {
        appeary = 0
        snd_play_pitch(sndMutAppear, random(0.1) + 0.9)
    }
}

draw_sprite_ext(sprite_index, skill, x, y + appeary - sign(selected), 1, 1, 0, qm(selected, c_white, c_gray), 1)

txt2 = "@w" + loc(string(skill_name[skill])) + "#" + "@s" + loc(string(skill_text[skill])) + "@s"
if selected && !appeary {
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    draw_text_nt(view_width / 2, view_height - 61 - selected, txt2)
    draw_set_valign(fa_top)
    draw_set_halign(fa_left)
}

if selected && selected < 3 {
    selected++
}