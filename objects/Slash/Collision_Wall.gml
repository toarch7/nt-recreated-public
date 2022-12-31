x -= hspeed
y -= vspeed

if speed > 2 {
    x += lengthdir_x(3, image_angle)
    y += lengthdir_y(3, image_angle)
}

if !walled {
    with instance_create(other.x + 8, other.y + 8, MeleeHitWall) {
        image_angle = point_direction(other.x, other.y, x, y)
    }

    walled = 1

    if guitar {
        var snd = asset_get_index("sndGuitarHit" + string(irandom(6) + 1))

        if sound_exists(snd) {
            snd_play_hit(snd, 0.2)
        }
    } else snd_play(sndMeleeWall)
}