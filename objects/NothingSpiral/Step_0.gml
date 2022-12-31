with projectile {
    if point_distance(x, y, view_xview + view_width / 2, view_yview + view_height / 2) > 1000 {
        instance_destroy()
    }
}

with Wall {
    instance_change(InvisiWall, 1)
}