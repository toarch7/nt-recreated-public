event_inherited()
friction = 0.8

wallbounce = 0
if instance_exists(Player) {
    if skill_get(15) wallbounce = 4
}

typ = 1

bonus = 2