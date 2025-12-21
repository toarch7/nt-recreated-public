if (hp > 0) exit

if instance_number(TechnoMancer) <= 1 {
    with (MusCont) alarm[1] = 1
	
    spr_dead = sprTechnoMancerDead
    snd_dead = sndTechnomancerDead
}
else {
	spr_dead = sprTechnoMancerDead
}

with (TechnoMancer) alarm[4] = 1

event_inherited()

repeat (2) scrDrop(100, 0)
