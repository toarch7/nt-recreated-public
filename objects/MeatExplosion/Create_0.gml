event_inherited()

image_speed = 0.4
damage = 4

var _dir = random_angle

repeat (6) {
    with (instance_create(x, y, Smoke)) {
		motion_add(_dir, 4 + random(1))
		if (!place_meeting(x + hspeed, y + vspeed, Floor)) {
			instance_destroy()
		}
	}
	
    _dir += 360 / 6
}

snd_play(sndMeatExplo)
scr_screenshake(6)

team = team_player
