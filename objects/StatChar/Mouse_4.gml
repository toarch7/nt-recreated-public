if UberCont.cgot[num] or UberCont.weekly_run {
    snd_play(sndClick)

    with StatChar {
        selected = (id == other.id)
    }

    DrawStats.select = num
}

if !UberCont.cgot[num] with Menu {
    alarm[11] = 90
    hint = "locked#" + race_lock[other.num]
}