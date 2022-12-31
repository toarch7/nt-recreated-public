ammo -= 1

alarm[0] = time

if instance_exists(creator) {
    x = creator.x
    y = creator.y
    gunangle = creator.gunangle
    snd_play(sndJackHammer)
    //FIRING
    with instance_create(x + lengthdir_x(skill_get(13) * 12, gunangle), y + lengthdir_y(skill_get(13) * 12, gunangle), Shank) {
        longarms = 0
        creator = other.creator
        if instance_exists(Player) longarms = skill_get(13) * 2
        motion_add(creator.gunangle + (random(30) - 15 * Player.accuracy), 4 + longarms)
        image_angle = direction
        team = other.team
    }

    BackCont.viewx2 += lengthdir_x(6, point_direction(x, y, mouse_x, mouse_y)) * UberCont.opt_shake
    BackCont.viewy2 += lengthdir_y(6, point_direction(x, y, mouse_x, mouse_y)) * UberCont.opt_shake
    if BackCont.shake < 1 BackCont.shake = 1 creator.wkick = -8
}


if ammo = 0 instance_destroy()