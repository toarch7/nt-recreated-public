drive = 0

if (freak == 1) instance_destroy()
else {
    snd_play_hit_big(sndVanOpen, 0.1)
    drawspr = sprVanDeactivate
    drawimg = 0
    alarm[2] = 15
    repeat(3 + GameCont.loops)
    instance_create((x - (55 * right)), ((y - random(10)) - 5), Grunt)
    dir = choose(1, 2)
    if (dir == 1) {
        spwn = choose(Inspector, Shielder)
        repeat(1 + GameCont.loops)
        instance_create((x - (50 * right)), ((y - random(10)) - 5), spwn)
    }
    if (dir == 2) {
        spwn = choose(EliteGrunt, EliteInspector, EliteShielder)
        repeat GameCont.loops
        instance_create((x - (50 * right)), ((y - random(10)) - 5), spwn)
    }
}