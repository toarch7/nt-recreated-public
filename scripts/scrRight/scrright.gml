function scrRight(check_gunangle) {
    if check_gunangle {
        if gunangle > 270 or (gunangle > 0 && gunangle < 90) right = 1
        else right = -1

        return
    }

    if hspeed > 0 right = 1
    else right = -1
}