if !UberCont.cgot[num]
	sprite_index = sprCharSelectLocked

var f = start + floor(pos / 2)

if global.time == f
	anim = 1

if global.time >= f
	draw_sprite_ext(sprite_index, num, x, y + 16 + anim, 1, 1, 0, qm(selected, c_white, c_gray), 1)

if anim > 0
	anim --