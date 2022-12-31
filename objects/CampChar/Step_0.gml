if race == 15 {
    sprite_index = sprMutant15Walk
    speed = 3

    image_xscale = sign(hspeed)
    if image_xscale == 0 {
        image_xscale = 1
    }

    instance_deactivate_object(id)
    var cmp = instance_nearest(x, y, CampChar)
    instance_activate_object(id)

    if cmp {
        if cmp.y > y {
            depth = cmp.depth + 1
        } else depth = cmp.depth - 1
    }
} else friction = 0.4