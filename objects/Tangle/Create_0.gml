image_xscale = choose(1, -1)
image_speed = 0.4

if scr_ultra_get(Race.Plant, UltraSkill.Trapper) {
	snd_play(scr_skill_get(mut_throne_butt) ? sndPlantSnareTrapperTB : sndPlantSnareTrapper)
}
else {
	snd_play(scr_skill_get(mut_throne_butt) ? sndPlantSnareTB : sndPlantSnare)
}

typ = 1 //0 = nothing, 1 = deflectable, 2 = destructable