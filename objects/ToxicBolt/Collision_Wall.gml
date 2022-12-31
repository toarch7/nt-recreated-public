if speed > 0 {
    snd_play_hit_big(sndBoltHitWall, .2)
    speed = 0
    alarm[1] = 1
    move_contact_solid(direction, 16)
    instance_create(x, y, Dust)
    alarm[0] = 30
}