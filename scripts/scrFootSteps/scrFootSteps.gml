function scrFootSteps() {
	var _race = race
	
    if sprite_index != spr_walk or !visible or (_race == 6 && bskin == 1) {
        footstep = 0
		exit
    }
	
	if !roll && round(image_index) >= footstep + 2 && (round(image_index) - 1 < footstep + 2 or footextra == 1) {
        var material = instance_nearest(x - 16, y - 16, Floor)
		
        if !instance_exists(material)
            exit
		
        material = material.material
		
        if place_meeting(x, y, Carpet)
            material = 1

        if place_meeting(x, y, FloorMiddle)
            material = 3

        if skill_get(2) {
            with instance_create(x, y + 4, Dust)
				sprite_index = sprExtraFeetDust
        }
		
		if _race == 8 { // ROBOT
            if material == 1 or material == 4
				snd_play_pitchvol(choose(sndFootMetSand1, sndFootMetSand2, sndFootMetSand3, sndFootMetSand4, sndFootMetSand5, sndFootMetSand6), 0.2, 0.1)

            if material == 2 or material == 5
				snd_play_pitchvol(choose(sndFootMetRock1, sndFootMetRock2, sndFootMetRock3, sndFootMetRock4, sndFootMetRock5, sndFootMetRock6), 0.2, 0.1)

            if material == 3 or material == 6
				snd_play_pitchvol(choose(sndFootMetMetal1, sndFootMetMetal2, sndFootMetMetal3, sndFootMetMetal4, sndFootMetMetal5, sndFootMetMetal6), 0.2, 0.1)
        }
		else if _race == 6 or _race == 10 { // Y.V. AND REBEL
            if material == 1 or material == 4 snd_play_pitchvol(choose(sndFootShoSand1, sndFootShoSand2, sndFootShoSand3, sndFootShoSand4, sndFootShoSand5, sndFootShoSand6), 0.2, 0.2)

            if material == 2 or material == 5
				snd_play_pitchvol(choose(sndFootShoRock1, sndFootShoRock2, sndFootShoRock3, sndFootShoRock4, sndFootShoRock5, sndFootShoRock6), 0.2, 0.2)

            if material == 3 or material == 6
				snd_play_pitchvol(choose(sndFootShoMetal1, sndFootShoMetal2, sndFootShoMetal3, sndFootShoMetal4, sndFootShoMetal5, sndFootShoMetal6), 0.2, 0.2)
        }
		else if _race == 5 { // PLANT
            if material == 1 or material == 4
				snd_play_pitchvol(choose(sndFootPlaSand1, sndFootPlaSand2, sndFootPlaSand3, sndFootPlaSand4, sndFootPlaSand5, sndFootPlaSand6), 0.2, 0.1)

            if material == 2 or material == 5
				snd_play_pitchvol(choose(sndFootPlaRock1, sndFootPlaRock2, sndFootPlaRock3, sndFootPlaRock4, sndFootPlaRock5, sndFootPlaRock6), 0.2, 0.1)

            if material == 3 or material == 6
				snd_play_pitchvol(choose(sndFootPlaMetal1, sndFootPlaMetal2, sndFootPlaMetal3, sndFootPlaMetal4, sndFootPlaMetal5, sndFootPlaMetal6), 0.2, 0.1)
        }
		else if _race == 13 { // BIG DOG
            snd_play_pitchvol(sndBigDogWalk, 0.2, 0.1)
        }
		else { // OTHERS
            if material == 1 or material == 4
				snd_play_pitchvol(choose(sndFootOrgSand1, sndFootOrgSand2, sndFootOrgSand3, sndFootOrgSand4, sndFootOrgSand5, sndFootOrgSand6), 0.2, 0.2)

            if material == 2 or material == 5
				snd_play_pitchvol(choose(sndFootOrgRock1, sndFootOrgRock2, sndFootOrgRock3, sndFootOrgRock4, sndFootOrgRock5, sndFootOrgRock6), 0.2, 0.2)

            if material == 3 or material == 6
				snd_play_pitchvol(choose(sndFootOrgMetal1, sndFootOrgMetal2, sndFootOrgMetal3, sndFootOrgMetal4, sndFootOrgMetal5, sndFootOrgMetal6), 0.2, 0.2)
        }

        if (material > 3 or _race == 4) && random(5) < 1
            snd_play_pitchvol(choose(sndFootSlime1, sndFootSlime2, sndFootSlime3, sndFootSlime4, sndFootSlime5, sndFootSlime6), 0.2, 0.2)
		
        if _race == 5 {
            footstep ++
			
            if footstep >= 3
                footstep -= 3
        }
		else if _race == 8 or _race == 11 {
            footstep ++

            if footstep == 2 or footstep == 5
				footstep ++

            if footstep >= 6 footstep -= 6
        }
		else {
            footstep += 3
			
            if footstep >= 6
                footstep -= 6
        }
    }
}