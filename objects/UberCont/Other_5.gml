save_set_value("other", "fullscreen", window_get_fullscreen())
save_set_value("data", "tot_time", tot_time)

if dont_save {
    dont_save = 0
    exit
}

scrSave()

if !instance_exists(CoopController) {
    global.inputDelay = 0
}