if !loops or (area == 7 && subarea == 3) or
area == 100 or
area == 0 or (area == 106 && subarea == 3) or
area == 107 {
    novans = 1
} else novans = 0

if area == 100 {
    GameCont.crownvisits ++
}

underwater = (area == area_oasis)