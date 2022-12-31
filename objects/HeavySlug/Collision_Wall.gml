if (speed > 6) snd_play_hit(sndShotgunHitWall, 0.2)

move_bounce_solid(00)
if (wallbounce > 2) {
    bonus = 1
    alarm[2] = 2
}
speed *= 0.8
speed += wallbounce
wallbounce *= 0.95
instance_create(x, y, Dust)
if (speed > 16) speed = 16