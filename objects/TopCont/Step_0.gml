if !instance_exists(Player) or(instance_exists(Credits) && !Credits.visible) or(instance_exists(Cinematic) && Cinematic.done) {
    if !UberCont.paused && !instance_exists(GameOver) {
        if instance_number(UnlockScreen) <= 0 && instance_exists(GameCont) && !instance_exists(GenCont) && !instance_exists(Menu) && !instance_exists(MenuGen) {
            instance_create(view_xview, view_yview, GameOver)

            with MusCont {
                audio_stop_sound(song)
            }
        }
    }

    if instance_exists(UnlockScreen) {
        var unlockscreen = instance_find(UnlockScreen, 0)

        if unlockscreen {
            with unlockscreen {
                if alarm[0] == -1 && !visible {
                    event_perform(ev_alarm, 0)
                }
            }
        }
    }
}