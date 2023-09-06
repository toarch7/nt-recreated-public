if lockstep_stop
	exit

image_yscale -= 0.25
if image_yscale < 0 instance_destroy()

img += 0.5
if hit_id > 0 {
    other.last_hit = hit_id
}