if instance_exists(creator) {
    x = creator.x
    y = creator.y
    visible = creator.visible
	depth = creator.depth - 1
}
else instance_destroy()