with other {
    if !charge {
        raddrop++

        snd_play(sndRadPickup)
        instance_create(other.x + random_spread(3), other.y + random_spread(3), RadEat)
        instance_destroy(other.id, 1)
    }
}