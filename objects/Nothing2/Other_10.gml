event_inherited()
if (walk > 0) {
    speed = 1.5
    walk -= 1
    motion_add(walkdir, 4)
} else speed = 0.5
with(Wall) {
    instance_create(x, y, InvisiWall)
    instance_destroy()
}
with(Top)
instance_destroy()
with(TopSmall)
instance_destroy()
if ((hp < (max_hp / 2)) && (sndhalfhp == 0)) {
    snd_play(sndNothing2HalfHP)
    sndhalfhp = 1
}
if ((!instance_exists(Player)) && (sndtaunt == 0)) {
    tauntdelay += 1
    if (tauntdelay > 50) {
        snd_play(sndNothing2Taunt)
        sndtaunt = 1
    }
}
if instance_exists(BackCont) {
    if (BackCont.shake < 2) BackCont.shake = 2
}