if speed > 6 snd_play_hit(sndShotgunHitWall, 0.2)

if wallbounce {
    bonus = 1
    alarm[2] = 2
    move_bounce_solid(true)
    speed *= 0.8
    wallbounce = 0
} else {
    with instance_create(x, y, BulletHit)
    sprite_index = sprBullet2Disappear
    instance_destroy()
}