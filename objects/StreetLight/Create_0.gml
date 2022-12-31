max_hp = 5
size = 1

spr_idle = sprStreetLight
spr_hurt = sprStreetLightHurt
spr_dead = sprStreetLightDead


event_inherited()


snd_hurt = sndHitMetal


move_contact_solid(choose(0, 90, - 90, 180), 320)
move_contact_solid(90, 8)

if place_meeting(x, y, Car) instance_destroy()

depth = -y