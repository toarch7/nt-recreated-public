//grow = ((grow+1)*1.00005)-1
grow += 0.0004
image_xscale += grow
image_yscale += grow

grow = ((grow + 1) * (1 + 0.0005 * image_xscale)) - 1
if !instance_exists(SpiralCont) {
    if grow <= .0004 {
        image_speed = 0
        image_index = 1
    }
    grow *= 1.5
}

if image_xscale > 2 + (!instance_exists(SpiralCont)) * 2 and(lanim < 0 or lanim > 6) {
    instance_destroy()
}

lanim += 0.35