if sprite_index == spr_hurt && image_index < 1 {
    d3d_set_fog(1, c_white, depth, depth + 1)
}

if walk > 0 && instance_exists(Player) {
    wave += 0.05
    footstep += 0.4

    if footstep > 2.75 {
        BackCont.shake += 2
        footstep -= 2.75
        snd_play_pitchvol(sndNothingFootstep, 0, 0.8)
    }
}

draw_sprite(sprNothingLeg, wave * 8, x - 128, y - 24)
draw_sprite(sprNothingLeg, wave * 8 + 2.75, x - 128, y)
draw_sprite(sprNothingLeg, wave * 8 + 5.5, x - 128, y + 24)
draw_sprite(sprNothingLeg, wave * 8 + 8.25, x - 128, y + 48)
draw_sprite_ext(sprNothingLeg, wave * 8, x + 128, y - 24, - 1, 1, 0, c_white, 1)
draw_sprite_ext(sprNothingLeg, wave * 8 + 2.75, x + 128, y, - 1, 1, 0, c_white, 1)
draw_sprite_ext(sprNothingLeg, wave * 8 + 5.5, x + 128, y + 24, - 1, 1, 0, c_white, 1)
draw_sprite_ext(sprNothingLeg, wave * 8 + 8.25, x + 128, y + 48, - 1, 1, 0, c_white, 1)
draw_sprite(sprNothingBack, - 1, x, y)
draw_sprite(sprNothingMiddle, - 1, x, y)
draw_sprite(sprNothingLeft, - 1, x, y)
draw_sprite(sprNothingRight, - 1, x, y)

d3d_set_fog(0, 0, 0, 0)

draw_sprite(flame, flanim, x - 89, y - 43)
draw_sprite(flame, flanim, x + 91, y - 43)
draw_sprite(flame, flanim, x - 89, y + 13)
draw_sprite(flame, flanim, x + 91, y + 13)

flanim += 0.4