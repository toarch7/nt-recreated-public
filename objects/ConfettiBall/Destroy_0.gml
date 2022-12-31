instance_create(x, y, Dust)

repeat 5 {
    with instance_create(x, y, Confetti) {
        motion_add(random(360), random(4))
        team = other.team
    }
}