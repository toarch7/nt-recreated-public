function scrBossIntro(argument0) {
    with UberCont {
        if instance_exists(CoopController) exit

        if opt_bossintro && instance_exists(Player) {
			scrGetPauseImage()
			
            want_pause = 1
			paused = 1
			
            bossintro = 1
            boss = argument0
            splat_index = 0
            bossnamex = 0
            insound = 0
            outsound = 0
            bossx = 320
            alarm[2] = 40
        }
    }
}