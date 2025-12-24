instance_create(x, y, Nothing2)

instance_destroy(TopSmall)
instance_destroy(Bones)

with (Wall) {
	instance_create(x, y, InvisiWall)
    instance_destroy(id, false)
}

instance_destroy()