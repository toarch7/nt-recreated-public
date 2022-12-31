with(other) {
    instance_destroy()
    instance_create(x, y, FloorExplo)
}
break_walls -= 1
if (break_walls < 0) drive = 0