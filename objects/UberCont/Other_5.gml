save_set_val("other", "fullscreen", window_get_fullscreen())
save_set_val("data", "tot_time", tot_time)

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