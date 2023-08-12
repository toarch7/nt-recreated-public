var numfloors = 0
var d = safedir

if safespawn {
    if !instance_exists(FloorMaker) {
        with Floor {
            if distance_to_point(10016, 10016) <= 96
                numfloors ++
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

            with hitme {
				if object_index != Player {
					
	                x += lengthdir_x(32, d)
	                y += lengthdir_y(32, d)
					
					xstart = x
					ystart = y
					
					xprevious = x
					yprevious = y
	            }
			}

            instance_create(10000, 10000, Floor)
        }
    }
}
