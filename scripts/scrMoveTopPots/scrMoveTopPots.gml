function scrMoveTopPots() {
    with (TopPot) {
        do {
            var _top = instance_nearest(x, y, TopSmall)

            if !instance_exists(_top) {
                instance_destroy()
                break
            }

            x = _top.x
            y = _top.y

            xprevious = x
            yprevious = y

            if (place_meeting(x, y, Floor)) {
                instance_destroy(_top)
            }
        }
        until !place_meeting(x, y, Floor)
    }
}