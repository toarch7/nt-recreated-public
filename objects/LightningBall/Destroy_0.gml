snd_stop(snd)
snd_play_hit_big(sndLightningCannonEnd, 0.3)
ang = random(360)

instance_create(x, y, PortalClear)

repeat(9) {
    with(instance_create(x, y, Lightning)) {
        image_angle = random(360)
        hit_id = other.hit_id
        team = other.team
        ammo = 10 + random(10)
        event_perform(ev_alarm, 0)
        visible = 0
        with(instance_create(x, y, LightningSpawn))
        image_angle = other.image_angle
    }
}