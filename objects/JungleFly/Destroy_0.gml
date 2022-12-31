event_inherited()

if hp <= 0 {
    if random(5) < 1 {
        instance_create(x, y, MaggotExplosion)
    }

    scrDrop(0, 20)
}