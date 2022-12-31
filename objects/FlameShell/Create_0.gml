event_inherited()
friction = 0.6

wallbounce = 0
if instance_exists(Player) {
    if skill_get(15) wallbounce = 2
}

typ = 1

hit_id = -1

bonus = 1