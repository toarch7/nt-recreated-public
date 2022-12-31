event_inherited()
friction = 0.3

wallbounce = 1
if instance_exists(Player) {
    if skill_get(15) wallbounce = 6
}

typ = 1