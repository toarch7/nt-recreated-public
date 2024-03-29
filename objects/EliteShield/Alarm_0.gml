with creator {
    var len = random(180) + 120
    var dir = random_angle

    var iteration = 0
    var xx = x + lengthdir_x(len, dir)
    var yy = y + lengthdir_y(len, dir)

    while !place_meeting(xx, yy, Floor) {
        xx = x + lengthdir_x(len, dir)
        yy = y + lengthdir_y(len, dir)

        if iteration++ > 100 {
            break
        }
    }

    var flor = instance_nearest(xx, yy, Floor)
	
    if instance_exists(flor) {
		with flor {
			other.x = bbox_center_x
			other.y = bbox_center_y
		}
		
		xprevious = x
		yprevious = y
    }
	
    alarm[1] = 30
}

snd_play(sndEliteShielderTeleport)
sprite_index = sprEliteShielderShieldDisappear
image_index = 0
image_speed = 0.4
alarm[0] = -1