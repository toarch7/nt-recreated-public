instance_create(x, y, Nothing2Death)
with(MusCont)
alarm[1] = 1

with projectile {
    if team != 2 instance_destroy()
}

snd_play_hit_big(sndNothing2DeadStart, 0.2)

repeat 2
scrDrop(100, 0)

scrAchievement(34)