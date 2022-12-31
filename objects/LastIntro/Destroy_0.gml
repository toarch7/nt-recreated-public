instance_create(x, (y - 32), LastChair)
instance_create(x, y, LastFire)
event_inherited()
instance_create(x, (y - 24), Last)
img = 0
repeat(4) {
    with(instance_create(((x + random(32)) - 16), ((y + random(32)) - 16), Shell)) {
        motion_add((random(180) + 180), (random(6) + 3))
        sprite_index = sprDeskDebris
        image_index = other.img
        image_speed = 0
    }
    img += 1
}