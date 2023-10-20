save_set_value("other", "fullscreen", window_get_fullscreen())
save_set_value("data", "tot_time", tot_time)

KeyCont.players = array_length(struct_keys(playerinstances))

global.time = 0

if dont_save {
    dont_save = 0
    exit
}

scrSave()

if !instance_exists(CoopController) {
    global.inputDelay = 0
}