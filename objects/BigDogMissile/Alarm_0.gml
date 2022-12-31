if GameCont.loops alarm[0] = max(1, 12 - GameCont.loops)

with instance_create(x, y, EnemyBullet1) {
    motion_add(other.direction, other.speed + 2)
    image_angle = direction
    creator = other.id
    team = other.team
    hit_id = sprScrapBossIdle
}