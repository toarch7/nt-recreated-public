if skill_get(17) {
    snd_play_hit(sndPlasmaBigExplodeUpg, 0.2)
} else snd_play_hit(sndPlasmaBigExplode, 0.2)

ang = random_angle
repeat(10) {
    with instance_create(xprevious, yprevious, PlasmaBall) {
        motion_add(other.ang, 2)
        image_angle = direction
        team = other.team
    }
    ang += 360 / 10
}

instance_create(x, y, PortalClear)

with ThroneStatue {
    if distance_to_object(other) <= 32 && instance_exists(Nothing) {
        instance_destroy()
    }
}