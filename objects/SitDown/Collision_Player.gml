with (other) {
	can_die = false
    bcan_shoot = false
    can_shoot = false
    
	x = other.x
    y = other.y
	
	visible = false
    roll = false
	angle = 0
	
	if (scr_player_is_local(index)) {
		other.spr_gosit = spr_gosit
		other.spr_sit = spr_sit
		other.player = id
	}
}

if (sit) exit

GameCont.win = true

if (scrGameIsEventRun()) scrSendDailyData()

sprite_index = spr_gosit
image_speed = 0.4

alarm[0] = 345
alarm[1] = 120
alarm[2] = 10

if debug {
    alarm[0] = 2
    alarm[1] = 1
    alarm[2] = 1
}

with (TopCont) drawcontrols = false

sit = true