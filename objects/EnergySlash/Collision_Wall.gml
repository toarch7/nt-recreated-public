x -= hspeed
y -= vspeed

if walled = 0 {
    walled = 1
    snd_play(sndMeleeWall)
}