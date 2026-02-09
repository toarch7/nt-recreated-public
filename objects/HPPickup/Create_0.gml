friction = 0.2

blink = 30
alarm[0] = ceil((200 + random(30)) / ((5 + GameCont.loops) / 5) * scrCustomModePickupTimeMult())

image_speed = 0

num = 2

if (scr_skill_get(mut_second_stomach)) num = 4

if (scrCrownCheck(crwn_haste)) {
	alarm[0] /= 3
	num ++
}

if (GameCont.area == area_pizza_sewers) sprite_index = sprSlice