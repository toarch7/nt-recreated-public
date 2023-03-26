#region make menu
mode = 0

image_speed = 0

widescreen = 36

if global.is_server {
    instance_create(0, 0, GoButton)
}

scrRaces()
scrCrowns()

race = 0
crown = 1

char = array_create(15, noone)

char[0] = instance_create(64, 64, Campfire)
char[0].num = 0

if UberCont.cgot[1] {
    char[1] = instance_create(64, 32, CampChar)
    char[1].sprite_index = sprFishMenu
    char[1].spr_menu = sprFishMenuSelected
    char[1].spr_to = sprFishMenuSelect
    char[1].spr_from = sprFishMenuDeselect
    char[1].spr_slct = sprFishMenu
    char[1].num = 1

    instance_create(64, 34, LogMenu)
}

if UberCont.cgot[2] {
    char[2] = instance_create(64, 96, CampChar)
    char[2].sprite_index = sprCrystalMenu
    char[2].spr_menu = sprCrystalMenuSelected
    char[2].spr_to = sprCrystalMenuSelect
    char[2].spr_from = sprCrystalMenuDeselect
    char[2].spr_slct = sprCrystalMenu
    char[2].num = 2
}

if UberCont.cgot[3] {
    char[3] = instance_create(104, 64, CampChar)
    char[3].sprite_index = sprEyesMenu
    char[3].spr_menu = sprEyesMenuSelected
    char[3].spr_to = sprEyesMenuSelect
    char[3].spr_from = sprEyesMenuDeselect
    char[3].spr_slct = sprEyesMenu
    char[3].num = 3
}

if UberCont.cgot[4] {
    char[4] = instance_create(24, 64, CampChar)
    char[4].sprite_index = sprMeltingMenu
    char[4].spr_menu = sprMeltingMenuSelected
    char[4].spr_to = sprMeltingMenuSelect
    char[4].spr_from = sprMeltingMenuDeselect
    char[4].spr_slct = sprMeltingMenu
    char[4].num = 4
}

if instance_exists(Campfire) {
    view_xview = Campfire.x - view_width / 2
    view_yview = Campfire.y - view_height / 2
}

var allchars = [5, 6, 7, 8, 9, 10, 11, 12]

if UberCont.april_fools array_push(allchars, 13) if UberCont.cgot[14] array_push(allchars, 14)
if UberCont.cgot[15] array_push(allchars, 15)

for (var i = 0; i < array_length(allchars); i++) {
    var dir = allchars[i]

    if UberCont.cgot[dir] {
        char[dir] = instance_create(64, 48, CampChar)
        char[dir].num = dir

        char[dir].sprite_index = asset_get_index("sprMutant" + string(dir) + "Idle")

        with char[dir] {
            do {
                x = xstart
                y = ystart

                move_contact_solid(random(360), 32 + random(32) + random(64) * random(1))

                x = round(x)
                y = round(y)

                xprevious = y
                yprevious = y
            }

            until distance_to_object(CampChar) >= 16 && (dir != 9 or(!collision_circle(x, y - 32, 16, CampChar, 1, 1)))
        }
    }
}

if UberCont.cgot[5] {
    char[5].sprite_index = sprPlantMenu
    char[5].spr_menu = sprPlantMenuSelected
    char[5].spr_to = sprPlantMenuSelect
    char[5].spr_from = sprPlantMenuDeselect
    char[5].spr_slct = sprPlantMenu
}

if UberCont.cgot[6] {
    char[6].sprite_index = sprVenuzMenu
    char[6].spr_menu = sprVenuzMenuSelected
    char[6].spr_to = sprVenuzMenuSelect
    char[6].spr_from = sprVenuzMenuDeselect
    char[6].spr_slct = sprVenuzMenu
}
if UberCont.cgot[7] {
    char[7].sprite_index = sprSteroidsMenu
    char[7].spr_menu = sprSteroidsMenuSelected
    char[7].spr_to = sprSteroidsMenuSelect
    char[7].spr_from = sprSteroidsMenuDeselect
    char[7].spr_slct = sprSteroidsMenu
}

if UberCont.cgot[8] {
    char[8].sprite_index = sprRobotMenu
    char[8].spr_menu = sprRobotMenuSelected
    char[8].spr_to = sprRobotMenuSelect
    char[8].spr_from = sprRobotMenuDeselect
    char[8].spr_slct = sprRobotMenu
}

