if skill_get(17) {
    snd_play_hit_big(sndPlasmaBigExplodeUpg, 0.2)
} else snd_play_hit_big(sndPlasmaBigExplode, 0.2)

ang = random_angle
repeat(4) {
    with instance_create(xprevious, yprevious, PlasmaBig) {
        motion_add(other.ang, 2)
        image_angle = direction
        team = other.team
    }
    ang += 90
}

instance_create(x, y, PortalClear)

with ThroneStatue {
    if distance_to_object(other) <= 48 && instance_exists(Nothing) {
        instance_destroy()
    }
}