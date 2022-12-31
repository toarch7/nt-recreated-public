instance_destroy()
instance_create(x, y, Dust)

snd_play_hit(sndHitWall, .2)

if team != 2 {
    if !isset("noraddrop") {
        with instance_create(x, y, Rad) {
            motion_add(other.direction, other.speed)
            motion_add(random(360), 8)

            repeat(speed) speed *= 0.9
        }
    }
}