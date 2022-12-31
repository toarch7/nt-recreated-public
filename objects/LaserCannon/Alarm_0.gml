ammo -= 1

alarm[0] = time
image_xscale /= 2
image_yscale /= 2


if instance_exists(creator) {
    x = creator.x + lengthdir_x(16, creator.gunangle)
    y = creator.y + lengthdir_y(16, creator.gunangle)
    //FIRING
    if skill_get(17) snd_play(sndLaserCannonUpg)
    else snd_play(sndLaserCannon)


    with instance_create(x, y, Laser) {
        image_angle = other.creator.gunangle
        team = other.team
        event_perform(ev_alarm, 0)
    }

    BackCont.viewx2 += lengthdir_x(3, creator.gunangle + 180) * UberCont.opt_shake
    BackCont.viewy2 += lengthdir_y(3, creator.gunangle + 180) * UberCont.opt_shake
    BackCont.shake += 2
    creator.wkick = 5
}


if ammo = 0 instance_destroy()