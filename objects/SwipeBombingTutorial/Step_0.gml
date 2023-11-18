if done {
	image_alpha = lerp(image_alpha, 0, 0.4)
	
	if image_alpha <= 0.01 {
		save_set_value("etc", "rogue_tutorial", true)
		instance_destroy()
	}
	
	exit
}

if alarm[0]
	exit

if state == 0 {
	image_alpha = lerp(image_alpha, 1, 0.4)
	
	if image_alpha >= 0.95 {
		if ++ timer > 5 {
			timer = 0
			state ++
			
			x2 = x
			y2 = y
		}
	
		y += 4
	}
}
else if state == 1 {
	
	if ++ timer > 30 {
		timer = 0
		state ++
	}
	
	x -= 5
	y += 2
}
else if state == 2 {
	image_alpha = lerp(image_alpha, 0, 0.2)
	
	if ++ timer > 60 {
		timer = 0
		state = 0
		
		x = xstart
		y = ystart
	}
	
	if timer < 5 {
		y -= 4
	}
}