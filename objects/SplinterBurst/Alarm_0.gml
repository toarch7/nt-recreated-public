ammo -= 1
alarm[0] = time
if instance_exists(creator) {
    x = creator.x
    y = creator.y
    snd_play_gun(sndSplinterGun, 0.1)
    repeat(2) {
        with(instance_create(x, y, Splinter)) {
            motion_add((other.creator.gunangle + ((random(32) - 16) * other.creator.accuracy)), (16 + random(8)))
            image_angle = direction
            team = other.team
        }
    }
    BackCont.viewx2 += (lengthdir_x(7, (creator.gunangle + 180)) * UberCont.opt_shake)
    BackCont.viewy2 += (lengthdir_y(7, (creator.gunangle + 180)) * UberCont.opt_shake)
    BackCont.shake += 3
    creator.wkick = 9
}
if (ammo == 0) instance_destroy()