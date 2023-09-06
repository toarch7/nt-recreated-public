if lockstep_stop
	exit

if alarm[0] <= flash_at {
    var c = alarm[0] % 5 > 2 ? c_black : c_white

    gpu_set_fog(1, c, 0, 0)

    draw_self()

    gpu_set_fog(0, c, 0, 0)
} else {
    draw_self()
}