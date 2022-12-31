if ammo > 0 {
    alarm[2] = 5
    flip = 1
    snd_play_gun(sndNothingFire, 0)

    repeat 2 {
        with instance_create(x - 40 * flip, y + 50, EnemyBullet2) {
            hit_id = other.hit_id
            sprite_index = sprHorrorBullet
            motion_add(270 + (other.addangle + 20) * other.flip, 6)
            image_angle = direction
            team = other.team
        }

        with instance_create(x - (56 * flip), y + 50, EnemyBullet2) {
            hit_id = other.hit_id
            sprite_index = sprHorrorBullet
            motion_add(270 + (other.addangle * other.flip), 6)
            image_angle = direction
            team = other.team
        }

        with instance_create(x - (72 * flip), y + 50, EnemyBullet2) {
            hit_id = other.hit_id
            sprite_index = sprHorrorBullet
            motion_add(270 + (other.addangle - 20) * other.flip, 6)
            image_angle = direction
            team = other.team
        }

        flip = -1
    }

    ammo -= 1
}