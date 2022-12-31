if instance_exists(owner) {
    x = owner.x + owner.hspeed
    y = owner.y + owner.vspeed
    visible = owner.visible
} else instance_destroy()