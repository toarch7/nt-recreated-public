if friction > 0.15 {
    with instance_create(x, y, Confetti) {
        motion_add(other.direction + random_spread(10), random(1))
        motion_add(random(360), random(2))
        team = other.team
    }
}