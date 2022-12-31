snd_stop(snd)

snd_play_hit_big(sndExplosionXL, 0.2)

ang = random(360)
repeat(8) {
    instance_create(x + lengthdir_x(12, ang), y + lengthdir_y(12, ang), Explosion)
    ang += 360 / 8
}