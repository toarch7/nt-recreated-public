scrAchievements()

ypos = 0
click = 0

mousex = 0
mousey = 0
hold_time = 0

max_height = 0

unlocks = 0
anim = []

for(var i = 0; i <= achievementmax; i ++) {
	if scrAchievementIsUnlocked(i) {
        unlocks ++
    }
	
	max_height += 40
	anim[i] = -120
}

wrapped_strings = {}

max_height -= 40 * 4 + 7

friction = 0.4

press = 0

least = 0

dragging = -1
wait = 10