var _bones = []

with Bones {
    array_push(_bones, id)
}

bones = _bones

array_sort(bones, function(a, b) {
    return a.y - b.y
})

alarm[0] = 30

if UberCont.opt_walls {
    with TopPot {
        if !place_meeting(x, y, TopSmall) {
            instance_destroy()
        }
    }
}