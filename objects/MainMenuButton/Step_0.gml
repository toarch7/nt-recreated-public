if hover > 0 {
    hover = lerp(hover, 0, 0.4)

    if !hover {
        snd_play(sndSlider)
        hover = 0
    }
} else if distance_to_point(mouse_x, mouse_y) < 1 or gpadsel {
    light = 1
} else light = 0

if available splat = lerp(splat, light * 4, 0.4)