if (speed > 6) snd_play_hit(sndShotgunHitWall, 0.2)

sleep(1)
move_bounce_solid(true)
speed *= 0.8

if (wallbounce > 0) {
    bonus = true
    alarm[2] = 2
}

speed += wallbounce
instance_create(x, y, Dust)
wallbounce *= 0.95

if (speed > 16) speed = 16