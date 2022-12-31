if speed > 0 {
    snd_play(sndBoltHitWall)
    speed = 0
    move_contact_solid(direction, 16)
    instance_create(x, y, Dust)
    alarm[0] = 30
}