if UberCont.cgot[9] && instance_exists(char[9]) {
    char[9].sprite_index = sprChickenMenu
    char[9].spr_menu = sprChickenMenuSelected
    char[9].spr_to = sprChickenMenuSelect
    char[9].spr_from = sprChickenMenuDeselect
    char[9].spr_slct = sprChickenMenu

    with instance_create(char[9].x + orandom(2), char[9].y + orandom(4) - 32, TV) {
        instance_create(x, y, PortalClear)
    }
}

if UberCont.cgot[10] {
    char[10].sprite_index = sprRebelMenu
    char[10].spr_menu = sprRebelMenuSelected
    char[10].spr_to = sprRebelMenuSelect
    char[10].spr_from = sprRebelMenuDeselect
    char[10].spr_slct = sprRebelMenu
}

if UberCont.cgot[11] {
    char[11].sprite_index = sprHorrorMenu
    char[11].spr_menu = sprHorrorMenuSelected
    char[11].spr_to = sprHorrorMenuSelect
    char[11].spr_from = sprHorrorMenuDeselect
    char[11].spr_slct = sprHorrorMenu
}

if UberCont.cgot[12] {
    char[12].sprite_index = sprRogueMenu
    char[12].spr_menu = sprRogueMenuSelected
    char[12].spr_to = sprRogueMenuSelect
    char[12].spr_from = sprRogueMenuDeselect
    char[12].spr_slct = sprRogueMenu
}

if UberCont.april_fools && UberCont.cgot[13] {
    with char[13] {
        sprite_index = sprScrapBossSleep
        spr_menu = sprScrapBossIdle
        spr_to = sprScrapBossIntro
        spr_from = sprScrapBossSleepHurt
        spr_slct = sprScrapBossSleep
        race = 13

        instance_create(x - 32, y, PortalClear)
        instance_create(x + 32, y, PortalClear)
        instance_create(x, y - 32, PortalClear)
        instance_create(x, y + 32, PortalClear)

        mask_index = mskScrapBoss
    }
}

for (var i = 0; i <= 12 + UberCont.april_fools; i++) {
    with instance_create(0, 0, CharSelect) {
        num = i

        image_index = num
        pos = num
    }
}

if UberCont.cgot[14] {
    with char[14] {
        sprite_index = sprMutant14Idle
        spr_menu = sprMutant14Idle
        spr_to = sprMutant14Idle
        spr_from = sprMutant14Idle
        spr_slct = sprMutant14Idle
    }

    with instance_create(0, 0, CharSelect) {
        num = 14

        image_index = i++pos = image_index
    }
}

if UberCont.cgot[15] {
    with char[15] {
        sprite_index = sprMutant15Idle
        spr_menu = sprMutant15Idle
        spr_to = sprMutant15Idle
        spr_from = sprMutant15Idle
        spr_slct = sprMutant15Idle
        race = 15
    }

    with instance_create(0, 0, CharSelect) {
        num = 15

        image_index = i++pos = image_index
    }
}

if !UberCont.opt_resolution && i > 13 {
    with GoButton instance_destroy()
}

#endregion

img = 0
wave = 0
p = 0
port_x = 0
ports_x = [0, 0, 0, 0]
splat_index = 0

alarm[10] = 3

///Loadout
scrCrowns()
scrRaces()
scrWeapons()

race_crown = UberCont.race_crown
race_skin = UberCont.race_skin

loadout = 0
loadout_frame = 0
loadout_crown = 1

weekly = 0

if UberCont.weekly_run {
    if !is_undefined(UberCont.weekly_data) {
        var inst = playerinstance_get(global.index)
		
        inst.race = UberCont.weekly_data[? "char"] ?? 1
        inst.cwep = UberCont.weekly_data[? "startwep"] ?? 1
        inst.skin = UberCont.weekly_data[? "bskin"] ?? 0

        loadout_crown = UberCont.weekly_data[? "crown"] ?? 1

        with CharSelect {
            instance_destroy()
        }

        with instance_create(0, 0, CharSelect) {
            num = inst.race
            selected = 1
            pos = 0
        }
    }

    weekly = 1
}

hint = ""

with CampChar {
    instance_create(x, y, PortalClear)
}

with MusCont {
    audio_stop_sound(amb)
    amb = custom_sound_check(amb0)
    snd_loop(amb)
}

event_user(0)

dailylistfavor = 0
