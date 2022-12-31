if hp <= 0 {
    instance_destroy()
    exit
}

if inframes inframes--

motion_add(direction, .8)

if see_object(target, id) {
    motion_add(target_direction, .4)
}

if speed > 4 speed = 4