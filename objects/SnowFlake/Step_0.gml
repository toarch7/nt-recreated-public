if addy > 0 {
    addx -= sin(wave / 5)
    addy -= 1 - sin(wave / 3) / 2
    wave += 0.2
} else {
    image_alpha -= 0.05
    if image_alpha < 0 instance_destroy()
}