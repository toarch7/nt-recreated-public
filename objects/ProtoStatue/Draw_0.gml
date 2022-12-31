draw_sprite(sprite_index, - 1, x, y)
draw_sprite(sprPStatLights, anim, x, y)

if canim > 0 && hp < max_hp * 0.7 {
    draw_sprite(sprPStatReady, canim, x, y)
}