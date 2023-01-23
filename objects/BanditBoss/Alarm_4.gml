if charge = 0 {
    charge = 1
    meleedamage = 10
    alarm[4] = 20
    if intro = 0 alarm[4] = 5

    snd_play(sndBigBanditMelee)
    scrTarget()

    if instance_exists(target) {
        gunangle = target_direction
        motion_add(gunangle, 10)
    }
} else {
    meleedamage = 0
    charge = -1
    alarm[5] = 10
}