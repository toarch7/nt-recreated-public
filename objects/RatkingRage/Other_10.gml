event_inherited()

if walk > 0 {
    walk -= 1
    motion_add(mydir, 1.5)
    if walk <= 0 instance_destroy()
}

if speed > 6 speed = 6