alarm[1] = 90
if instance_exists(Player) {
    if (main == 1) {
        if (drawspr == sprTechnoMancerAppear) {
            snd_play_hit_big(sndTechnomancerActivate, 0)
            drawspr = sprTechnoMancer
            alarm[4] = 9
            main = 0
        } else if (instance_nearest(Player.x, Player.y, TechnoMancer) == id) {
            revive = 0
            if instance_exists(Corpse) {
                dir = instance_nearest(x, y, Corpse)
                if (collision_line(x, y, dir.x, dir.y, Wall, 0, 0) < 0) revive = 1
            }
            if ((revive == 1) && (random(5) < 6)) {
                snd_play_hit_big(sndTechnomancerRevive, 0)
                alarm[5] = 70
                alarm[2] = 55
                drawspr = sprTechnoMancerFire1
                drawimg = 0
            } else if (instance_number(Turret) < (4 * GameCont.loops)) {
                alarm[5] = 52
                alarm[6] = 35
                snd_play_hit_big(sndTechnomancerSpawnTurret, 0)
                drawspr = sprTechnoMancerFire2
                drawimg = 0
            }
        } else {
            if (drawspr != sprTechnoMancerInactive) drawspr = sprTechnoMancerDisappear
            snd_play_hit_big(sndTechnomancerDisappear, 0)
            alarm[4] = 22
            main = 0
            drawimg = 0
        }
    }
}