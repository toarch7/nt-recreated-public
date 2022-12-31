if inframes > 4 {
    gpu_set_fog(1, c_white, 0, 0)
    draw_sprite_ext(sprite_index, image_index, x, y - z, right, 1, 0, c_white, 1)
    gpu_set_fog(0, c_white, 0, 0)
} else draw_sprite_ext(sprite_index, image_index, x, y - z, right, 1, 0, c_white, 1)