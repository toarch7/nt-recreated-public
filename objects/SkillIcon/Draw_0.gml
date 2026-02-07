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

draw_sprite_ext(sprite_index, skill, x, y + appeary - sign(selected), image_xscale, image_yscale, 0, selected ? c_white : c_gray, 1)

var _description = loc("Skills", skill, "Text", scr_skill_get_text(skill))

if (skill == mut_throne_butt && instance_exists(Player)) {
    var _thronebutt_text = "", _multirace = false, _race_current = -1;
	
	with (Player) {
		if (_race_current == -1) {
			_race_current = race
		}
		else if (race != _race_current) {
			_multirace = true
			break
		}
	}
	
    if _multirace {
		with (Player) {
			var _race_name = loc("Races", race, "Name", scrRaceGetName(race)),
				_butt_text = loc("Races", race, "TB", scrRaceGetThroneButtDescription(race))
			
			_thronebutt_text = _race_name + " - " + _butt_text + "\n"
		}
		_thronebutt_text = string_trim_end(_thronebutt_text)
    }
	else {
		_thronebutt_text = loc("Races", _race_current, "TB", scrRaceGetThroneButtDescription(_race_current))
	}
	
	_description = _thronebutt_text
}

txt2 = "@w" + loc("Skills", skill, "Name", scr_skill_get_name(skill)) + "#@s" + _description + "@s"

if selected && !appeary {
	depth = object_get_depth(object_index) - 1
	
    draw_align(fa_center, fa_middle)
    draw_text_nt(round(view_width / 2), round(view_height - 61 - selected), txt2)
	draw_align()
}
else depth = object_get_depth(object_index)

if selected && selected < 3 {
    selected++
}