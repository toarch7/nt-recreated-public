if hover > 0 {
    hover = lerp(hover, 0, 0.4)

    if !hover {
        hover = 0
    }
} else if clicked {
    light = 1
} else light = 0