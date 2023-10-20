spr_idle = sprScrapBossIdle

if random(3) < 1 {
    //SPIN ATTACK
    alarm[1] = 15
    snd_play(sndBigDogSpin)
    ammo = 10 + 10 * (1 - (hp / max_hp))
    turn = choose(1, - 1)
    walk = 0
    image_index = 0
    spr_idle = sprScrapBossCharge
    sprite_index = spr_idle
    speed = 0
} else {
    ammo = 0
    if random(3 + instance_number(ScrapBossMissile) / 2) < 1 and instance_exists(Player) {
        snd_play(sndBigDogMissile)
        repeat(3) {
            with instance_create(x, y, ScrapBossMissile)
            motion_add(random_angle, 2)
        }
        alarm[0] = 10
    } else {
        ammo = 0
        walk = 20 + random(10)
        motion_add(random_angle, 1)
        alarm[0] = walk + 10
    }
}