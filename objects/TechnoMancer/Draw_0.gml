if lockstep_stop
	exit

var _broke_batch = (nexthurt > current_frame)
if (_broke_batch) gpu_set_fog(true, c_white, 0, 0)

if (drawspr == sprTechnoMancerFire1
	|| drawspr == sprTechnoMancerFire2
	|| drawspr == sprTechnoMancerAppear
	|| drawspr == sprTechnoMancerDisappear
) {
	var _img = sprite_get_number(sprTechnoMancerActivate) - 1
	draw_sprite_ext(sprTechnoMancerActivate, _img, x, y, right, 1, 0, c_white, 1)
}

drawimg += 0.4
draw_sprite_ext(drawspr, drawimg, x, y, right, 1, 0, c_white, 1)

if (_broke_batch) gpu_set_fog(0, 0, 0, 0)