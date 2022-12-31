max_hp = (350 * ((KeyCont.players / 2) + 0.5))
max_hp *= (1 + (GameCont.loops / 3))
raddrop = 50
meleedamage = 0
size = 3
hit_id = 33
main = 1
spr_idle = sprTechnoMancerInactive
spr_walk = sprTechnoMancerInactive
spr_hurt = sprTechnoMancerHurt
spr_dead = sprTechnoMancerDisappear

event_inherited()

snd_hurt = sndTechnomancerHurt
snd_dead = sndTechnomancerDead

with Wall {
    if place_meeting(x, y, other) {
        instance_destroy()
        instance_create(x, y, FloorExplo)
    }
}

alarm[1] = 300
intro = 0
drawspr = spr_idle
drawimg = 0