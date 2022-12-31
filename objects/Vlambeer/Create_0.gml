scrSetViewSize(0)

if !instance_exists(GameCont) && file_exists("gamestate.dat") {
    instance_create(0, 0, GameCont)
    instance_create(0, 0, Player)

    instance_create(0, 0, MusCont)

    UberCont.continued_run = 1

    if !scrGameLoad() {
        file_delete("gamestate.dat")
        game_restart()

        exit
    }

    random_set_seed(global.seed)

    scrVolume()
}

if UberCont.want_menu {
    if !UberCont.show_results {
        with instance_create(x, y, Logo) {
            event_perform(ev_alarm, 1)
        }
    } else {
        instance_create(x, y, DailyList)
        instance_create(x, y, BackButton)
        UberCont.show_results = 0
    }

    UberCont.want_menu = 0

    if instance_exists(MusCont) {
        with MusCont
        instance_destroy()
    }

    if !instance_exists(Cinematic) instance_create(x, y, SpiralCont)

    instance_create(x, y, MusCont)

    instance_destroy()

    exit
} else if instance_exists(GameCont) {
    if !instance_exists(Cinematic) instance_create(x, y, SpiralCont)

    if !instance_exists(Cinematic) && (GameCont.skillpoints > 0 or GameCont.crownpoints > 0 or GameCont.ultrapoints > 0) {
        instance_create(0, 0, BackCont)
        instance_create(x, y, LevCont)
    } else {
        instance_create(0, 0, BackCont)
        instance_create(x, y, GenCont)
    }

    instance_destroy()
} else {
    if instance_exists(MusCont) {
        with MusCont
        instance_destroy()
    }

    instance_create(x, y, MusCont)

    alarm[0] = 120
    mode = 0

    snd_play(sndVlambeer)
}

da = 0

x = view_width / 2
y = view_height / 2

view_xview = 0
view_yview = 0