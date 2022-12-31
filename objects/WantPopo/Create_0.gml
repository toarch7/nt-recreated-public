GameCont.popolevel -= 0.5
target = -1

if GameCont.area == 100 or GameCont.area == 0 or(GameCont.area == 7 && GameCont.subarea == 3) or GameCont.area == 107
instance_destroy()

enemies = instance_number(enemy)
spawnmoment = 0.2 + random(0.6)