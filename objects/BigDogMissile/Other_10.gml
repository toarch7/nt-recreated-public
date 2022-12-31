event_inherited()

if instance_exists(creator) {
    motion_add(creator.gunangle, 0.1)
} else motion_add(direction, 0.1)

if sprite_index == spr_hurt {
    alarm[1] = 50
}

speed = 2 + skill_get(5)

if random(4) < 1 instance_create(xprevious, yprevious, Smoke)