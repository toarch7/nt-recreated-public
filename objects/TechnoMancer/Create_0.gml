max_hp = (350 * ((player_count / 2) + 0.5))
max_hp *= (1 + (GameCont.loops / 3))
raddrop = 50
meleedamage = 0
size = 3
hitid = HitId.Technomancer
main = true
spr_idle = sprTechnoMancerInactive
spr_walk = sprTechnoMancerInactive
spr_hurt = sprTechnoMancerHurt
spr_dead = sprTechnoMancerDisappear

event_inherited()

snd_hurt = sndTechnomancerHurt
snd_dead = sndTechnomancerDead

with Wall {
	if (place_meeting(x, y, other)) scrWallDestroy(id)
}

alarm[1] = 300
intro = 0
drawspr = spr_idle
drawimg = 0