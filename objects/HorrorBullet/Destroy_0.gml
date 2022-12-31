with instance_create(x, y, BulletHit) {
    sprite_index = sprHorrorBulletHit
    if other.sprite_index == sprHorrorBullet2 {
        sprite_index = sprHorrorBullet2Hit
    }
}