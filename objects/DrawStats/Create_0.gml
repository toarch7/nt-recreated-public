
scrInit() // this is not right but not as bad how it was

var secretchars = (UberCont.cgot[13] > 0) + (UberCont.cgot[14] > 0) + (UberCont.cgot[15] > 0),
	_x = secretchars < 3 ? 16 : 10

crowngot = UberCont.crowngot
select = 0

var _slot_index = 0

for(var _race_id = Race.Fish; _race_id < Race.NUM_ALL_RACE_TYPES; ++_race_id) {
	if scrRaceIsHidden(_race_id) && !UberCont.ctot_runs[_race_id] {
		continue
	}
	
    with instance_create(_x, view_height - 32, StatChar) {
        num = _race_id
		image_index = _race_id
        pos = _slot_index++
    }
	
    _x += 20
}

scr_camera_set_position(0, 0)
