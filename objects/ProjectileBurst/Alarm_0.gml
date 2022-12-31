if !isset("time") time = 3
if !isset("ammo") ammo = 3

ammo -= 1
alarm[0] = time

if !isset("snd") snd = sndMachinegun
if !isset("spread") spread = 2
if !isset("spd") spd = 16
if !isset("creator") creator = Player
if !isset("team") team = -1
if !isset("proj") {
    proj = Bullet1 exit
}

if instance_exists(creator) {
    x = creator.x
    y = creator.y
    direction = creator.wepangle
    //FIRING
    snd_play(snd)
    with instance_create(x, y, proj) {
        creator = other.creator
        motion_add(creator.gunangle + random_range(-other.spread, other.spread), other.spd)
        image_angle = direction
        team = other.team
    }

    BackCont.viewx2 += lengthdir_x(6, point_direction(x, y, mouse_x, mouse_y) + 180) * UberCont.opt_shake
    BackCont.viewy2 += lengthdir_y(6, point_direction(x, y, mouse_x, mouse_y) + 180) * UberCont.opt_shake
    BackCont.shake += 3
    creator.wkick = 4
}


if ammo <= 0 instance_destroy()