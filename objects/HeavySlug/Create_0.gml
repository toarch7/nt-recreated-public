event_inherited()
friction = 1
wallbounce = 2
knockback_speed = 14
spr_fade = sprHeavySlugHit
damage = 60
if instance_exists(Player) {
    if scr_skill_get(mut_shotgun_shoulders) wallbounce = 6
}
typ = 1
bonus = 10
alarm[2] = 2