x = xstart + lengthdir_x(dist * image_xscale, angle)
y = ystart + lengthdir_y(dist * image_xscale, angle)
angle += turnspeed

dist += grow

//grow = ((grow+1)*1.00005)-1
//grow = ((grow+1)*1.00005)-1
grow += 0.0005
image_xscale += grow / 1.5
image_yscale += grow / 1.5
grow = ((grow + 1) * (1 + 0.001 * image_xscale)) - 1

if !instance_exists(SpiralCont) grow *= 1.5
else {
    if SpiralCont.type = 2 grow *= (image_xscale / 10) + 1
}

grow *= (image_xscale / 20) + 1
if x < view_xview - 16 or x > view_xview + view_width + 16 or y < view_yview - 16 or y > view_yview + view_height + 16 instance_destroy()

image_angle += rotspeed