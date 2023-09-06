if lockstep_stop
	exit

if instance_exists(Player) {
    var p = instance_nearest(x, y, Player)
	
	if p.x < x {
		image_xscale = -1
	}
	else image_xscale = 1

    if sprite_index == sprBigPortal {
        with WepPickup {
            if collision_line(x, y, other.x, other.y, Wall, 0, 0) < 0 {
                if place_free(x + lengthdir_x(6, point_direction(x, y, other.x, other.y)), y) x += lengthdir_x(6, point_direction(x, y, other.x, other.y))
                if place_free(x, y + lengthdir_y(6, point_direction(x, y, other.x, other.y))) y += lengthdir_y(6, point_direction(x, y, other.x, other.y))
                image_angle -= 15 * rotspeed
            }
        }

        with Player {
            if collision_line(x, y, other.x, other.y, Wall, 0, 0) < 0 {
                dis = 5
                sprite_index = spr_hurt
                image_index = 1
                inframes = 10
                depth = -9
                if place_free(x + lengthdir_x(dis, point_direction(x, y, other.x, other.y)), y) x += lengthdir_x(dis, point_direction(x, y, other.x, other.y))
                if place_free(x, y + lengthdir_y(dis, point_direction(x, y, other.x, other.y))) y += lengthdir_y(dis, point_direction(x, y, other.x, other.y))
                if dis >= maxspeed {
                    angle -= 30 * right
                    sprite_index = spr_hurt
                    depth = -9
                    image_index = 1
                }
            } else if roll <= 0 {
                angle = 0
            }
        }
    }
}

if endgame < 100 {
    endgame -= 1
    if endgame < 0 and sprite_index == sprBigPortal {
        image_index = 0
        sprite_index = sprBigPortalDisappear

        with Player {
            visible = 0
            roll = 0
            angle = 0
        }
    }
}

if !instance_exists(Player) {
    endgame = -1
    if endgame < 0 and sprite_index = sprBigPortal {
        image_index = 0
        sprite_index = sprBigPortalDisappear
    }
}