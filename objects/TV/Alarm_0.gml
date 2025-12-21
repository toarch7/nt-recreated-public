if Menu.race != Race.Chicken {
    if tv = 1 myscreen = choose(sprTV1A, sprTV1B, sprTV1C)

    if tv = 2 myscreen = choose(sprTV2A, sprTV2B, sprTV2C)

    if tv = 3 myscreen = choose(sprTV3A, sprTV3B, sprTV3C)
	
    if tv = 4 myscreen = choose(sprTV4A, sprTV4B, sprTV4C)
}

alarm[0] = 30 + random(90)