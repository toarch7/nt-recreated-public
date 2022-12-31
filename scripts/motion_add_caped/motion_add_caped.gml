function motion_addm(dir, spd, cap = 16) {
    if speed < spd {
        motion_add(dir, spd)

        if speed > cap {
            speed = cap
        }
    }
}