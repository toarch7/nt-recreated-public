function scrInitStats() {
    if object_index != UberCont {
        scrRaces()
        scrCrowns()
    }

    tot_time = 0

    race = 0

    widescreen = 32

    all_kill = 0
    all_dead = 0
    all_loop = 0
    all_time = 0

    progress = 0
    mouseover = -1
    maxprogress = 0
    maxraceprogress = 0

    select = 0

    for (var c = 1; c <= 12; c++) {
        all_kill += ctot_kill[c]
        all_dead += ctot_dead[c]
        all_time += ctot_time[c]
        all_loop += ctot_loop[c]

        race_prog[c] = 0

        for (i = 1; i <= crownmax; i++) {
            maxprogress++maxraceprogress++
            if crowngot[c, i] {
                progress++
            }
        }

        if cwep[c] != race_swep[c] {
            race_prog[c]++
        }

        maxraceprogress++maxprogress++
        if cgot[c] progress++

        maxprogress++

        if cskingot[c] {
            race_prog[c]++progress++
        }
    }

    view_xview = 0
    view_yview = 0

    if progress >= maxprogress {
        scrAchievement(43)
    }
}