scrUltras()
p = 0
selected = 0
race = 0

race = GameCont.race

with Player {
    if race == 14 && is_me {
		if !UberCont.cgot[14] {
	        UberCont.cgot[14] = 1
			
	        show_unlock_popup("@wSKELETON UNLOCKED@s#FOR REACHING LEVEL ULTRA")
			
			with instance_create(x, y, UnlockScreen) {
	            race = 14
	            skin = 0
	        }
		}
		
		scrAchievement(AchievID.UNSTOPPABLE)
    }
}

net_index = instance_number(object_index)