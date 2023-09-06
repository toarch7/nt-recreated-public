if lockstep_stop
	exit

gpu_set_blendmode(bm_add)

draw_self()

gpu_set_blendmode(bm_normal)