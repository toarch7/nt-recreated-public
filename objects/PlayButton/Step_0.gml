if !isset("hover") hover = 2
if !isset("available") available = 1

if hover > 0 {
    hover = lerp(hover, 0, 0.4)

    if !hover {
        snd_play(sndSlider)
        hover = 0
    }
} else if distance_to_point(mouse_x, mouse_y) < 1 or gpadsel {
    light = 1
} else light = 0

if available splat = lerp(splat, light * 4, .4)

if wait wait--

if !os_is_network_connected() && available && (image_index == 1 or image_index == 2) {
    available = 0
}