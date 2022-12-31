instance_create(x, y, Nothing2)

instance_activate_object(Top)
instance_activate_object(TopSmall)

with Top {
    instance_destroy()
}

with TopSmall {
    instance_destroy()
}

with Bones {
    instance_destroy()
}

with Wall {
    instance_change(InvisiWall, 0)
    visible = 0
}

instance_destroy()