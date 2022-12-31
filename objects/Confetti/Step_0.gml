if z > 0 {
    image_angle += rotspeed * speed
}

speed *= .9

if speed < 3 {
    if z > 0 {
        z -= 0.4
    } else {
        image_alpha -= 0.1

        if image_alpha < 0 {
            instance_destroy()
        }
    }
}

z += speed / 5