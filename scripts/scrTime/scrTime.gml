function scrTime(secs) {
    var hors = 0
    var mins = 0

    while secs > 3600 {
        secs -= 3600;
        hors++
    }
    while secs > 60 {
        secs -= 60;
        mins++
    }

    return string_pad_zeroes(hors, 1) + ":" + string_pad_zeroes(mins, 1) + ":" + string_pad_zeroes(secs, 1)
}

function scrTimeSpeedrun(frames) {
    var mins = 0
    var secs = 0

    while frames >= 30 {
        frames -= 30
        secs++
    }

    while secs >= 60 {
        mins ++
		secs -= 60
    }

    return string_pad_zeroes(mins, 1) + ":" + string_pad_zeroes(secs, 1) + "." + string_pad_zeroes(round(frames / 30 * 100), 1)
}