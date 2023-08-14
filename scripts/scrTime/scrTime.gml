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

    return scrAddZero(hors, 1) + ":" + scrAddZero(mins, 1) + ":" + scrAddZero(secs, 1)
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

    return scrAddZero(mins, 1) + ":" + scrAddZero(secs, 1) + "." + scrAddZero(round(frames / 30 * 100), 1)
}