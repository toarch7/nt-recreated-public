var area;
if !instance_exists(MenuGen) && !instance_exists(Menu) area = GameCont.area
else area = 0

sprite_index = asset_get_index("sprFloor" + string(area) + "Explo")

image_speed = 0
image_index = choose(1, 2, 3, 4)

/*instance_create(x - 32, y, Top)
instance_create(x, y - 32, Top)
instance_create(x, y + 32, Top)
instance_create(x + 32, y, Top)
instance_create(x - 32, y - 32, Top)
instance_create(x + 32, y - 32, Top)
instance_create(x - 32, y + 32, Top)
instance_create(x + 32, y + 32, Top)*/

if !position_meeting(x - 16, y, Floor) && !position_meeting(x - 16, y, Wall) ds_list_add(UPDATE_WALLS, instance_create(x - 16, y, Wall))

if !position_meeting(x + 16, y, Floor) && !position_meeting(x + 16, y, Wall) ds_list_add(UPDATE_WALLS, instance_create(x + 16, y, Wall))

if !position_meeting(x, y + 16, Floor) && !position_meeting(x, y + 16, Wall) ds_list_add(UPDATE_WALLS, instance_create(x, y + 16, Wall))

if !position_meeting(x, y - 16, Floor) && !position_meeting(x, y - 16, Wall) ds_list_add(UPDATE_WALLS, instance_create(x, y - 16, Wall))

if !position_meeting(x - 16, y + 16, Floor) && !position_meeting(x - 16, y + 16, Wall) ds_list_add(UPDATE_WALLS, instance_create(x - 16, y + 16, Wall))

if !position_meeting(x + 16, y - 16, Floor) && !position_meeting(x + 16, y - 16, Wall) ds_list_add(UPDATE_WALLS, instance_create(x + 16, y - 16, Wall))

if !position_meeting(x + 16, y + 16, Floor) && !position_meeting(x + 16, y + 16, Wall) ds_list_add(UPDATE_WALLS, instance_create(x + 16, y + 16, Wall))

if !position_meeting(x - 16, y - 16, Floor) && !position_meeting(x - 16, y - 16, Wall) ds_list_add(UPDATE_WALLS, instance_create(x - 16, y - 16, Wall))

with BackCont {
    shake += 2
}

if !instance_exists(GenCont) && !instance_exists(MenuGen) {
    instance_create(x + 8 + random(8) - 4, y + 8 + random(8) - 4, Debris)
    snd_play_hit(sndWallBreak, 0.2)
}

styleb = 0

material = 2

with Wall {
    if object_index == InvisiWall
    continue

    if distance_to_object(other) <= 64 {
        if position_meeting(x, y, FloorExplo) {
            instance_destroy() continue
        }

        if position_empty(x + 16, y) instance_create(x + 16, y, TopSmall)
        if position_empty(x - 16, y) instance_create(x - 16, y, TopSmall)

        if position_empty(x, y + 16) instance_create(x, y + 16, TopSmall)
        if position_empty(x, y - 16) instance_create(x, y - 16, TopSmall)

        if position_empty(x + 16, y + 16) instance_create(x + 16, y + 16, TopSmall)
        if position_empty(x - 16, y - 16) instance_create(x - 16, y - 16, TopSmall)

        if position_empty(x + 16, y - 16) instance_create(x + 16, y - 16, TopSmall)
        if position_empty(x - 16, y + 16) instance_create(x - 16, y + 16, TopSmall)

        visible = place_meeting(x, y + 16, Floor)

        if place_free(x - 16, y) l = 0
        else l = 4

        if place_free(x + 16, y) w = 24 - l
        else w = 20 - l

        if place_free(x, y - 16) r = 0
        else r = 4

        if place_free(x, y + 16) h = 24 - r
        else h = 20 - r
    }
}