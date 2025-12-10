if current_frame_active && friction > 0.15 {
    with instance_create(x, y, Confetti) {
        motion_add(other.direction + orandom(10), random(1))
        motion_add(random_angle, random(2))
        team = other.team
    }
}