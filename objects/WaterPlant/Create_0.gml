max_hp = 2
size = 1

spr_idle = choose(sprWaterPlant2, sprWaterPlant)
spr_hurt = sprWaterPlantHurt
spr_dead = sprWaterPlantDead

event_inherited()

move_contact_solid(random(360), random(12))
if !place_free(x, y + 12) move_contact_solid(random(90) + 45, random(12))