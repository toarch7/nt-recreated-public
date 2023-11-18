image_index = choose(0, 0, 0, 0, 0, 0, 0, 1, 2)
image_speed = 0
if random(500) < 1 image_index = 3 image_index += choose(0, 4)

if instance_exists(FloorMaker) styleb = instance_nearest(x, y, FloorMaker).styleb
else styleb = 0

var area;
if !instance_exists(MenuGen) && !instance_exists(Menu) area = GameCont.area
else area = 0

sprite_index = asset_get_index("sprFloor" + string(area))
//sprite_index = sprFloorCV

if styleb = 1 and area != 0 {
    depth = 9
    sprite_index = asset_get_index("sprFloor" + string(area) + "B")
}

material = 1

if GameCont.area == 1 {
    material = 1
    if styleb == 1 material = 4
}

if GameCont.area == 2 {
    material = 2
    if styleb material = 3
}

if GameCont.area == 3 {
    material = 2
}

if GameCont.area == 4 {
    material = 2
    if styleb material = 5
}

if GameCont.area == 5 {
    material = 1
    if styleb material = 3
}

if GameCont.area == 6 {
    material = 2
    if styleb material = 3
}

if GameCont.area == 7 {
    material = 2
}

if GameCont.area == 100 {
    material = 2
}

if GameCont.area == 101 {
    material = 1
    if styleb material = 4
}

if GameCont.area == 102 {
    material = 2
    if styleb material = 3
}

if GameCont.area == 103 {
    material = 1
}

if GameCont.area == 104 {
    material = 2
    if styleb material = 5
}

if GameCont.area == 105 {
    material = 4
}

if GameCont.area == 106 {
    material = 2
    if styleb material = 3
}

if GameCont.area == 107 {
    material = 1
}
