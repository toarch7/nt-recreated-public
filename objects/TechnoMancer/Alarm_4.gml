drawspr = sprTechnoMancerInactive
drawimg = 0

if instance_exists(Player) {
    with(instance_nearest(Player.x, Player.y, TechnoMancer)) {
        main = 1
        drawspr = sprTechnoMancerAppear
        drawimg = 0
        alarm[5] = 17
        snd_play_hit_big(sndTechnomancerAppear, 0)
    }
}