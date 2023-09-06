if lockstep_stop
	exit

draw_self()
draw_sprite(sprNothingSkeleton, 0, x, y - 22)

if flame != -1 {
    draw_sprite(flame, flameanim, x - 81, y - 38)
    draw_sprite(flame, flameanim, x + 81, y - 38)
    draw_sprite(flame, flameanim, x - 81, y + 18)
    draw_sprite(flame, flameanim, x + 81, y + 18)

    if flameanim < 3 {
        flameanim += 0.4
    } else {
        flameanim = 0

        if flame == sprThroneFlameEnd {
            flame = -1
        }
    }
}