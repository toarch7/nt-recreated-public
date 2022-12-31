max_hp = 2
size = 1

var img;
img = choose(1, 2, 3)

if instance_nearest(x - 16, y - 16, Floor).styleb = 1 {
    if img = 1 {
        spr_idle = sprCactusB
        spr_hurt = sprCactusBHurt
        spr_dead = sprCactusBDead
    }
    if img = 2 {
        spr_idle = sprCactusB2
        spr_hurt = sprCactusB2Hurt
        spr_dead = sprCactusB2Dead
    }
    if img = 3 {
        spr_idle = sprCactusB3
        spr_hurt = sprCactusB3Hurt
        spr_dead = sprCactusB3Dead
    }
} else {
    if img = 1 {
        spr_idle = sprCactus
        spr_hurt = sprCactusHurt
        spr_dead = sprCactusDead
    }
    if img = 2 {
        spr_idle = sprCactus2
        spr_hurt = sprCactus2Hurt
        spr_dead = sprCactus2Dead
    }
    if img = 3 {
        spr_idle = sprCactus3
        spr_hurt = sprCactus3Hurt
        spr_dead = sprCactus3Dead
    }
}

event_inherited()

move_contact_solid(random(360), random(12))
if !place_free(x, y + 12) move_contact_solid(random(90) + 45, random(12))