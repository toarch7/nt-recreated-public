event_inherited()
if (sprite_index != spr_fire) motion_add(direction, 0.5)
if (speed > 1.8) speed = 1.8
if (explode == 1) {
    with(instance_create(x, y, LaserCharge)) {
        motion_add(random(360), (2 + random(1)))
        alarm[0] = (10 + random(10))
    }
}
if (((alarm[2] > 8) && (random(4) < 1)) || (random(20) < 1)) {
    with(instance_create(x, y, EnemyLightning)) {
        image_angle = random(360)
        team = other.team
        ammo = (2 + random(4))
        hit_id = other.hit_id
        event_perform(2, 0)
        visible = 0
        with(instance_create(x, y, LightningSpawn))
        image_angle = other.image_angle
    }
}