function scrLoadLoadout() {
    var allcrowns = 1
    var anycrown = 0

    for (var i = 1; i <= racemax; i++) {
        allcrowns = 1

        race_crown[i, 0] = 1
        race_crown[i, 1] = 1

        for (var c = 1; c <= crownmax; c++) {
            race_crown[i, c] = save_get_value("crowngot" + string(i), string(c), 0)

            if !race_crown[i, c] {
                allcrowns = 0
            } else if c > 1 {
                anycrown = 1
            }
        }

        race_skin[i] = UberCont.cskingot[i]

        if allcrowns {
            scrAchievement(38)
        }
    }

    if anycrown scrAchievement(22)
}