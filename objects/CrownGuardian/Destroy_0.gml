event_inherited()
instance_create(x, y, PortalClear)
scrDrop(50, 0)

if instance_number(object_index) <= 1 {
    with MusCont {
        alarm[1] = 1
    }
}