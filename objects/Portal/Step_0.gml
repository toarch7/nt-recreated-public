if instance_exists(NothingInactive) or instance_exists(BecomeNothing) or instance_exists(NothingDeath) {
    instance_destroy(id, 0)
    exit
}

if instance_exists(Player) {
	var p = instance_nearest(x, y, Player)
	
    if p.x < x {
        image_xscale = -1
    }
	else image_xscale = 1

    if sprite_index = sprPortal or sprite_index = sprProtoPortal or sprite_index = sprPopoPortal {
        with WepPickup {
            if point_distance(x, y, other.x, other.y) < 64 and collision_line(x, y, other.x, other.y, Wall, 0, 0) < 0 {
                if place_free(x + lengthdir_x(5, point_direction(x, y, other.x, other.y)), y) x += lengthdir_x(5, point_direction(x, y, other.x, other.y))
                if place_free(x, y + lengthdir_y(5, point_direction(x, y, other.x, other.y))) y += lengthdir_y(5, point_direction(x, y, other.x, other.y))

                mp_potential_step_object(x, y, 1, Wall)

                image_angle -= 15 * rotspeed
            }
        }

        with Player {
            if distance_to_object(other) < 24 && !collision_line(x, y, other.x, other.y, Wall, 0, 0) {
                if place_free(x + lengthdir_x(5, point_direction(x, y, other.x, other.y)), y) x += lengthdir_x(5, point_direction(x, y, other.x, other.y))

                if place_free(x, y + lengthdir_y(5, point_direction(x, y, other.x, other.y))) y += lengthdir_y(5, point_direction(x, y, other.x, other.y))

                angle -= 30 * right
                sprite_index = spr_hurt
                image_index = 1
            } else if distance_to_object(other) < 48 && !collision_line(x, y, other.x, other.y, Wall, 0, 0) {
                if place_free(x + lengthdir_x(2, point_direction(x, y, other.x, other.y)), y) x += lengthdir_x(2, point_direction(x, y, other.x, other.y))

                if place_free(x, y + lengthdir_y(2, point_direction(x, y, other.x, other.y))) y += lengthdir_y(2, point_direction(x, y, other.x, other.y))
            } else if !roll angle = 0
        }
    }
}

if endgame < 100 {
    endgame -= 1
    if endgame < 0 and(sprite_index = sprPortal or sprite_index = sprProtoPortal or sprite_index = sprPopoPortal) {
        image_index = 0
        if type = 1 sprite_index = sprPortalDisappear
        if type = 2 sprite_index = sprPopoPortalDisappear
        if type = 3 sprite_index = sprProtoPortalDisappear with Player {
            visible = 0
            roll = 0
            angle = 0
        }
    }
}
if !instance_exists(Player) {
    endgame = -1
    if endgame < 0 and(sprite_index = sprPortal or sprite_index = sprProtoPortal or sprite_index = sprPopoPortal) {
        image_index = 0
        if type = 1 sprite_index = sprPortalDisappear
        if type = 2 sprite_index = sprPopoPortalDisappear
        if type = 3 sprite_index = sprProtoPortalDisappear
    }
}