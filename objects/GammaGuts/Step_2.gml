if instance_exists(creator) {
    x = creator.x + creator.hspeed
    y = creator.y + creator.vspeed
    visible = creator.visible
}
else instance_destroy()