if lockstep_stop
	exit

draw_align(fa_center, fa_middle)
var _name = loc("MainMenu:Stats", "STATS")
draw_text_bigname(view_xview_center, view_yview + 24, _name, c_uigray)
draw_align()

if select == 0 {
    scrDrawStats()
}
else scrDrawCharStats()

if scr_keyboard_check_pressed(vk_alt) {
    diy = 2

    repeat 12 {
        UberCont.crowngot[select, diy] = 1
        diy++
    }
}