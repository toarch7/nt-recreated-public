var _dir = random(360)
var _dis = random(128)

var X = x + lengthdir_x(_dis, _dir)
var Y = y + lengthdir_y(_dis, _dir)

if !place_meeting(X, Y, Wall) && place_meeting(X, Y, Floor) {
    x = X
    y = Y

    if !irandom(7) {
        alarm[3] = 15
    }
} else {
    alarm[3] = 1
    x = xprevious
    y = yprevious
}