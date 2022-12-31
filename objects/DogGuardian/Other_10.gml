event_inherited()

if !leap {
    z = 0
    zspeed = 0

    if sprite_index != spr_hurt && spr_idle == sprDogGuardianWalk motion_add(direction, 0.4)

    if hspeed > 0 {
        right = 1
    } else if hspeed < 0 {
        right = -1
    }

    if speed > 2 {
        speed = 2
    }
} else {
    if !bounced {
        direction = jumpdir
    }

    speed = 8
    leap--z += zspeed

    zspeed -= 0.5

    inframes = 0

    if zspeed < 0 {
        sprite_index = sprDogGuardianJumpUp
        image_index = 0
    } else {
        sprite_index = sprDogGuardianLand
        image_index = 0
    }
}