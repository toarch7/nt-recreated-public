image_xscale = choose(1, -1)
image_speed = 0.4

if ultra_get(Race.Plant, 1) {
	snd_play(skill_get(Mut.ThroneButt) ? sndPlantSnareTrapperTB : sndPlantSnareTrapper)
}
else snd_play(skill_get(Mut.ThroneButt) ? sndPlantSnareTB : sndPlantSnare)

typ = 1 //0 = nothing, 1 = deflectable, 2 = destructable