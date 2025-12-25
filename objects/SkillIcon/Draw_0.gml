if lockstep_stop
	exit

var txt2;

if appeary {
    appeary = lerp(appeary, 0, 0.8)

    if !appeary {
        appeary = 0
        snd_play(sndMutAppear, random(0.67) + 0.5)
    }
}
else if appeary == -1 {
    appeary = num * 32
}

draw_sprite_ext(sprite_index, skill, x, y + appeary - sign(selected), 1, 1, 0, selected ? c_white : c_gray, 1)

txt2 = "@w" + loc("Skills", skill, "Name", scr_skill_get_name(skill)) + "#"
	 + "@s" + loc("Skills", skill, "Text", scr_skill_get_text(skill)) + "@s"

if selected && !appeary {
	depth = object_get_depth(object_index) - 1
	
    draw_set_halign(fa_center)
    draw_set_valign(fa_middle)
    draw_text_nt(view_width / 2, view_height - 61 - selected, txt2)
    draw_set_valign(fa_top)
    draw_set_halign(fa_left)
}
else depth = object_get_depth(object_index)

if selected && selected < 3 {
    selected++
}