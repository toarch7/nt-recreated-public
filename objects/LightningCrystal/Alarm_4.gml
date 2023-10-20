hp = 0
instance_create((x - 48), y, PortalClear)
instance_create((x + 48), y, PortalClear)
instance_create(x, (y - 48), PortalClear)
instance_create(x, (y + 48), PortalClear)
snd_play_hit_big(sndLaser, 0.2)
lang = random_angle
repeat(5 + (GameCont.loops * 2)) {
    with(instance_create(x, y, EnemyLightning)) {
        image_angle = other.lang
        team = other.team
        ammo = (6 + random(6))
        hit_id = other.hit_id
        event_perform(2, 0)
        visible = 0
        with(instance_create(x, y, LightningSpawn))
        image_angle = other.image_angle
    }
    lang += (360 / (5 + (GameCont.loops * 2)))
}