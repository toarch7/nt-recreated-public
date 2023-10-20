if lockstep_stop
	exit

if !isset("appeary") {
    appeary = num * 32
} else if appeary {
    appeary = max(0, appeary - 32)

    if !appeary {
        appeary = 0
        snd_play_pitch(sndMutAppear, random(.1) + .9)
    }
}

draw_sprite_ext(sprite_index, ultr_indx[race, num], x, y + appeary - sign(selected), 1, 1, 0, qm(selected, c_white, c_gray), 1)

draw_set_valign(fa_center)
draw_set_halign(fa_center)

txt2 = string("@w" + loc(ultr_name[race, num])) + "#@s" + string(loc(ultr_text[race, num]))
if selected {
    draw_text_nt(view_width / 2, view_height - 61 - selected, txt2)
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)

if selected && selected < 3 {
    selected++
}