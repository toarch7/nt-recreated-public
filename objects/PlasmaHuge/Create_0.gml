event_inherited()
/*THIS IS HOW IT SHOULD WORK

damagers have a DAMAGE
their collision can be NORMAL, PIERCING or PIERCING AT OVERKILL (piercing checks per frame)
their type can be 0, DEFLECTABLE, DESTRUCTABLE or DEFLECTORS
they have a FORCE and can be 0 or DIRECTIONAL */

typ = 1 //0 = normal, 1 = deflectable, 2 = destructable, 3 = deflectable

dmg = 25

if instance_exists(Player) {
    if skill_get(17) image_xscale += .2
}

image_speed = 0.5
sleep(100)

/* */
/*  */