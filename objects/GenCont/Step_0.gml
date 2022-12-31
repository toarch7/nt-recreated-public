var numfloors = 0
var d = safedir

if safespawn {
    if !instance_exists(FloorMaker) {
        with Floor {
            if distance_to_point(10016, 10016) <= 96 {
                numfloors++
            }
        }

        if numfloors > 4 {
            alarm[0] = 3
            alarm[2] = 2

            with Floor {
                x += lengthdir_x(32, d)
                y += lengthdir_y(32, d)
            }

            with chestprop {
                x += lengthdir_x(32, d)
                y += lengthdir_y(32, d)
            }

            with hitme
            if object_index != Player {
                x += lengthdir_x(32, d)
                y += lengthdir_y(32, d)
            }

            instance_create(10000, 10000, Floor)
        }
    }
}

/*with BecomeScrapBoss {
	var dir = instance_furthest(10016, 10016, Floor)
	
	if dir {
		var dis = point_distance(10016, 10016, dir.x, dir.y)
		var dirct = point_direction(10016, 10016, dir.x, dir.y)
		
		var dar = instance_nearest(10016 + lengthdir_x(dis * 0.75, dirct), 10016 + lengthdir_y(dis * 0.75, dirct), Floor)
		
		with dir image_blend = c_blue
		with dar image_blend = c_red
		
		if dar {
			x = dar.x
			y = dar.y
			xprevious = x
			yprevious = y
		}
	}
}*/