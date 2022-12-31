with instance_create(x, y, EnemyBullet1) {
    motion_add(other.direction, 4)
    image_angle = direction
    team = other.team
    hit_id = other.spr_idle
}

with instance_create(x, y, EnemyBullet1) {
    motion_add(other.direction + 20, 4)
    image_angle = direction
    team = other.team
    hit_id = other.spr_idle
}

with instance_create(x, y, EnemyBullet1) {
    motion_add(other.direction - 20, 4)
    image_angle = direction
    team = other.team
    hit_id = other.spr_idle
}

walk = 0