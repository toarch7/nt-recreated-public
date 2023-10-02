function show_unlock_popup(message) {
    with UberCont {
        alarm[1] = 90
        unlock_text = loc(message)
        draw_unlock = 1
    }
}