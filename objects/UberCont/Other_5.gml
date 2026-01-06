/// @description Write save data
save_set_value("other", "fullscreen", window_get_fullscreen())
save_set_value("data", "tot_time", tot_time)

want_pause = 0
want_restart = 0

if dont_save {
    dont_save = false
    exit
}

scrSave()

if (!instance_exists(CoopController)) {
    global.inputDelay = 0
}