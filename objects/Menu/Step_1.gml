var inst = playerinstance,
	yoff = dailylistfavor

race = inst.race

var _char = char[0]

if array_length(char) > race
    _char = char[race]

if instance_exists(_char) {
	with _char {
	    view_xview = (lerp(view_xview, x - view_width / 2, 0.1))
	    view_yview = (lerp(view_yview, y - view_height / 2, 0.1))
	}
}

camera_set_pos(view_xview, view_yview)

if instance_exists(DailyList) {
    if dailylistfavor < 48 {
        dailylistfavor += 16
    }
}
else if dailylistfavor {
    dailylistfavor -= 24

    if dailylistfavor < 0 {
        dailylistfavor = 0
    }
}
