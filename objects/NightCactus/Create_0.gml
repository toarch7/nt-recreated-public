max_hp = 2
size = 1

var img;
img = choose(1, 2, 3)

if img = 1 {
    spr_idle = sprNightCactus
    spr_hurt = sprNightCactusHurt
    spr_dead = sprNightCactusDead
}
if img = 2 {
    spr_idle = sprNightCactus2
    spr_hurt = sprNightCactus2Hurt
    spr_dead = sprNightCactus2Dead
}
if img = 3 {
    spr_idle = sprNightCactus3
    spr_hurt = sprNightCactus3Hurt
    spr_dead = sprNightCactus3Dead
}

event_inherited()

move_contact_solid(random_angle, random(12))
if !place_free(x, y + 12) move_contact_solid(random(90) + 45, random(12))