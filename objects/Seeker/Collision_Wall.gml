if !place_meeting(x, y, hitme) && speed > 0 {
    snd_play(sndBoltHitWall)

    speed = 0

    x = xprevious
    y = yprevious

    move_contact_solid(direction, 16)
    instance_create(x, y, Dust)
    alarm[0] = 30
    alarm[1] = 1
}