/// @description Perform landing

repeat (6) {
    with (instance_create(x + random(16) - 8, y + random(16), Dust)) {
		motion_add(random_angle, 3 + random(1))
	}
}

scrTarget()

if (instance_exists(target)) {
	var _x = x,
		_y = y,
		_tx = target.x,
		_ty = target.y
		
    with (Raven) {
        if (id != other.id && point_distance(x, y, _x, _y) < 120 && point_distance(x, y, _x, _y) > 32) {
            if (!collision_line(_tx, _ty, x, y, Wall, 1, 1) && random(3) < 2) {
				scrRavenLift()
			}
		}
    }
}

z = 0
alarm[1] = 20 + random(10)
alarm[2] = -1

if (x > view_xview
	&& y > view_yview
	&& x < view_xview + view_width
	&& y < view_yview + view_height
) {
	snd_play(sndRavenLand)
}

instance_change(Raven, false)

emergencylanding = 0