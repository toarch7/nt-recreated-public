scrTarget()
alarm[0] = 30
charge = 0
if instance_exists(target) {
    walkdir = (target_direction + ((50 + random(20)) * flip))
    walk = 60
    if (random(10) < 1) flip = (-flip)
} else {
    walkdir = random(360)
    walk = 60
}