if lockstep_stop
	exit

//THIS IS VERY WORK IN PROGRESS, GOTTA ALL HAPPEN WHILE PAUSED, INCLUDING CAMERA PAN

if x > view_xview + view_width * 0.4 and x < view_xview + view_width * 0.6 and y > view_yview + view_height * 0.4 and y < view_yview + view_height * 0.6 {
    if instance_exists(Player) {
        if GameCont.area = 1 {
            with instance_create(x, y, Drama)
            name = "BIG BANDIT"
        }
        if GameCont.area = 3 {
            with instance_create(x, y, Drama)
            name = "BIG DOG"
        }
        if GameCont.area = 5 {
            with instance_create(x, y, Drama)
            name = "LIL HUNTER"
        }
        with MusCont {
            snd_stop_all()
            if GameCont.area = 1 song = musBoss1
            if GameCont.area = 3 song = musBoss2
            if GameCont.area = 5 song = musBoss3 sound_loop(song)
            //sound_loop(amb)
            sound_global_volume(max(0, sqrt(UberCont.opt_volume)))
            sound_volume(song, sqrt(UberCont.opt_musvol))
            sound_volume(amb, sqrt(UberCont.opt_ambvol))
        }
    }
    with BanditBoss {
        snd_play(sndBigBanditIntro)
        depth = -99
    }
    with LilHunter {
        snd_play(sndLilHunterAppear)
        depth = -99
    }
    with ScrapBoss {
        snd_play(sndBigDogIntro)
        depth = -99
    }
    sleep(100)
    repeat(21) {
        visible = 0
        with BackCont {
            screen_begin()
            surface_set_target(screen)
            surface_reset_target()
        }
        with BackCont
        screen_end()
        visible = 1
        sleep(1000 / 30)
    }
    instance_destroy()
    with Drama
    instance_destroy()
    with BanditBoss
    depth = -2
    with ScrapBoss
    depth = -2
    with LilHunter
    depth = -2
}
urgent += 1