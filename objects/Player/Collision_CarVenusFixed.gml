if lockstep_stop
	exit

if KeyCont.press_pick[p] = 1 && is_me {
    with other
    instance_change(Wind, false)

    with enemy
    hp = 0

    with instance_create(x, y, Portal) type = 1

    if GameCont.area == 107 or instance_exists(YungCuz) {
        GameCont.area = GameCont.lastarea
        GameCont.subarea = GameCont.lastsubarea - 1
    } else {
        GameCont.area = 103
        GameCont.subarea = 0
    }

    snd_stop(sndCarLoop)
}