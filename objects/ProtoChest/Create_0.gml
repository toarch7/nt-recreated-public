event_inherited()

wep = UberCont.protowep

if UberCont.daily_run {
    wep = 56
}

if instance_exists(CoopController) {
    wep = CoopController.protowep
}