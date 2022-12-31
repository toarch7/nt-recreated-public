if (BackCont.shake < 2) BackCont.shake = 2
if ((GameCont.area == 101) && ((random(4) < 1) && (speed > 0))) instance_create(x, y, Bubble)
x += (random(2) - 1)
y += (random(2) - 1)
if (random(4) < 1) {
    with(instance_create(x, y, Lightning)) {
        image_angle = random(360)
        team = other.team
        hit_id = other.hit_id
        ammo = (5 * choose(1, 1, 1, 1, 2, 3))
        event_perform(2, 0)
        visible = 0
        with(instance_create(x, y, LightningSpawn))
        image_angle = other.image_angle
    }
}
if (speed == 0) instance_destroy()