ammo -= 1

alarm[0] = time


if instance_exists(creator) {
    x = creator.x
    y = creator.y
    direction = creator.wepangle
    //FIRING
    snd_play(sndRogueRifle)
    with instance_create(x, y, Shell)
    motion_add(other.direction + 180 + random(50) - 25, 2 + random(2))

    with instance_create(x, y, Bullet1) {
        creator = other.creator
        sprite_index = sprIDPDBullet
        motion_add(creator.gunangle + random(4) - 2, 16)
        image_angle = direction
        team = other.team
    }

    BackCont.viewx2 += lengthdir_x(6, point_direction(x, y, mouse_x, mouse_y) + 180) * UberCont.opt_shake
    BackCont.viewy2 += lengthdir_y(6, point_direction(x, y, mouse_x, mouse_y) + 180) * UberCont.opt_shake
    BackCont.shake += 3
    creator.wkick = 4
}


if ammo = 0 instance_destroy()