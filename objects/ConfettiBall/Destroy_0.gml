instance_create(x, y, Dust)

repeat 5 {
    with instance_create(x, y, Confetti) {
        motion_add(random_angle, random(4))
        team = other.team
    }
}