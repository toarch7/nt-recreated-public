if position_meeting(x, y, Wall) {
    instance_destroy()
    exit
}

var area;
if !instance_exists(MenuGen) && !instance_exists(Menu) {
    area = GameCont.area
} else area = 0

sprite_index = asset_get_index("sprWall" + string(area) + "Trans")

image_index = irandom(7)
image_speed = 0