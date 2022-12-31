function scrMoveTopPots() {
    with TopPot {
        do {
            var top = instance_nearest(x, y, TopSmall)

            if !top {
                instance_destroy()
                break
            }

            x = top.x
            y = top.y

            xprevious = x
            yprevious = y

            if place_meeting(x, y, Floor) {
                instance_destroy(top)
            }
        }
        until !place_meeting(x, y, Floor)
    }
}