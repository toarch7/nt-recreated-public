scrAchievements()

ypos = 0
click = 0

mousex = 0
mousey = 0
hold_time = 0

max_height = 0

unlocks = 0
anim = []

for(var i = 0; i < array_length(chiev_name); i ++) {
	chiev_name[i] = loc(chiev_name[i])
	chiev_text[i] = loc(chiev_text[i])
	
	if chiev_have[i] {
        unlocks ++
    }
    
	anim[i] = -120
	
	max_height += 40
}

max_height -= 40 * 4 + 7

friction = 0.4

press = 0

least = 0