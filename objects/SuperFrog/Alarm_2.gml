with instance_create(x, y, EnemyBullet2) {
    motion_add(random(360), 2)
    image_angle = direction
    team = other.team
    creator = other.id
    hit_id = other.spr_idle
}

alarm[2] = 3