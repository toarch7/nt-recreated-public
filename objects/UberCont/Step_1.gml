if want_pause && instance_exists(Player) && !instance_exists(GenCont) {
    want_pause = 0

    if !bossintro {
        scrMakePauseButtons()
    }

    with MobileUI
    index = -1

    instance_deactivate_all(1)
    instance_activate_object(BackCont)
    instance_activate_object(GameCont)
    instance_activate_object(TopCont)
    instance_activate_object(PauseButton)
    instance_activate_object(CoopController)
    instance_activate_object(MusCont)
    instance_activate_object(Console)

    with PauseButton {
        hover = 5
        visible = 1
        depth--
    }
}

