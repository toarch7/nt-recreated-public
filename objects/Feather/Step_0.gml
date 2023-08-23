if fall {
    fall --
	image_angle += rot

    x += 0.35 * sin(fall / 7)
    y += 0.3

    if speed > 0.2 {
        speed *= 0.9
    }
	else speed = 0
}