if !speed {
    target = noone

    if distance_to_object(ProtoStatue) < 170 && !collision_line(x, y, ProtoStatue.x, ProtoStatue.y, Wall, 0, 0) && ProtoStatue.hp < ProtoStatue.max_hp * 0.7 {
        target = instance_nearest(x, y, ProtoStatue)
    }
	else if distance_to_object(HostileHorror) < 170 && HostileHorror.charge <= 0 && !collision_line(x, y, HostileHorror.x, HostileHorror.y, Wall, 0, 0) {
        target = instance_nearest(x, y, HostileHorror)
    }
	else if instance_exists(Player) {
		var p = instance_nearest(x, y, Player)
		
        if (distance_to_object(p) < 80 + (skill_get(3) * 60) && !p.horrornorad) || instance_exists(Portal) {
            target = instance_nearest(x, y, Player)
        }
    }

    if target {
        direction = target_direction
        mp_potential_step(target.x, target.y, 12, 0)
    }

    if place_meeting(x, y, Player) or place_meeting(x, y, Portal) {
        if object_index == BigRad {
            GameCont.rad += 10
        } else GameCont.rad += 1

        snd_play(sndRadPickup)
        with instance_create(x + random_spread(3), y + random_spread(3), RadEat) {
            sprite_index = other.object_index == BigRad ? sprEatBigRad : sprEatRad

            if skill_get(3) {
                sprite_index = other.object_index == BigRad ? sprEatBigRadPlut : sprEatRadPlut
            }
        }
        instance_destroy()
    }
}

if image_index < 1 {
    image_index += random(0.04)
} else image_index += 0.4

if (!speed && place_meeting(x, y, Player)) or place_meeting(x, y, Portal) {
    if object_index == BigRad {
        GameCont.rad += 10
    } else GameCont.rad++

    with instance_create(x + random_spread(3), y + random_spread(3), RadEat) {
        sprite_index = other.object_index == BigRad ? sprEatBigRad : sprEatRad

        if skill_get(3) {
            sprite_index = other.object_index == BigRad ? sprEatBigRadPlut : sprEatRadPlut
        }
    }

    snd_play(sndRadPickup)
    instance_destroy()
}