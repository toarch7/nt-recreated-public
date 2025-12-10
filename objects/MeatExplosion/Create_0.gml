event_inherited()

image_speed = 0.4

var _dir = random_angle

repeat (6) {
    with (instance_create(x, y, Smoke)) {
		motion_add(_dir, 4 + random(1))
	}
	
    _dir += 360 / 6
}

snd_play(sndMeatExplo)
scr_screenshake(6)

team = team_player
