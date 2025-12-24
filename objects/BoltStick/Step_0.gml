if instance_exists(target) {
    z = 0

    if (variable_instance_exists(target, "z")) {
        z = -target.z
		if (instance_is(target, DogGuardian)) z *= -1
    }

    x = target.x - ldrx(16, image_angle)
    y = target.y - ldry(16, image_angle) - z
    visible = target.visible
}
else {
	instance_destroy()
}
