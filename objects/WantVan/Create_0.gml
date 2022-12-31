target = -1
if ((GameCont.area == 100) || (((GameCont.area == 7) && (GameCont.subarea == 3)) || ((GameCont.area == 0) || (GameCont.area == 107)))) instance_destroy()
enemies = instance_number(enemy)
spawnmoment = (0.2 + random(0.4))
canspawn = 0