with other {
    if charge <= 0 {
        raddrop += 10
        with instance_create(x + orandom(3), y + orandom(3), RadEat)
        sprite_index = sprEatBigRad

        instance_destroy(other.id, 1)
    }
}