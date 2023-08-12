friction = 0.2

blink = 30
alarm[0] = 200 + random(30)

image_speed = 0

num = 2

if skill_get(9)
	num = 4

if crown_current == crwn_haste {
	alarm[0] /= 3
	num ++
}

if GameCont.area == 102 {
	sprite_index = sprSlice
}