ammo -= 1

alarm[0] = time

if instance_exists(creator) {
    x = creator.x
    y = creator.y
    //FIRING
    snd_play(sndSlugger)
    with instance_create(x, y, Shell)
    motion_add(other.creator.gunangle + 180 + random(50) - 25, 2 + random(2))

    with instance_create(x, y, Slug) {
        creator = other.creator
        motion_add(creator.gunangle + random(8) - 4, 18)
        image_angle = direction
        team = other.team
    }

    BackCont.viewx2 += lengthdir_x(8, point_direction(x, y, mouse_x, mouse_y) + 180) * UberCont.opt_shake
    BackCont.viewy2 += lengthdir_y(8, point_direction(x, y, mouse_x, mouse_y) + 180) * UberCont.opt_shake
    BackCont.shake += 6
    creator.wkick = 8
}


if ammo = 0 instance_destroy()