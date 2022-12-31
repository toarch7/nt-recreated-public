hp = 0
instance_create((x - 48), y, PortalClear)
instance_create((x + 48), y, PortalClear)
instance_create(x, (y - 48), PortalClear)
instance_create(x, (y + 48), PortalClear)
snd_play_hit_big(sndLaser, 0.2)
lang = random(360)
repeat(5 + (GameCont.loops * 2)) {
    with(instance_create(x, y, EnemyLaser)) {
        image_angle = other.lang
        team = other.team
        hit_id = other.spr_idle
        event_perform(2, 0)
    }
    lang += (360 / (5 + (GameCont.loops * 2)))
}