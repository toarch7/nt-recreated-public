sit = 0
spr_sit = sprMutant1Sit
spr_gosit = sprMutant1GoSit

player = noone

with (Player) {
	if (scr_player_is_local(index)) {
	    other.spr_sit = spr_sit
	    other.spr_gosit = spr_gosit
		other.player = id
	}
}

// why is this here? I can't remember..
volume_control_command = 0

debug = false
do_thing = false
force_sit = false

alarm[3] = ((GameCont.area == area_hq) ? 300 : 900)