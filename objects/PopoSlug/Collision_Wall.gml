if speed > 6 and !snd_is_playing(sndShotgunHitWall) snd_play(sndShotgunHitWall)
sleep(1)
move_bounce_solid(00)
speed *= 0.8
speed += wallbounce
wallbounce *= 0.9
instance_create(x, y, Dust)

if speed > 18 speed = 18