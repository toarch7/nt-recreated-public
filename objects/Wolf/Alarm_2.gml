with instance_create(x, y, EnemyBullet1) {
    motion_add(other.direction, 4)
    image_angle = direction
    team = other.team
    hitid = other.hitid
}

with instance_create(x, y, EnemyBullet1) {
    motion_add(other.direction + 20, 4)
    image_angle = direction
    team = other.team
    hitid = other.hitid
}

with instance_create(x, y, EnemyBullet1) {
    motion_add(other.direction - 20, 4)
    image_angle = direction
    team = other.team
    hitid = other.hitid
}

walk = 0