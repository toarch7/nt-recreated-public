if lockstep_stop
	exit

if ((sprite_index == spr_hurt) && (image_index < 1.5)) gpu_set_fog(1, c_white, depth, (depth + 1))
drawimg += 0.4
draw_sprite_ext(drawspr, drawimg, x, y, right, 1, 0, c_white, 1)
gpu_set_fog(0, 0, 0, 0)