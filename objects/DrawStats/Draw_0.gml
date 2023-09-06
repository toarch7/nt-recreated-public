if lockstep_stop
	exit

if select == 0 {
    scrDrawStats()
}
else scrDrawCharStats()

if keyboard_check_pressed(vk_alt) {
    diy = 2

    repeat 12 {
        UberCont.crowngot[select, diy] = 1
        diy++
    }
}