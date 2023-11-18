var kid_alpha = clamp((y - y2) / 32, 0, 1) * image_alpha

if kid_alpha > 0 {
	var ang = 200,
		xx = x2 + ldrx(16, ang),
		yy = y2 + ldry(16, ang)
	
	draw_sprite_ext(sprRogueStrike, global.time * 0.4, xx, yy, 1, 1, 200, c_white, kid_alpha)
}

draw_self()