scrDrop(30, 2)

if !irandom(4) {
    repeat 2 {
        with instance_create(x, y, InvSpider) {
            raddrop = 0
            givekill = 0
        }
    }
}

event_inherited()