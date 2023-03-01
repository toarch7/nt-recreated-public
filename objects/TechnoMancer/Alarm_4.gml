drawspr = sprTechnoMancerInactive
drawimg = 0

if instance_exists(target) {
    with instance_nearest(target.x, target.y, TechnoMancer) {
        main = 1
        
		drawspr = sprTechnoMancerAppear
        drawimg = 0
        
		alarm[5] = 17
		
        snd_play_hit_big(sndTechnomancerAppear, 0)
    }
}