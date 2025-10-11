scrUltras()
p = 0
selected = 0
race = 0

race = GameCont.race

with Player {
    if race == Race.Skeleton && is_me {
		scrRaceUnlock(Race.Skeleton)
    }
}

scr_network_instance()