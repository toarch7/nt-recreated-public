if !instance_exists(Portal) && !instance_exists(GenCont) && !scr_check_enemies() && GameCont.area != 107 && !instance_exists(Menu) && !instance_exists(RadMaggotChest) && !instance_exists(BecomeScrapBoss) && !(GameCont.area == 106 && GameCont.subarea == 3) && !(GameCont.area == 7 && GameCont.subarea == 3) && instance_exists(Player) {
    if !instance_exists(CrownGuardian) && !instance_exists(VaultStatue) && !instance_exists(CrownPickup) {
        if GameCont.area {
            if GameCont.area != 107 {
                if distance_to_object(Floor) > 1 {
                    var flor = instance_nearest(x, y, Floor)
                    x = flor.x + flor.sprite_width / 2
                    y = flor.y + flor.sprite_height / 2
                }

                with instance_create(x, y, Portal) {
                    type = 1

                    if GameCont.area == 106 {
                        type = 2
                    }
                }
            }
        }
		else if !instance_exists(IDPDSpawn) && !instance_exists(Nothing2Appear) && !instance_exists(Nothing2) && !instance_exists(NothingSpiral) {
            instance_create(x, y, Nothing2Appear)
        }
    }
}