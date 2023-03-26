if image_index < 1 image_index += random(0.04)
else image_index += 0.4

if !irandom(3) {
    with instance_create(x, y, Curse) {
        hspeed = orandom(1)
    }
}
