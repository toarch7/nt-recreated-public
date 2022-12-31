with instance_create(x, y, EnemySlash) {
    image_angle = other.gunangle
    motion_add(other.gunangle + random(10) - 5, 2)
    creator = other.id
    team = other.team
    hit_id = other.spr_idle
}

wepangle *= -1

alarm[1] += 7