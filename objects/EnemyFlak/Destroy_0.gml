repeat(16) {
    with instance_create(x, y, EnemyBullet3) {
        motion_add(random_angle, 8 + random(4))
        image_angle = direction
        team = other.team
        hit_id = other.hit_id
    }
}
sleep(20)

repeat(6) {
    with instance_create(x, y, Smoke)
    motion_add(random_angle, random(3))
}

BackCont.shake += 8