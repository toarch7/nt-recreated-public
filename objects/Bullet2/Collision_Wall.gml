if speed > 6 snd_play_hit(sndShotgunHitWall, 0.2)

move_bounce_solid(0)

speed *= 0.8

if speed + wallbounce > 16 {
    speed = 16
} else speed += wallbounce

if speed > 16 speed = 16

if wallbounce > 0 {
    alarm[2] = 2
    bonus = 1
}
wallbounce *= 0.95
instance_create(x, y, Dust)