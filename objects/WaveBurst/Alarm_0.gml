ammo -= 1

alarm[0] = time


if instance_exists(creator) {
    x = creator.x
    y = creator.y
    //FIRING
    snd_play(sndShotgun)

    with instance_create(x, y, Bullet2) {
        motion_add(other.creator.gunangle + random(4) - 2 + sin(other.ammo / 2) * 16, 16)
        image_angle = direction
        team = other.team
    }
    with instance_create(x, y, Bullet2) {
        creator = other.creator
        motion_add(other.creator.gunangle + random(4) - 2 - sin(other.ammo / 2) * 16, 16)
        image_angle = direction
        team = other.team
    }

    BackCont.viewx2 += lengthdir_x(2, point_direction(x, y, mouse_x, mouse_y) + 180) * UberCont.opt_shake
    BackCont.viewy2 += lengthdir_y(2, point_direction(x, y, mouse_x, mouse_y) + 180) * UberCont.opt_shake
    BackCont.shake += 2
    creator.wkick = 7
}


if ammo = 0 instance_destroy()