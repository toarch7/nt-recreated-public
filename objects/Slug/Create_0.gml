event_inherited()
damage = 22
friction = 0.8
spr_fade = sprSlugHit
knockback_speed = 10
wallbounce = 0

if instance_exists(Player) {
    if scr_skill_get(mut_shotgun_shoulders) wallbounce = 4
}

typ = 1

bonus = true
alarm[2] = 2
