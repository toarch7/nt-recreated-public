if lockstep_stop
	exit

if !charge && instance_exists(creator) {
    anim += 0.4
    if !disappear {
        draw_sprite(sprNothingBeam, anim, x, creator.y + 48)
        draw_sprite_ext(sprNothingBeamStretch, - 1, x, y, 1, image_yscale, 0, c_white, 1)
    } else {
        draw_sprite(sprNothingBeamStop, anim, x, creator.y + 48)
        if round(anim) > 7 {
            instance_destroy()
        }
    }
}