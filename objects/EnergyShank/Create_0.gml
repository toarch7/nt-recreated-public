event_inherited()
image_speed = 0.7
if instance_exists(Player) {
    if skill_get(17) {
        image_speed = 0.4
    }
}


typ = 0 //0 = nothing, 1 = deflectable, 2 = destructable, 3 = deflectable