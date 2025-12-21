if lockstep_stop
	exit

if isset("appeary") {
    if appeary > 0 {
	    appeary = lerp(appeary, -1, 0.8)
		
	    if appeary <= 0 {
	        snd_play_pitch(sndMutAppear, random(0.9) + 0.1)
	        appeary = 0
	    }
	}
}
else {
	appeary = num * 32
}

var _x = x, _y = y + appeary - sign(selected),
	_blend = (selected ? c_white : c_gray)

if (race != Race.CoopUltra) {
	var _index = (race - 1) * 3 + num - 1
	draw_sprite_ext(sprite_index, _index, _x, _y, 1, 1, 0, _blend, 1)
}
else {
	draw_sprite_ext(sprCoopSkillIcon, num - 1, _x, _y, 1, 1, 0, _blend, 1)
}

draw_align(fa_center, fa_middle)

var txt2 = string("@w" + loc(ultr_name[race, num])) + "#@s" + string(loc(ultr_text[race, num]))

if selected {
    draw_text_nt(view_width / 2, view_height - 61 - selected, txt2)
	if (selected < 3) selected ++
}

draw_align()
