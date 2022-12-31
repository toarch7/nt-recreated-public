var area = 0

if !instance_exists(MenuGen) && !instance_exists(Menu) {
    area = GameCont.area
}

topspr = asset_get_index("sprWall" + string(area) + "Top")
outspr = asset_get_index("sprWall" + string(area) + "Out")
sprite_index = asset_get_index("sprWall" + string(area) + "Bot")
image_speed = 0

image_index = choose(0, 0, 0, 0, 0, 0, 0, 1, 2)
if random(150) < 1 image_index = 3 image_index += choose(0, 4)

topindex = choose(0, 0, 0, 0, 0, 0, 0, 1, 2)
if random(200) < 1 topindex = 3 topindex += choose(0, 4) outindex = choose(0, 0, 0, 0, 1, 2, 3, 4)
outindex += choose(0, 4)
if !place_meeting(x, y + 16, Floor) visible = 0

with Wall {
    if object_index == InvisiWall
    continue

    if distance_to_object(other) <= 64 or id == other.id {
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