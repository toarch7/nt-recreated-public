

with Floor {
    if !position_meeting(x - 16, y - 16, Floor) instance_create(x - 16, y - 16, Wall)
    if !position_meeting(x, y - 16, Floor) instance_create(x, y - 16, Wall)
    if !position_meeting(x + 16, y - 16, Floor) instance_create(x + 16, y - 16, Wall)
    if !position_meeting(x + 32, y - 16, Floor) instance_create(x + 32, y - 16, Wall)
    if !position_meeting(x + 32, y, Floor) instance_create(x + 32, y, Wall)
    if !position_meeting(x + 32, y + 16, Floor) instance_create(x + 32, y + 16, Wall)
    if !position_meeting(x - 16, y, Floor) instance_create(x - 16, y, Wall)
    if !position_meeting(x - 16, y + 16, Floor) instance_create(x - 16, y + 16, Wall)
    if !position_meeting(x - 16, y + 32, Floor) instance_create(x - 16, y + 32, Wall)
    if !position_meeting(x, y + 32, Floor) instance_create(x, y + 32, Wall)
    if !position_meeting(x + 16, y + 32, Floor) instance_create(x + 16, y + 32, Wall)
    if !position_meeting(x + 32, y + 32, Floor) instance_create(x + 32, y + 32, Wall)
}
/*
if !instance_exists(Player)
scrSpawnPlayer(global.coop ? global.index : 0, GameCont.race)
*/
if instance_exists(Player) {
    with Player {
        depth = -2
        visible = 1

        x = 10016
        y = 10016
        angle = 0
        instance_create(x, y, PortalClear)
		
		if skill_get(8) && !instance_exists_var(GammaGuts, "creator", id) {
		    with instance_create(x, y, GammaGuts) {
		        creator = other.id
		    }
		}
	}
	
	with WepPickup {
        if persistent {
            persistent = false
            visible = 1
			
            x = 10016
			y = 10016
			
            mask_index = mskWepPickup
			
            motion_add(random(360), 1.5 + random(1))
        }
    }
}


if instance_exists(Player) {
    view_xview = 10016 - view_width / 2
    view_yview = 10016 - view_height / 2

    with Crown {
        x = 10016
        y = 10016
        alarm[2] = 1
    }
}

if !(GameCont.area == 7 && GameCont.subarea == 3) && !(GameCont.area == 106 && GameCont.subarea == 3) {
    if safespawn {
        with RadChest {
            x += lengthdir_x(other.safefloors * 32, other.safedir)
            y += lengthdir_y(other.safefloors * 32, other.safedir)
        }
    }

    scrPopulate()
	
	if instance_exists(TutCont) {
		with enemy {
			if object_index != TutorialTarget
				instance_destroy(id, 0)
		}
		
		with Wall {
			if place_meeting(x, y, Floor)
				instance_destroy()
		}
		
		with chestprop
			instance_destroy(id, 0)
		
		with RadChest
			instance_destroy(id, 0)
		
		with WantBoss
			instance_destroy()
		
		with WantPopo
			instance_destroy()
	}

    with Floor {
        if GameCont.area == 0 && instance_exists(Player) && (rng_random(1, 10 + GameCont.hard) > GameCont.hard or !instance_exists(IDPDSpawn)) {
            if instance_number(IDPDSpawn) < 5 + GameCont.loops instance_create(x + 16, y + 16, IDPDSpawn)
        }
    }
} else {
    with WeaponChest instance_destroy(id, 0)
    with RadChest instance_destroy(id, 0)
    with AmmoChest instance_destroy(id, 0)
}

var flor = instance_furthest(10000, 10000, Floor)

if GameCont.area == 3 && GameCont.subarea == 3 {
    var dir = instance_furthest(10016, 10016, Floor)

    if dir {
        var dis = point_distance(10016, 10016, dir.x, dir.y)
        var dirct = point_direction(10016, 10016, dir.x, dir.y)

        var dar = instance_nearest(10016 + lengthdir_x(dis * 0.75, dirct), 10016 + lengthdir_y(dis * 0.75, dirct), Floor)

        with instance_create(dar.x + 16, dar.y + 16, BecomeScrapBoss) {
            xprevious = x
            yprevious = y
        }

        /*with enemy {
	        if point_distance(x, y, BecomeScrapBoss.x, BecomeScrapBoss.y) < 96 && random(2) < 1 {
	            instance_destroy(id, 0)
			}
		}*/
    }
}

if GameCont.area == 5 && GameCont.subarea == 3 instance_create(flor.x + 16, flor.y + 16, LilHunter)

if (GameCont.area == 4 or GameCont.area == 104) && GameCont.loops instance_create(flor.x + 16, flor.y + 16, HyperCrystal)

if GameCont.area == 2 && GameCont.loops instance_create(flor.x + 16, flor.y + 16, BallMum)

with Floor {
    instance_create(x - 32, y, Top)
    instance_create(x + 32, y, Top)
    instance_create(x - 32, y + 32, Top)
    instance_create(x + 32, y + 32, Top)
    instance_create(x - 32, y - 32, Top)
    instance_create(x + 32, y - 32, Top)
    instance_create(x, y + 32, Top)
    instance_create(x, y - 32, Top)
}

alarm[1] = 2