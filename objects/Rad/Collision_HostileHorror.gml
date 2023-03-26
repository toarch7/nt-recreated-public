with other {
    if !charge {
        raddrop++

        snd_play(sndRadPickup)
        instance_create(other.x + orandom(3), other.y + orandom(3), RadEat)
        instance_destroy(other.id, 1)
    }
}