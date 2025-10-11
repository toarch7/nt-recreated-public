if lockstep_stop
	exit

scrDrawAlignCenter()
draw_text_bigname(view_xview + view_width / 2, view_yview + 24, loc("STATS"), c_uigray)
scrDrawAlignDefault()

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